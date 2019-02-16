%%% prova con nuove strutture

clear all;
clc;



[glob_voli, num_voli, num_slot, intorno, capacita_slot] = InputBassaStagione();

slot_voli_cancellati =  num_slot; %ultimo slot

%% soluzione fifo

% [sol_fifo, glob_voli] = FifoConsecutivi(glob_voli, capacita_slot, num_slot,num_voli, intorno);
% funz_ob_fifo = round(FunzioneOb(sol_fifo, glob_voli, num_slot,capacita_slot));
% glob_funz_ob = funz_ob_fifo;

%% soluzione greedy
[sol_greedy, colonna_slot_assegnati] = 	FIFO(glob_voli, capacita_slot,num_slot,num_voli,intorno);

%riempio la tabella dei voli
glob_voli = RiempimentoArrayVoli(glob_voli,colonna_slot_assegnati,num_voli);
glob_sol = sol_greedy;

% funzione obiettivo greedy
tic;
funz_ob_greedy = round(FunzioneObVelocizzata(sol_greedy, glob_voli,colonna_slot_assegnati ,capacita_slot));
toc;
glob_funz_ob = funz_ob_greedy;
clc;

% %% Inserimento

% voli_cancellati = sol_greedy{slot_voli_cancellati,1};
% num_voli_cancellati = length(voli_cancellati);
%
% current_sol = sol_greedy;
% current_voli = glob_voli;
% best_voli=current_voli;
% [best_sol,  best_colonna_slot_assegnati,best_funz_ob] = Inserimento(current_sol,current_voli,intorno,num_slot,voli_cancellati,num_voli_cancellati,funz_ob_greedy,num_voli,slot_voli_cancellati,capacita_slot);
%
% % aggiornamento variabili globali
% glob_voli = RiempimentoArrayVoli(glob_voli,best_colonna_slot_assegnati,num_voli);
% glob_funz_ob = round(best_funz_ob);
% glob_sol = best_sol;

%% PERMUTAZIONI

current_sol = glob_sol;
current_voli = glob_voli;
new_voli =glob_voli;
best_funz_ob =inf;
new_funz_ob = inf;
mosseTabu = GeneraMosseTabu(num_voli);
lung_lista_tabu = length(mosseTabu);
Tabulist =zeros(lung_lista_tabu,1);
LunghezzaListaTabu = 10;
tic;

for j=1 : 200
  
    mosseSwap= GeneraMossaSwap(num_voli,current_voli,intorno,num_slot);
    num_mosse_swap = length(mosseSwap);
    mossevel = MosseTabuVelocizzato(mosseTabu,Tabulist,lung_lista_tabu);
    [new_sol,new_colonna_slot_assegnati,indicemossamigliore, new_funz_ob] = Permutazioni(mosseSwap,num_mosse_swap,mossevel,current_voli,current_sol, capacita_slot, new_funz_ob,num_voli);
    new_voli = RiempimentoArrayVoli(new_voli,new_colonna_slot_assegnati,num_voli);
    
    %% aggiornamento lista tabu
    if indicemossamigliore ~= 0 %aggiorno se c'è miglioramento
       Tabulist= AggiornamentoTabu(mosseTabu,mosseSwap,Tabulist,indicemossamigliore,lung_lista_tabu,LunghezzaListaTabu);
        if(best_funz_ob>new_funz_ob)
            best_funz_ob=round(new_funz_ob);
            best_sol =new_sol;
            best_voli = new_voli;
        end        
        disp(['Mossa #' num2str(j) ' : [' num2str(mosseSwap{indicemossamigliore}) '] --- Fo : ' num2str(best_funz_ob)]);        
    else
        % provo a diversificare
        rand = randi([1 num_mosse_swap], 1, 1);
        for indrand=1: lung_lista_tabu
            if mosseTabu{indrand}==mosseSwap{rand}
            break;  
            end
        end
        if (Tabulist(indrand)==0)
            nuova_mossa=mosseSwap{rand};
            slot_1 = new_colonna_slot_assegnati(nuova_mossa(1));
            slot_2 = new_colonna_slot_assegnati(nuova_mossa(2));
            
            if(slot_1 ~= slot_2)
                new_sol = Elimina(nuova_mossa(1),slot_1,new_sol);
                new_sol = Elimina(nuova_mossa(2),slot_2,new_sol);
                [new_sol, new_colonna_slot_assegnati] = InsertVelocizzato(nuova_mossa(1),slot_2, new_sol, new_colonna_slot_assegnati);
                [new_sol, new_colonna_slot_assegnati] = InsertVelocizzato(nuova_mossa(2),slot_1, new_sol, new_colonna_slot_assegnati);
                new_voli = RiempimentoArrayVoli(new_voli,new_colonna_slot_assegnati,num_voli);
                new_funz_ob = round(FunzioneObVelocizzata(new_sol, new_voli, new_colonna_slot_assegnati,capacita_slot));
                fprintf(2,'Mossa # '); 
                disp([' ' num2str(j) ' : [' num2str(mosseSwap{rand}) '] --- Fo : ' num2str(new_funz_ob)]);
            end  
        end
        %aggiorno tabu
        Tabulist= AggiornamentoTabu(mosseTabu,mosseSwap,Tabulist,rand,lung_lista_tabu,LunghezzaListaTabu);
    end
    
    current_voli = new_voli;
    current_sol = new_sol;
    
%     voli_fuori_intorno = CheckSlotIntorno(best_voli,intorno, slot_voli_cancellati,num_voli);
%     if ~isempty(voli_fuori_intorno)
%         disp('Y');
%     end
end

toc;
%% Inserimento Miglioramento

current_sol=best_sol;
best2_funz_ob = best_funz_ob;
current_voli = best_voli;
voli_da_inserire=[];

[best2_voli,best2_sol,best2_funz_ob] = InserimentoMiglioramento(current_voli,current_sol,slot_voli_cancellati,voli_da_inserire,num_slot,intorno,best2_funz_ob,num_voli,capacita_slot);

%% inserimento finale
voli_cancellati = best2_sol{slot_voli_cancellati,1};
num_voli_cancellati = length(voli_cancellati);

current_sol = best2_sol;
current_voli = best2_voli;
[best3_sol,  best3_colonna_slot_assegnati,best3_funz_ob] = Inserimento(current_sol,current_voli,intorno,num_slot,voli_cancellati,num_voli_cancellati,best2_funz_ob,num_voli,slot_voli_cancellati,capacita_slot);
best3_voli = RiempimentoArrayVoli(new_voli,best3_colonna_slot_assegnati,num_voli);
fprintf(2,'RISULTATI FINALI \n'); 

miglperc = round(100-(best_funz_ob/funz_ob_greedy)*100,2);
miglperci = round(100-(best3_funz_ob/best_funz_ob)*100);
num_voli_canc1 = length(best_sol{num_slot,1});
num_voli_canc2 = length(best3_sol{num_slot,1});
num_voli_canc3 = length(sol_greedy{num_slot,1});
disp(['funz_ob iniziale: ' num2str(funz_ob_greedy) ' ; funz_ob tabu : ' num2str(best_funz_ob) ' ; funz_ob improve : ' num2str(best3_funz_ob) ';  voli canc_iniz: ' num2str(num_voli_canc1)]);
disp(['miglioramento perc : ' num2str(miglperc) ' % ; voli canc: ' num2str(num_voli_canc1) '; miglioramento improvement : ' num2str(miglperci) ' % ; voli canc : ' num2str(num_voli_canc2) ]);