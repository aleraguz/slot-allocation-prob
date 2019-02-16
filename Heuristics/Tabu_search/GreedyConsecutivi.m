function [sol_greedy, colonna_slot_assegnati] = GreedyConsecutivi(arrayVoli, capacita_slot, num_slot,num_voli,intorno)

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
    
    inserito = false;
    slot_desiderato = arrayVoli{ind(i)+1,4};
    slot =slot_desiderato;
    slot_avanti =slot_desiderato;
    slot_indietro =slot_desiderato;
    avanti =true;
    passo0 =true;
    while(~inserito)
        
        shift = abs(slot_desiderato-slot);
       
        if sol_greedy{slot,2} > 0 && shift<=intorno
            
            [sol_greedy, colonna_slot_assegnati] = InsertVelocizzato(ind(i),slot, sol_greedy, colonna_slot_assegnati);
            inserito =true;
        elseif shift>intorno
            [sol_greedy, colonna_slot_assegnati]  = InsertVelocizzato(ind(i),num_slot, sol_greedy,colonna_slot_assegnati);
            inserito =true;
        else
            if passo0
                slot = slot+ 1;
                passo0=false;
            elseif avanti
                slot =slot_avanti +1;
                slot_avanti =slot_avanti+1;
                avanti =false
            else
                if slot_indietro>1
                    slot =slot_indietro -1;
                    slot_indietro =slot_indietro-1;
                    avanti = true;
                else
                    avanti = true;
                end
                
            end
        end
    end

end






