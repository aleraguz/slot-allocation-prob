function[array_voli, num_voli, num_slot, intorno, capacita_slot] = InputAltaStagione()

%generazione voli in bassa stagione

num_voli=400; 
num_slot=76; 
capacita_slot =5; 
intorno = 8;

%%divido i voli per le compagnie 
voli_alitalia=0.5*num_voli;
voli_ryanair=0.15*num_voli;
voli_vueling=0.15*num_voli;
voli_qatar=0.1*num_voli;
voli_lufthansa=0.05*num_voli;
voli_airfrance=0.05*num_voli;

nomi_tot(1,1:voli_alitalia) = "alitalia";
cum = voli_alitalia;
nomi_tot(1,(cum+1):(cum + voli_ryanair)) = "ryanair";
cum = cum +voli_ryanair;
nomi_tot(1,(cum+1): (cum+voli_vueling)) = "vueling";
cum = cum + voli_vueling;
nomi_tot(1,(cum+1):(voli_qatar+cum)) = "qatar";
cum = cum + voli_qatar;
nomi_tot(1,(cum+1):(voli_lufthansa+cum)) = "lufthansa";
cum = cum + voli_lufthansa;
nomi_tot(1,(cum+1):(voli_airfrance+cum)) = "airfrance";

domanda_alitalia = SlotDesideratoCompagnia(voli_alitalia,num_slot,"alitalia");
domanda_ryanair = SlotDesideratoCompagnia(voli_ryanair,num_slot,"ryanair");
domanda_vueling = SlotDesideratoCompagnia(voli_vueling,num_slot,"vueling");
domanda_qatar = SlotDesideratoCompagnia(voli_qatar,num_slot,"qatar");
domanda_lufthansa = SlotDesideratoCompagnia(voli_lufthansa,num_slot,"lufthansa");
domanda_airfrance = SlotDesideratoCompagnia(voli_airfrance,num_slot,"airfrance");





%% con tipologia uniforme
% [tipologia_volo_alitalia,passeggeri_alitalia,scalo_alitalia]= TipologiaVoloUniforme(voli_alitalia);
% [tipologia_volo_ryanair,passeggeri_ryanair,scalo_ryanair]= TipologiaVoloUniforme(voli_ryanair);
% [tipologia_volo_vueling,passeggeri_vueling,scalo_vueling]= TipologiaVoloUniforme(voli_vueling);
% [tipologia_volo_qatar,passeggeri_qatar,scalo_qatar]= TipologiaVoloUniforme(voli_qatar);
% [tipologia_volo_lufthansa,passeggeri_lufthansa,scalo_lufthansa]= TipologiaVoloUniforme(voli_lufthansa);
% [tipologia_volo_airfrance,passeggeri_airfrance,scalo_airfrance]= TipologiaVoloUniforme(voli_airfrance);

%% con tipologia nazionale

[tipologia_volo_alitalia,passeggeri_alitalia,scalo_alitalia]= TipologiaVoloNazionale(voli_alitalia);
[tipologia_volo_ryanair,passeggeri_ryanair,scalo_ryanair]= TipologiaVoloNazionale(voli_ryanair);
[tipologia_volo_vueling,passeggeri_vueling,scalo_vueling]= TipologiaVoloNazionale(voli_vueling);
[tipologia_volo_qatar,passeggeri_qatar,scalo_qatar]= TipologiaVoloNazionale(voli_qatar);
[tipologia_volo_lufthansa,passeggeri_lufthansa,scalo_lufthansa]= TipologiaVoloNazionale(voli_lufthansa);
[tipologia_volo_airfrance,passeggeri_airfrance,scalo_airfrance]= TipologiaVoloNazionale(voli_airfrance);

domanda_tot = [domanda_alitalia domanda_ryanair domanda_vueling domanda_qatar domanda_lufthansa domanda_airfrance];
tipologia_volo_tot = [tipologia_volo_alitalia tipologia_volo_ryanair tipologia_volo_vueling tipologia_volo_qatar tipologia_volo_lufthansa tipologia_volo_airfrance];
passeggeri_tot = [passeggeri_alitalia passeggeri_ryanair passeggeri_vueling passeggeri_qatar passeggeri_lufthansa passeggeri_airfrance];
scalo_tot = [scalo_alitalia scalo_ryanair scalo_vueling scalo_qatar scalo_lufthansa scalo_airfrance];


% figure(1)
% hist(domanda_alitalia)
% figure(2)
% hist(domanda_ryanair)
% figure(3)
% hist(domanda_vueling)
% figure(4)
% hist(domanda_qatar)
% figure(5)
% hist(domanda_lufthansa)
% figure(6)
% hist(domanda_airfrance)



%% creazione tabella voli
array_voli = cell(2,7);
array_voli(1,:) = {'Id_volo', 'Compagnia', 'Passeggeri', 'Slot_desiderato', 'Slot_assegnato','Passeggeri scalo','tipologia volo'};

for i=1:num_voli
   
    array_voli{i+1,1}= i; %id
    array_voli{i+1,2}= nomi_tot(i); %nome compagnia 
    array_voli{i+1,3}= passeggeri_tot(i); %numero passeggeri
    array_voli{i+1,4}= domanda_tot(i); %slot desiderato
    array_voli{i+1,5}= 0; %slot assegnato
    array_voli{i+1,6}= scalo_tot(i); %passeggeri scalo
    array_voli{i+1,7}= tipologia_volo_tot(i); %tipologia volo
     
end    




end

