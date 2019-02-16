function [sol_rand, colonna_slot_assegnati] = SoluzioneRandom(arrayVoli, capacita_slot, num_slot,num_voli, intorno)
%Soluzione ammissibile randomica

colonna_slot_assegnati = cell2mat(arrayVoli(2:(num_voli+1),5));
colonna_voli_slot_des(:,1) = cell2mat(arrayVoli(2:(num_voli+1),4));
colonna_voli =cell2mat(arrayVoli(2:(num_voli+1),1));
temp_colonna_voli = colonna_voli;
k = num_voli;

sol_rand = cell(num_slot, 2);
for i= 1:num_slot-1
    sol_rand{i,2}= capacita_slot;
end
sol_rand{num_slot,2} = num_voli;

slot =1;

for i=1: num_voli
    rand = randi([1 k],1,1);
    temp = temp_colonna_voli(rand);
    temp_colonna_voli(rand) = []; %elimino il volo inserito
    colonna_voli_random(i) = temp;
    k= k-1;
    inserito = false;
    slot_desiderato = colonna_voli_slot_des(i);
    shift = abs(slot_desiderato-slot);
    
    while(~inserito)
        if sol_rand{slot,2} > 0 && shift<=intorno
            [sol_rand, colonna_slot_assegnati] = InsertVelocizzato(colonna_voli_random(i),slot, sol_rand, colonna_slot_assegnati);
            inserito = true;
        elseif shift > intorno
            [sol_rand, colonna_slot_assegnati]  = InsertVelocizzato(colonna_voli_random(i),num_slot, sol_rand,colonna_slot_assegnati);
            inserito =true;
        else
            slot =slot+1;
        end
    end
    
    
end

