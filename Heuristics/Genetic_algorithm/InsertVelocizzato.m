function [colonna_slot_assegnati,colonna_capacita] = InsertVelocizzato(ind_volo,slot,colonna_slot_assegnati,colonna_capacita) %%aggiungere array di voli e modificare slot

%if colonna_capacita(slot)>0
colonna_slot_assegnati(ind_volo)=slot;
colonna_capacita(slot) = colonna_capacita(slot)-1; 
%end



