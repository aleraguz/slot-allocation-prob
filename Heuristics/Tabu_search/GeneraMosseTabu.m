function mosseTabu = GeneraMosseTabu(num_voli)

%inizializzo la cella con una lunghezza standard
mosseTabu = cell(2,1);
h=1;

for i=1: num_voli
    for j=i+1: num_voli
        mosseTabu{h}=[i j];
        h = h+1;
    end
end