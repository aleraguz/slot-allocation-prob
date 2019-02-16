function [new_sol,new_colonna_slot_assegnati, indicemossamigliore,new_funz_ob] = Permutazioni(mosseSwap,num_mosse_swap,mossevel,current_voli,current_sol, capacita_slot, funz_ob,num_voli)

% inizializzazioni
temp_colonna = cell2mat(current_voli(2:(num_voli+1),5));
temp_sol = current_sol;
colonna_slot_assegnati = cell2mat(current_voli(2:(num_voli+1),5));
indicemossamigliore = 0;
new_sol = current_sol;
new_colonna_slot_assegnati=temp_colonna;
new_funz_ob = funz_ob;
lung_mosse_vel =length(mossevel);
check = 0;
for i=1 : num_mosse_swap
    if lung_mosse_vel > 0
        check = CheckMossaTabu(mossevel,mosseSwap{i});
    end
    if check == 0
        nuova_mossa=mosseSwap{i};
        slot_1 = colonna_slot_assegnati(nuova_mossa(1));
        slot_2 = colonna_slot_assegnati(nuova_mossa(2));
        
        if(slot_1 ~= slot_2)
            current_sol = Elimina(nuova_mossa(1),slot_1,current_sol);
            current_sol = Elimina(nuova_mossa(2),slot_2,current_sol);
            [current_sol, colonna_slot_assegnati] = InsertVelocizzato(nuova_mossa(1),slot_2, current_sol, colonna_slot_assegnati);
            [current_sol, colonna_slot_assegnati] = InsertVelocizzato(nuova_mossa(2),slot_1, current_sol, colonna_slot_assegnati);
            current_funz_ob = round(FunzioneObVelocizzata(current_sol, current_voli, colonna_slot_assegnati,capacita_slot));
            
            if(current_funz_ob < new_funz_ob)
                new_funz_ob = current_funz_ob;
                new_sol = current_sol;
                new_colonna_slot_assegnati =colonna_slot_assegnati;
                indicemossamigliore=i;
            end
        end
    end
    
    colonna_slot_assegnati = temp_colonna;
    current_sol = temp_sol;
end


