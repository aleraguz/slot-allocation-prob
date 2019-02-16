function [array_voli, colonna_capacita, funz_ob] = FifoConsecutivi(array_voli, colonna_capacita, num_slot,num_voli,intorno)

%inserimento FIFO anche in slot non desiderati ma nell'intorno
colonna_slot_desiderati = array_voli(:,2);
colonna_slot_assegnati = array_voli(:,3);
colonna_slot_passeggeri = array_voli(:,1);

[colonna_slot_passeggeri indice] = sort(colonna_slot_passeggeri, 'descend'); % ordino i voli in ordine crescente di slot desiderati
[colonna_slot_desiderati ind] = sort(colonna_slot_desiderati(indice), 'ascend'); % ordino i voli in ordine crescente di slot desiderati
ind=indice(ind);



% slot_fifo=zeros(num_slot,2);
% slot_fifo(:,2)=colonna_capacita;
% slot_fifo(num_voli,2)=num_voli;
voli_da_inserire = ind;
slot =1;

for i=1: num_voli
    
    inserito = false;
    slot_desiderato = colonna_slot_desiderati(i);
    slot =slot_desiderato;
    slot_avanti =slot_desiderato;
    slot_indietro =slot_desiderato;
    indietro =true;
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
                if slot>1
                slot = slot- 1;
                passo0=false;
                else
                passo0=false;
                end
            elseif indietro
                if slot_indietro >1
                    slot =slot_indietro -1;
                    slot_indietro =slot_indietro-1;
                    indietro =false
                else
                    indietro =false
                end
                
            else
                slot =slot_avanti +1;
                slot_avanti =slot_avanti+1;
                indietro = true;
            end
        end
    end
    
end

array_voli(:,3)=colonna_slot_assegnati;

funz_ob = FunzioneObVelocizzata(array_voli,num_slot);





