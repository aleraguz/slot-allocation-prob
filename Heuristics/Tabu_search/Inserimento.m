function [best_sol,  best_colonna_slot_assegnati,best_funz_ob] = Inserimento(current_sol,current_voli,intorno,num_slot,voli_cancellati,num_voli_cancellati,best_funz_ob,num_voli,slot_voli_cancellati,capacita_slot)
%INSERIMENTO dei voli cancellati
colonna_slot_assegnati = cell2mat(current_voli(2:(num_voli+1),5));
best_sol =current_sol;
best_colonna_slot_assegnati =colonna_slot_assegnati;
for j=1 :num_voli_cancellati
    temp_colonna = cell2mat(current_voli(2:(num_voli+1),5));
    temp_sol = current_sol;
    
    %generazione mosse insert
    if(~isempty(voli_cancellati))
        mosseInsert= GeneraMosseInsert(num_slot, num_voli_cancellati,voli_cancellati,current_voli,intorno);
        num_mosse_insert = length(mosseInsert);
        
        for i=1 : num_mosse_insert
            nuova_mossa=mosseInsert{i};
            if(current_sol{nuova_mossa(2),2}>0)
                [current_sol, colonna_slot_assegnati] = InsertVelocizzato(nuova_mossa(1),nuova_mossa(2),current_sol,colonna_slot_assegnati);
                %elimina da cancellati il volo inserito
                current_sol = Elimina(nuova_mossa(1),slot_voli_cancellati, current_sol);
                current_funz_ob = FunzioneObVelocizzata(current_sol, current_voli,colonna_slot_assegnati,capacita_slot);
                
                if(current_funz_ob < best_funz_ob)
                    best_funz_ob= round(current_funz_ob);
                    best_sol = current_sol;
                    best_colonna_slot_assegnati =colonna_slot_assegnati;
                    
                end
                % ripristino tabella voli e la soluzione
                colonna_slot_assegnati = temp_colonna;
                current_sol = temp_sol;
                
            end
        end
        voli_cancellati =  best_sol{slot_voli_cancellati,1};
        num_voli_cancellati= length(voli_cancellati);
        colonna_slot_assegnati = best_colonna_slot_assegnati;
        current_sol = best_sol;
        current_voli = RiempimentoArrayVoli(current_voli,colonna_slot_assegnati,num_voli);
    end
end


