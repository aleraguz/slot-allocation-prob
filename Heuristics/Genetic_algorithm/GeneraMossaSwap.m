function mosseSwap = GeneraMossaSwap(num_voli,colonna_slot_desiderati,colonna_slot_assegnati,intorno)
 
%inizializzo la cella con una lunghezza standard
mosseSwap = [];
h=1;

for i=1: num_voli
    
    slot_des1=colonna_slot_desiderati(i);
    slot_ass1 = colonna_slot_assegnati(i);
    
    for j=i+1: num_voli
        slot_des2=colonna_slot_desiderati(j);
        slot_ass2 = colonna_slot_assegnati(j);
    
        if(abs(slot_des1-slot_ass2)<intorno && abs(slot_des2-slot_ass1)<intorno)
            mosseSwap(h,1)=i;
            mosseSwap(h,2)=j;
            h = h+1;
        end
    end
    
end


