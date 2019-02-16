function [sol_fifo, colonna_slot_assegnati] = FifoConsecutivi(arrayVoli, capacita_slot, num_slot,num_voli, intorno)
%inserimento FIFO anche in slot non desiderati ma nell'intorno
colonna_slot_assegnati = cell2mat(arrayVoli(2:(num_voli+1),5));
colonna_voli_slot_des(:,1) = cell2mat(arrayVoli(2:(num_voli+1),4));
[colonna_voli_slot_des indici] = sort(colonna_voli_slot_des, 'ascend'); % ordino i voli in ordine crescente di slot desiderati

sol_fifo = cell(num_slot, 2);
for i= 1:num_slot-1
sol_fifo{i,2}= capacita_slot; 
end
sol_fifo{num_slot,2} = num_voli;

voli_da_inserire = indici;
slot =1; 

for i=1: num_voli
    inserito = false; 
    slot_desiderato = colonna_voli_slot_des(i);
    shift = abs(slot_desiderato-slot);
    
    while(~inserito)
     if sol_fifo{slot,2} > 0 && shift<=intorno
         [sol_fifo, colonna_slot_assegnati] = InsertVelocizzato(voli_da_inserire(i),slot, sol_fifo, colonna_slot_assegnati);
         inserito = true;
     elseif shift > intorno
           [sol_fifo, colonna_slot_assegnati]  = InsertVelocizzato(voli_da_inserire(i),num_slot, sol_fifo,colonna_slot_assegnati); 
           inserito =true;
     else 
         slot =slot+1;
     end
    end
end

