function soluzione = CostruzioneSoluzione(array_voli,colonna_capacita_slot,num_slot,num_voli)

soluzione = cell(num_slot,2);

for j=1: num_slot
    soluzione{j,2} = colonna_capacita_slot(j);
end


for i=1: num_voli
  
    slot = array_voli(i,3);
    y = soluzione{slot,1};
    soluzione{slot}= [y i];
    
end

