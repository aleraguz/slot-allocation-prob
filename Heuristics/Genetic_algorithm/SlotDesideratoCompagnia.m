function [domanda] = SlotDesideratoCompagnia(voli,slot,nomecompagnia)
%SLOTDESIDERATOCOMPAGNIA Summary of this function goes here
%   Detailed explanation goes here
lung_mattina = voli*1/3;
lung_pranzo = voli*2/3;
j=1;
for i=1:2*voli
    if(nomecompagnia=="ryanair" || nomecompagnia=="lufthansa" || nomecompagnia=="vueling" || nomecompagnia=="qatar")
        num_rad=4*(8+6.*randn(1));
        %h(i)=num_rad;
        if num_rad>=4*5 && num_rad<=4*24
            domanda(j)=ceil(num_rad);
            domanda(j)=domanda(j)-20;
            j=j+1;
            if length(domanda)==voli
                break
            end
        end
    elseif (nomecompagnia=="airfrance")
        domanda(i)=randi([5 76],1,1);
        if length(domanda)==voli
            break
        end
        
    else
        
        num_rad_mattina=4*(8+4.*randn(1));
        
        %h(i)=num_rad;
        if num_rad_mattina>=4*5 && num_rad_mattina<=4*10 && j<=lung_mattina
            domanda(j)=ceil(num_rad_mattina);
            domanda(j)=domanda(j)-20;
            j=j+1;
            
        elseif j>lung_mattina
            
            num_rad_pranzo=4*(14+4.*randn(1));
            if num_rad_pranzo>=4*10 && num_rad_pranzo<=4*24
                domanda(j)=ceil(num_rad_pranzo);
                domanda(j)=domanda(j)-20;
                j=j+1;
                if length(domanda)==lung_pranzo+lung_mattina
                    break
                end
            end
        end
    end
end

end

