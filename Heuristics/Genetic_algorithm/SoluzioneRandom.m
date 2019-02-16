function [array_voli, colonna_capacita, funz_ob] = SoluzioneRandom(array_voli, colonna_capacita, num_slot,num_voli,intorno)
%Soluzione ammissibile randomica

colonna_slot_desiderati = array_voli(:,2);
colonna_slot_assegnati = array_voli(:,3);
temp_colonna_voli = [1:1:num_voli]';
k = num_voli;

slot =1;

for i=1: num_voli
    rand = randi([1 k],1,1);
    temp = temp_colonna_voli(rand);
    temp_colonna_voli(rand) = []; %elimino il volo inserito
    colonna_voli_random(i) = temp;
    k= k-1;
    inserito = false;
    slot_desiderato = colonna_slot_desiderati(i);
    shift = abs(slot_desiderato-slot);
    
    while(~inserito)
        if colonna_capacita(slot) > 0 && shift<=intorno
            [colonna_slot_assegnati, colonna_capacita] = InsertVelocizzato(colonna_voli_random(i),slot, colonna_slot_assegnati, colonna_capacita);
            inserito = true;
        elseif shift > intorno
            [colonna_slot_assegnati, colonna_capacita]  = InsertVelocizzato(colonna_voli_random(i),num_slot, colonna_slot_assegnati,colonna_capacita);
            inserito =true;
        else
            slot =slot+1;
        end
    end
    
    
end

array_voli(:,3)=colonna_slot_assegnati;

funz_ob = FunzioneObVelocizzata(array_voli,num_slot);

