function [tipologia_volo,passeggeri,scalo]= TipologiaVoloUniforme(voli)
%TIPOLOGIAVOLO Summary of this function goes here
%   Detailed explanation goes here


for i=1:voli
    tipologia_volo(i)=randi([1 3],1,1);
    if (tipologia_volo(i)==1)
        passeggeri(i)=randi([81 108],1,1);
    end
    if (tipologia_volo(i)==2)
        passeggeri(i)=randi([80 270],1,1);
    end
    if (tipologia_volo(i)==3)
        passeggeri(i)=randi([200 270],1,1);
    end
    min_scalo = round(passeggeri(i)*0.05);
    max_scalo = round(passeggeri(i)*0.15);
    scalo(i)=(randi([min_scalo max_scalo],1,1));
end
end

