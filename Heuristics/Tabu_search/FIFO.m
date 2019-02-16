function [sol_fifo, colonna_slot_assegnati] = FifoConsecutivi(arrayVoli, capacita_slot, num_slot,num_voli, intorno)
%inserimento FIFO anche in slot non desiderati ma nell'intorno
colonna_slot_assegnati = cell2mat(arrayVoli(2:(num_voli+1),5));
colonna_voli_slot_des(:,1) = cell2mat(arrayVoli(2:(num_voli+1),4));
colonna_slot_passeggeri = cell2mat(arrayVoli(2:(num_voli+1),3));
[colonna_slot_passeggeri indice] = sort(colonna_slot_passeggeri, 'descend'); % ordino i voli in ordine crescente di slot desiderati
[colonna_voli_slot_des ind] = sort(colonna_voli_slot_des(indice), 'ascend'); % ordino i voli in ordine crescente di slot desiderati
ind=indice(ind);

sol_fifo = cell(num_slot, 2);
for i= 1:num_slot-1
    sol_fifo{i,2}= capacita_slot;
end
sol_fifo{num_slot,2} = num_voli;

voli_da_inserire = ind;
slot =1;

for i=1: num_voli
    
    inserito = false;
    slot_desiderato = arrayVoli{ind(i)+1,4};
    slot =slot_desiderato;
    slot_avanti =slot_desiderato;
    slot_indietro =slot_desiderato;
    indietro =true;
    passo0 =true;
    while(~inserito)
        
        shift = abs(slot_desiderato-slot);
        
        if sol_fifo{slot,2} > 0 && shift<=intorno
            
            [sol_fifo, colonna_slot_assegnati] = InsertVelocizzato(ind(i),slot, sol_fifo, colonna_slot_assegnati);
            inserito =true;
        elseif shift>intorno
            [sol_fifo, colonna_slot_assegnati]  = InsertVelocizzato(ind(i),num_slot, sol_fifo,colonna_slot_assegnati);
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
end