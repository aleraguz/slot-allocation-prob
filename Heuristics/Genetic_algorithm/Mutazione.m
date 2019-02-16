function [figlio,figlio_capacita]=Mutazione(figlio,figlio_capacita,slot_dei_cancellati)

slot_con_troppi_voli = find(figlio_capacita <0);

for i=1: length(slot_con_troppi_voli)
    voli_slot_in_eccesso = find(ismember(figlio,slot_con_troppi_voli(i)));
    num_voli_in_eccesso = abs(figlio_capacita(slot_con_troppi_voli(i)));
    for j=1:num_voli_in_eccesso
        %POSSIAMO AGGIUNGERE RANDOM
        [figlio,figlio_capacita] = InsertVelocizzato(voli_slot_in_eccesso(j),slot_dei_cancellati,figlio,figlio_capacita);
        figlio_capacita(slot_con_troppi_voli(i))= figlio_capacita(slot_con_troppi_voli(i))+1;
    end    
end


