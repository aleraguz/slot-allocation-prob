function funz_ob = FunzioneObVelocizzata(sol_corrente, arrayVoli, colonna_slot_assegnati, capacita_slot)

alfa=0;
funz_ob = 0;
num_slot = length(sol_corrente); %le righe di sol_corrente sono il num di slot
for i=1: (num_slot-1) %escludo lo slot dei cancellati
  
    voli_nello_slot =sol_corrente{i,1};
    capacita_sloti = sol_corrente{i,2};
    
    if(length(voli_nello_slot)>0) %cond di guardia per array vuoti
        
        for j=1: (capacita_slot-capacita_sloti)
           
            ind = voli_nello_slot(j);
            tipologia_volo = arrayVoli{ind+1,7};
            
            if (tipologia_volo==1)
                alfa=0.19;
                costo(1)= 250;
            elseif (tipologia_volo==2)
                alfa=0.165;
                costo(2) = 400;
            elseif (tipologia_volo==3)
                alfa=0.161;
                costo(3) = 600;
            end
   
            %prendiamo il numero del volo
            shift = abs(arrayVoli{(ind+1),4}-colonna_slot_assegnati(ind));
            if (shift>0)
                funz_ob= funz_ob + arrayVoli{(ind+1),3}*alfa*(shift^(1.5))+costo(tipologia_volo)*arrayVoli{(ind+1),6}; 
            end
        end
    end
    
end

voli_cancellati = sol_corrente{num_slot,1};


for i=1:length(voli_cancellati)
    tipologia_volo = arrayVoli{voli_cancellati(i)+1,7};
    if (tipologia_volo==1)
        costo(1)= 250;
    elseif (tipologia_volo==2)
        costo(2) = 400;
    elseif (tipologia_volo==3)
        costo(3) = 600;
    end
    
    if(length(voli_cancellati)>0)
        ind = voli_cancellati(i);
        funz_ob = funz_ob + costo(tipologia_volo)*arrayVoli{(ind+1),3}+costo(tipologia_volo)*arrayVoli{(ind+1),6};
    end
end
funz_ob=round(funz_ob,2);

