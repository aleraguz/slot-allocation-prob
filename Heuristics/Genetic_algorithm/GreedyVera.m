function [array_voli, colonna_capacita, funz_ob] = GreedyVera(array_voli, colonna_capacita, num_slot,num_voli,intorno)

colonna_passeggeri_tot = array_voli(:,1)+array_voli(:,4);
colonna_slot_desiderati = array_voli(:,2);
colonna_slot_assegnati = array_voli(:,3);

[pass_ordinati, ind]= OrdinaPasseggeri(colonna_passeggeri_tot);


for i=1: num_voli
    
    inserito = false;
    slot_desiderato = colonna_slot_desiderati(ind(i));
    slot =slot_desiderato;
    slot_avanti =slot_desiderato;
    slot_indietro =slot_desiderato;
    avanti =true;
    passo0 =true;
    while(~inserito)
        
        shift = abs(slot_desiderato-slot);
       
        if colonna_capacita(slot) > 0 && shift<=intorno
            
            [colonna_slot_assegnati, colonna_capacita] = InsertVelocizzato(ind(i),slot,colonna_slot_assegnati,colonna_capacita);
            inserito =true;
        elseif shift>intorno
             [colonna_slot_assegnati, colonna_capacita] = InsertVelocizzato(ind(i),num_slot,colonna_slot_assegnati,colonna_capacita);
            inserito =true;
        else
            if passo0
                slot = slot+ 1;
                passo0=false;
            elseif avanti
                slot =slot_avanti +1;
                slot_avanti =slot_avanti+1;
                avanti =false
            else
                if slot_indietro>1
                    slot =slot_indietro -1;
                    slot_indietro =slot_indietro-1;
                    avanti = true;
                else
                    avanti = true;
                end
                
            end
        end
    end

end

array_voli(:,3)=colonna_slot_assegnati;

funz_ob = FunzioneObVelocizzata(array_voli,num_slot);





