function mosseInsert= GeneraMosseInsert2(numSlot, array_voli, intorno, soluzione_corrente,voli_da_inserire)

% mosse d'inserimento
mosseInsert = cell(0,1);
h=1;
for i=1: length(voli_da_inserire)
    slot_des=array_voli{voli_da_inserire(i)+1,4};
    
    %numero di slot per volo
    
    slot_min = max(0, slot_des - intorno);
    slot_max = min(numSlot, slot_des + intorno);
    num_slot_per_volo = slot_max-slot_min-1; %escludo quello in cui è già
    
    for j=1: num_slot_per_volo
        if (soluzione_corrente{j+slot_min,2}>0 && j+slot_min~=array_voli{voli_da_inserire(i)+1,5})
            mosseInsert{h}=[voli_da_inserire(i) (slot_min)+j];
            h= h+1;
        end
        
    end
end
end


