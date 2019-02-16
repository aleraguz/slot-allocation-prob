function glob_voli = RiempimentoArrayVoli(glob_voli,colonna_slot_assegnati,num_voli)

%inserisco la colonna dei voli assegnati nell'array di voli
for i=1:num_voli   
    glob_voli{(i+1),5} = colonna_slot_assegnati(i);  
end
end

