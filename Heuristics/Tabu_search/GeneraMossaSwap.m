function mosseSwap = GeneraMossaSwap(num_voli,array_voli,intorno,num_slot)

%inizializzo la cella con una lunghezza standard
mosseSwap = cell(2,1);
h=1;
colonna_slot_desiderati(1:num_voli)=cell2mat(array_voli(2:num_voli+1,4));
colonna_slot_assegnati(1:num_voli)=cell2mat(array_voli(2:num_voli+1,5));

for i=1: num_voli
    
    slot_des1=colonna_slot_desiderati(i);
    slot_ass1 = colonna_slot_assegnati(i);
    
    for j=i+1: num_voli
        slot_des2=colonna_slot_desiderati(j);
        slot_ass2 = colonna_slot_assegnati(j);
        
        % if((slot_ass2 ==num_slot)||(abs(slot_des1-slot_ass2)<intorno && abs(slot_des2-slot_ass1)<intorno))
        
        if abs(slot_des1-slot_ass2)<intorno && abs(slot_des2-slot_ass1)<intorno
            mosseSwap{h}=[i j];
            h = h+1;
        end
    end
    
end
%mosseSwap = reshape(mosseSwap,h)

