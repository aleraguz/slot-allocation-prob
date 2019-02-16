function [popolazione,popolazione_capacita_slot,fitness] = GenerazionePopolazione(colonna_capacita_slot, array_voli,num_slot,intorno,num_voli,funz_ob_inziale)

soluz_iniz_capacita_slot = colonna_capacita_slot;
soluz_iniz_slot_desiderati = array_voli(:,2);
soluz_iniz_slot_assegnati = array_voli(:,3);
colonna_slot_desiderati = soluz_iniz_slot_desiderati;
colonna_slot_assegnati = soluz_iniz_slot_assegnati;

%% inserisco mosse da voli cancellati
for i=1:1000
    
    alfa=randi([0 10],1,1);
    slot_capacita_residua = find(colonna_capacita_slot>0);
    voli_da_inserire = find(ismember(colonna_slot_assegnati,slot_capacita_residua));
    num_voli_da_inserire= length(voli_da_inserire);
    
    for j=1:alfa
        mosseInsert = GeneraMosseInsert(voli_da_inserire,num_slot, num_voli_da_inserire,colonna_capacita_slot, colonna_slot_desiderati,colonna_slot_assegnati,intorno);
        if (~isempty(mosseInsert))
            beta=randi([1 length(mosseInsert)],1,1);
            if(colonna_capacita_slot(mosseInsert(beta,2))>0)
                slot = colonna_slot_assegnati(mosseInsert(beta,1));
                [colonna_slot_assegnati,colonna_capacita_slot] = InsertVelocizzato(mosseInsert(beta,1),mosseInsert(beta,2),colonna_slot_assegnati,colonna_capacita_slot);
                colonna_capacita_slot(slot) = colonna_capacita_slot(slot)+1; %ELIMINA
                slot_capacita_residua = find(colonna_capacita_slot>0);
                voli_da_inserire =  find(ismember(colonna_slot_assegnati,slot_capacita_residua));
                num_voli_da_inserire= length(voli_da_inserire);
            end
        end
    end

    %% permutazioni
    
    alfa=randi([0 10],1,1);
    
    for j=1 : alfa
        mosseSwap= GeneraMossaSwap(num_voli,colonna_slot_desiderati,colonna_slot_assegnati,intorno);
        beta=randi([1 length(mosseSwap)],1,1);
        
        slot_1 = colonna_slot_assegnati(mosseSwap(beta,1));
        slot_2 = colonna_slot_assegnati(mosseSwap(beta,2));
      
        if(slot_1 ~= slot_2)
            
           [colonna_slot_assegnati,colonna_capacita_slot] = InsertVelocizzato(mosseSwap(beta,1),slot_2,colonna_slot_assegnati,colonna_capacita_slot);
           colonna_capacita_slot(slot_1) = colonna_capacita_slot(slot_1)+1;
           [colonna_slot_assegnati,colonna_capacita_slot] = InsertVelocizzato(mosseSwap(beta,2),slot_1,colonna_slot_assegnati,colonna_capacita_slot);
           colonna_capacita_slot(slot_2) = colonna_capacita_slot(slot_2)+1;
        end
    end
    
    
    popolazione(:,i)=colonna_slot_assegnati;
    popolazione_capacita_slot(:,i)=colonna_capacita_slot;
    array_voli(:,3)=colonna_slot_assegnati;
    fitness(i) = FunzioneObVelocizzata(array_voli, num_slot);
    colonna_slot_assegnati = soluz_iniz_slot_assegnati;
    colonna_capacita_slot = soluz_iniz_capacita_slot;

   % voli_da_inserire=[];
end

 popolazione(:,i+1)=soluz_iniz_slot_assegnati;
 popolazione_capacita_slot(:,i+1)=soluz_iniz_capacita_slot;
 fitness(i+1) = funz_ob_inziale;

