function voli_fuori_intorno = CheckSlotIntorno(arrayVoli,intorno, slot_voli_cancellati,num_voli)
%CHECKSLOTINTORNO controllo se tutti i voli sono nell'intorno
voli_fuori_intorno = [];
colonna_slot_desiderati(1:num_voli)=cell2mat(arrayVoli(2:num_voli+1,4));
colonna_slot_assegnati(1:num_voli)=cell2mat(arrayVoli(2:num_voli+1,5));
k =1;
for i=1:num_voli
  if colonna_slot_assegnati(i)~=slot_voli_cancellati 
  shift = abs(colonna_slot_desiderati(i)-colonna_slot_assegnati(i));
  if shift >8
      voli_fuori_intorno(k) = i;
      k=k+1;
  end 
  end
end

