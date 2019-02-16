function [popolazione_nuova,popolazione_nuova_capacita,popolazione_fitness] = AlgoritmoGenetico(array_voli,popolazione,popolazione_capacita,popolazione_fitness,capacita_slot)

[~, ind] = sort(popolazione_fitness,'ascend');
numero_voli_selezionati=length(popolazione_fitness);
%soglia = fitness1(ind(1))*1.25;

popolazione_genitori = popolazione(:,ind);
popolazione_genitori_capacita = popolazione_capacita(:,ind);
h=1;

for j=1:numero_voli_selezionati
    for k=j+1:numero_voli_selezionati
        if (j~=k)
            
               [figlio figlio_capacita fitness] = crossover(array_voli,popolazione_genitori(:,j), popolazione_genitori(:,k), popolazione_genitori_capacita(:,j),popolazione_genitori_capacita(:,k),capacita_slot);
                 %if fitnessfiglio < soglia
                popolazione_nuova(:,h)=figlio;
                popolazione_nuova_capacita(:,h)=figlio_capacita;
                popolazione_fitness(h)=fitness;
                h=h+1;
                %end
        end
    end
end



