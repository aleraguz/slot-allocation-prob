function [sol_greedy, colonna_slot_assegnati] = Greedy(arrayVoli, capacita_slot, num_slot,num_voli,intorno)

% La terza colonna dell'array di voli indica i passeggeri, mentre la prima
% riga è fittizia quindi parto dalla seconda

passeggeri_voli(1:num_voli)=cell2mat(arrayVoli(2:num_voli+1,3));
colonna_slot_assegnati = cell2mat(arrayVoli(2:(num_voli+1),5));

[pass_ordinati, ind]= OrdinaPasseggeri(passeggeri_voli);

%creazione della struttura
sol_greedy = cell(num_slot, 2);
for i =1: num_slot-1
   sol_greedy{i,2}= capacita_slot; 
end    
%%% inserisco la capacità slot fittizio
sol_greedy{num_slot,2} = num_voli;
%%% creiamo un vettore di indici a cui corrispondo i voli ordinati per
%%% passeggeri

for i=1: num_voli
    %seleziono lo slot desiderato a partire dal primo volo con più
    %passeggeri (ind(i)+1 perchè l'array dei voli ha la prima riga fittizia) 

   
    slot_desiderato = arrayVoli{ind(i)+1,4};
    %guardo se la capacità (colonna 2) è >0
    if(sol_greedy{slot_desiderato,2} >0)
        
        [sol_greedy, colonna_slot_assegnati] = InsertVelocizzato(ind(i),slot_desiderato, sol_greedy, colonna_slot_assegnati);
        %sol_greedy{slot_desiderato,2}=sol_greedy{slot_desiderato,2}-1;
        
    else
       % inserisco nello slot fittizio 5
       [sol_greedy, colonna_slot_assegnati]  = InsertVelocizzato(ind(i),num_slot, sol_greedy,colonna_slot_assegnati); 
     
    end    
    
end


end

