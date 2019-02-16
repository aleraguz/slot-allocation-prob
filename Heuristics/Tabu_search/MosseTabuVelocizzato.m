function mossevel = MosseTabuVelocizzato(mosseTabu,Tabulist,lung_lista_tabu)

mossevel = {};
ind = find(Tabulist>0,lung_lista_tabu);
for i=1: length(ind)
mossevel{i} = mosseTabu{ind(i)};
end

end

