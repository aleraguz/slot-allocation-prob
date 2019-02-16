function check = CheckMossaTabu(mossevel,mossaSwap)
lung_mosse_vel = length(mossevel);
check = 0;
for i=1: lung_mosse_vel
    if mossevel{i} == mossaSwap
        check = 1;
        break
    end
end

