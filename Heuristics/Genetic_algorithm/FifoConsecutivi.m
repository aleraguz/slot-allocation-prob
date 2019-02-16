function [array_voli, colonna_capacita, funz_ob] = FifoConsecutivi(array_voli, colonna_capacita, num_slot,num_voli,intorno)

%inserimento FIFO anche in slot non desiderati ma nell'intorno
colonna_slot_desiderati = array_voli(:,2);
colonna_slot_assegnati = array_voli(:,3);


[colonna_slot_desiderati indici] = sort(colonna_slot_desiderati, 'ascend'); % ordino i voli in ordine crescente di slot desiderati


% slot_fifo=zeros(num_slot,2);
% slot_fifo(:,2)=colonna_capacita;
% slot_fifo(num_voli,2)=num_voli;
 voli_da_inserire = indici;
 slot =1; 

for i=1: num_voli
    inserito = false; 
    slot_desiderato = colonna_slot_desiderati(i);
    shift = abs(slot_desiderato-slot);
    
    while(~inserito)
     if colonna_capacita(slot) > 0 && shift<=intorno
         [colonna_slot_assegnati, colonna_capacita] = InsertVelocizzato(voli_da_inserire(i),slot, colonna_slot_assegnati, colonna_capacita);
         inserito = true;
     elseif shift > intorno
           [colonna_slot_assegnati, colonna_capacita]  = InsertVelocizzato(voli_da_inserire(i),num_slot, colonna_slot_assegnati, colonna_capacita); 
           inserito =true;
     else 
         slot =slot+1;
     end
    end
end
array_voli(:,3)=colonna_slot_assegnati;

funz_ob = FunzioneObVelocizzata(array_voli,num_slot);


