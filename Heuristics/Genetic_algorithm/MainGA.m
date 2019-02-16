%%% prova con nuove strutture
clear all;
clc;



[glob_voli, num_voli, num_slot, intorno, capacita_slot] = InputBassaStagione();

slot_voli_cancellati =  num_slot;
colonna_passeggeri = cell2mat(glob_voli(2:(num_voli+1),3));
colonna_slot_desiderati = cell2mat(glob_voli(2:(num_voli+1),4));
colonna_slot_assegnati = cell2mat(glob_voli(2:(num_voli+1),5));
colonna_passeggeri_scalo = cell2mat(glob_voli(2:(num_voli+1),6));
colonna_tipologia_voli = cell2mat(glob_voli(2:(num_voli+1),7));

colonna_capacita = capacita_slot + zeros(num_slot-1,1);
colonna_capacita(num_slot)= num_voli;
%colonna_capacita_slot = cell2mat(sol_greedy(1:(num_slot),2));

array_voli = [colonna_passeggeri colonna_slot_desiderati colonna_slot_assegnati colonna_passeggeri_scalo colonna_tipologia_voli];
funz_ob = FunzioneObVelocizzata(array_voli,num_slot);
%% soluzione greedy
[array_voli,colonna_capacita_slot,funz_ob] = FIFO(array_voli, colonna_capacita,num_slot,num_voli,intorno);
clc;
soluzione = CostruzioneSoluzione(array_voli,colonna_capacita_slot,num_slot,num_voli);
%% genero mosse per la generazione della popolazione


%[popolazione,fitness] = GenerazionePopolazione(colonna_capacita_slot,num_slot,num_voli_cancellati,voli_cancellati,glob_voli,intorno);
tic;
[popolazione_iniziale,popolazione_capacita_slot,popolazione_fitness] = GenerazionePopolazione(colonna_capacita_slot, array_voli,num_slot,intorno,num_voli,funz_ob);
toc;

popolazione_genitori= popolazione_iniziale;
popolazione_genitori_capacita= popolazione_capacita_slot;
fitness_genitori=popolazione_fitness;
[best_fitness indice]=min(popolazione_fitness);
best_soluzione=popolazione_genitori(:,indice);
best_soluzione_capacita=popolazione_genitori_capacita(:,indice);


count=0;
tic
for h=1:10
    
    
    %algoritmo genetico vero e proprio
    [popolazione_figli,popolazione_figli_capacita,popolazione_figli_fitness] = AlgoritmoGenetico(array_voli,popolazione_genitori,popolazione_genitori_capacita,fitness_genitori,capacita_slot);
    
    
    popolazione_tot = [popolazione_genitori popolazione_figli];
    popolazione_tot_capacita = [popolazione_genitori_capacita popolazione_figli_capacita];
    popolazione_tot_fitness = [fitness_genitori popolazione_figli_fitness];
    
    %% Tolgo i doppioni
    [popolazione_tot_fitness,indice] = unique(popolazione_tot_fitness,'first');
    popolazione_tot= popolazione_tot(:,indice);
    popolazione_tot_capacita= popolazione_tot_capacita(:,indice);
    
    [popolazione_tot_fitness, ind_tot] = sort(popolazione_tot_fitness,'ascend');
    ind_tot = ind_tot(1:150);
    popolazione_d_nuova = popolazione_tot(:,ind_tot);
    popolazione_d_nuova_capacita =popolazione_tot_capacita(:,ind_tot);
    popolazione_d_nuova_fitness =popolazione_tot_fitness(:,ind_tot);
    
    
    if (best_fitness > popolazione_d_nuova_fitness(1))
        best_soluzione=popolazione_d_nuova(:,1);
        best_soluzione_capacita=popolazione_d_nuova_capacita(:,1);
        best_fitness=popolazione_d_nuova_fitness(1);
        
        count=0;
    else
        count=count+1;
    end
    
    popolazione_genitori= popolazione_d_nuova;
    popolazione_genitori_capacita= popolazione_d_nuova_capacita;
    fitness_genitori=popolazione_d_nuova_fitness;
    
    disp(['iter ' num2str(h) ' count:' num2str(count) ' --- best_fitness : ' num2str(best_fitness)]);
    
    if (count>20)
        popolazione_genitori= popolazione_iniziale;
        popolazione_genitori_capacita= popolazione_capacita_slot;
        fitness_genitori=popolazione_fitness;
        count=0;
    end
    
    
end

array_voli(:,3)=best_soluzione;
soluzione = CostruzioneSoluzione(array_voli,best_soluzione_capacita,num_slot,num_voli);

current_soluzione=best_soluzione;
current_soluzione_capacita=best_soluzione_capacita;
best2_soluzione=current_soluzione;
best2_soluzione_capacita= current_soluzione_capacita;

slot_capacita_residua = find(current_soluzione_capacita>0);
voli_da_inserire =  find(ismember(current_soluzione,slot_capacita_residua));
num_voli_da_inserire= length(voli_da_inserire);
best2_funz_ob=best_fitness;
iter =num_voli_da_inserire;
for p=1:iter
    mosseInsert = GeneraMosseInsert(voli_da_inserire,num_slot, num_voli_da_inserire,current_soluzione_capacita, colonna_slot_desiderati,current_soluzione,intorno);
    if (~isempty(mosseInsert))
        for k=1:length(mosseInsert)
            if(current_soluzione_capacita(mosseInsert(k,2))>0)
                slot = current_soluzione(mosseInsert(k,1));
                [current_soluzione,current_soluzione_capacita] = InsertVelocizzato(mosseInsert(k,1),mosseInsert(k,2),current_soluzione,current_soluzione_capacita);
                current_soluzione_capacita(slot) = current_soluzione_capacita(slot)+1; %ELIMINA
                array_voli(:,3)=current_soluzione;
                current_funz_ob=FunzioneObVelocizzata(array_voli,num_slot);
                if (best2_funz_ob > current_funz_ob)
                    best2_funz_ob=current_funz_ob;
                    best2_soluzione=current_soluzione;
                    best2_soluzione_capacita= current_soluzione_capacita;
                end
            end
            current_soluzione=best2_soluzione;
            current_soluzione_capacita=best2_soluzione_capacita;
        end
        slot_capacita_residua = find(current_soluzione_capacita>0);
        voli_da_inserire =  find(ismember(current_soluzione,slot_capacita_residua));
        num_voli_da_inserire= length(voli_da_inserire);
        
    end
end

toc
array_voli(:,3)=best2_soluzione;
soluzione2 = CostruzioneSoluzione(array_voli,best2_soluzione_capacita,num_slot,num_voli);

miglperc = round(100-(best_fitness/funz_ob)*100,2);
miglperci = round(100-(best2_funz_ob/best_fitness)*100,4);
num_voli_canc1 = length(soluzione{num_slot,1});
num_voli_canc2 = length(soluzione2{num_slot,1});
num_voli_canc3 = num_voli - colonna_capacita_slot(num_slot,1);
disp(['funz_ob iniziale: ' num2str(funz_ob) ' ; funz_ob ga : ' num2str(best_fitness) ' ; funz_ob improve : ' num2str(best2_funz_ob) ';  voli canc_iniz: ' num2str(num_voli_canc3)]);
disp(['miglioramento perc : ' num2str(miglperc) ' % voli canc : ' num2str(num_voli_canc1) '; improvement : ' num2str(miglperci) ' % ; voli canc ' num2str(num_voli_canc2)]);