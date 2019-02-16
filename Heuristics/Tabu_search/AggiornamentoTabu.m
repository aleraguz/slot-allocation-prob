function Tabulist= AggiornamentoTabu(mosseTabu,mosseSwap,Tabulist,ind,lung_lista_tabu,LunghezzaListaTabu)
%Funzione per aggiornamento lista tabu

for k=1:lung_lista_tabu
    if mosseTabu{k}==mosseSwap{ind}
        Tabulist(k)=LunghezzaListaTabu;% aggiungi mossa alla list tabu
        break;
    else
        Tabulist(k)=max(Tabulist(k)-1,0);   %decrementa contatore
    end
end



