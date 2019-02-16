function mosseInsert= GeneraMosseInsert(voli_da_inserire,numSlot, num_voli_da_inserire,colonna_slot_capacita, colonna_slot_desiderati,colonna_slot_assegnati,intorno)

% mosse d'inserimento
mosseInsert = [];
h=1;
for i=1: num_voli_da_inserire
 
    slot_des=colonna_slot_desiderati(voli_da_inserire(i));
    slot_min = max(0, slot_des - intorno);
    slot_max = min(numSlot, slot_des + intorno);
    num_slot_per_volo = slot_max-slot_min-1; %escludo quello in cui è già
    
    for j=1: num_slot_per_volo
        if (colonna_slot_capacita(j+slot_min)>0 && j+slot_min~=colonna_slot_assegnati(voli_da_inserire(i)))
        mosseInsert(h,1)= voli_da_inserire(i);
        mosseInsert(h,2)=slot_min+j;
        h= h+1;
        end 
    end
end


