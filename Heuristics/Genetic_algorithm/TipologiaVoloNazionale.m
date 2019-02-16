function [tipologia_volo,passeggeri,scalo] = TipologiaVoloNazionale(voli)



for i=1:voli
    %%% sbilanciamento nazionali
    
    probabilita = randi([1 10],1,1);
    
    %tipologia_volo(i)=randi([1 3],1,1);
    
    
    
    if (probabilita>4)
        tipologia_volo(i)=1;
        passeggeri(i)=randi([81 108],1,1);
    end
    if (probabilita<= 4 && probabilita >2)
        tipologia_volo(i)=2;
        passeggeri(i)=randi([80 270],1,1);
    end
    if (probabilita<=  2 && probabilita >0)
        tipologia_volo(i)=3;
        passeggeri(i)=randi([200 270],1,1);
    end
    
    min_scalo = round(passeggeri(i)*0.05);
    max_scalo = round(passeggeri(i)*0.15);
    scalo(i)=(randi([min_scalo max_scalo],1,1));
end

end

