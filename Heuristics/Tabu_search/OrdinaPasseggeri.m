function [y,ind] = OrdinaPasseggeri(pass)

[~, ind] = sort(pass,'descend');

y= pass(ind);

end

