function [figlio figlio_capacita fitness] = crossover(array_voli,genitore1, genitore2, genitore1_capacita,genitore2_capacita,capacita_slot)
%CROSSOVER Summary of this function goes here

num_voli = length(genitore1);
taglio=randi([1 num_voli],1,1);
figlio1=genitore1;
figlio1_capacita=genitore1_capacita;
figlio2=genitore2;
figlio2_capacita=genitore2_capacita;

for  i=1:taglio

[figlio1,figlio1_capacita] = InsertVelocizzato(i,genitore2(i),figlio1,figlio1_capacita);
figlio1_capacita(genitore1(i))= figlio1_capacita(genitore1(i))+1; 

end
% soluzione inammissibile
[figlio1,figlio1_capacita]=Mutazione(figlio1,figlio1_capacita,length(genitore1_capacita));
array_voli(:,3)=figlio1;
fitnessfiglio(1) = FunzioneObVelocizzata(array_voli,length(figlio1_capacita));

for  i=1:taglio

[figlio2,figlio2_capacita] = InsertVelocizzato(i,genitore1(i),figlio2,figlio2_capacita);
figlio2_capacita(genitore2(i))= figlio2_capacita(genitore2(i))+1; 

end

% soluzione inammissibile
[figlio2,figlio2_capacita]=Mutazione(figlio2,figlio2_capacita,length(genitore2_capacita));
array_voli(:,3)=figlio2;
fitnessfiglio(2) = FunzioneObVelocizzata(array_voli,length(figlio2_capacita));

[fitness ind]=min(fitnessfiglio);
if ind==1
    figlio=figlio1;
    figlio_capacita=figlio1_capacita;
else
    figlio=figlio2;
    figlio_capacita=figlio2_capacita;
end

