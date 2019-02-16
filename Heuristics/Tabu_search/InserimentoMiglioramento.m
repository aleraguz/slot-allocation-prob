function [best2_voli,best2_sol,best2_funz_ob] = InserimentoMiglioramento(current_voli,current_sol,slot_voli_cancellati,voli_da_inserire,num_slot,intorno,best2_funz_ob,num_voli,capacita_slot)
%INSERIMENTOMIGLIORAMENTO Summary of this function goes here

colonna_slot_assegnati = cell2mat(current_voli(2:(num_voli+1),5));
best2_colonna_slot_assegnati=colonna_slot_assegnati;
best2_sol = current_sol;
best2_voli=current_voli;
%generazione voli da inserire
p=1;
for k=1:length(current_voli)-1
    slot_volo=colonna_slot_assegnati(k);
    if (current_sol{slot_volo,2}>0 && slot_volo ~= slot_voli_cancellati)
        voli_da_inserire(p)=k;
        p=p+1;
    end
end

for j=1 :voli_da_inserire
    
    %generazione mosse insert
    if(~isempty(voli_da_inserire))
        mosseInsert2= GeneraMosseInsert2(num_slot, current_voli, intorno, current_sol, voli_da_inserire);
        num_mosse_insert2 = length(mosseInsert2);
        
        for i=1 : num_mosse_insert2
            temp_colonna = cell2mat(current_voli(2:(num_voli+1),5));
            temp_sol = current_sol;
            nuova_mossa=mosseInsert2{i};
            if(current_sol{nuova_mossa(2),2}>0)
                slot_da_eliminare = colonna_slot_assegnati(nuova_mossa(1));
                [current_sol, colonna_slot_assegnati] = InsertVelocizzato(nuova_mossa(1),nuova_mossa(2),current_sol,colonna_slot_assegnati);
                %elimina da cancellati il volo inserito
                current_sol = Elimina(nuova_mossa(1),slot_da_eliminare, current_sol);
                current_funz_ob = round(FunzioneObVelocizzata(current_sol, current_voli,colonna_slot_assegnati,capacita_slot));
                
                if(current_funz_ob < best2_funz_ob)
                    best2_funz_ob= round(current_funz_ob);
                    best2_sol = current_sol;
                    best2_colonna_slot_assegnati= colonna_slot_assegnati;
                    
                    
                end
                % ripristino tabella voli e la soluzione
                colonna_slot_assegnati = temp_colonna;
                current_sol = temp_sol;
                
            end
        end
        
        best2_voli = RiempimentoArrayVoli(current_voli,best2_colonna_slot_assegnati,num_voli);
        
        l=1;
        for r=1:length(best2_voli)-1
            slot_volo=best2_voli{r+1,5};
            if (best2_sol{slot_volo,2}>0 && slot_volo ~= slot_voli_cancellati)
                voli_da_inserire(l)=r;
                l=l+1;
            end
        end
        colonna_slot_assegnati = best2_colonna_slot_assegnati;
        current_sol = best2_sol;
        current_voli = best2_voli;
    end
end
end

