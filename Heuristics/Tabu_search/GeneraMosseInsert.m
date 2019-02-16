function mosseInsert= GeneraMosseInsert(numSlot, num_voli_cancellati,voli_cancellati,array_voli,intorno)

% mosse d'inserimento
mosseInsert = cell((num_voli_cancellati-1)*intorno,1);
h=1;
for i=1: num_voli_cancellati
    volo_canc=voli_cancellati(i);
    slot_des=array_voli{volo_canc+1,4};
   
    %numero di slot per volo
    
    slot_min = max(0, slot_des - intorno);
    slot_max = min(numSlot, slot_des + intorno);
    num_slot_per_volo = slot_max-slot_min-1; %escludo quello in cui è già
    
    for j=1: num_slot_per_volo

        mosseInsert{h}=[voli_cancellati(i) (slot_min)+j];
        h= h+1;
    
        
    end
end


end

