function funz_ob = FunzioneObVelocizzata(array_voli,num_slot)

alfa1=0.19;
alfa2 =0.165;
alfa3 = 0.161;
funz_ob = 0;
beta =1.5;
slot_dei_voli_cancellati =num_slot;

colonna_passeggeri = array_voli(:,1);
colonna_slot_desiderati = array_voli(:,2);
colonna_slot_assegnati = array_voli(:,3);
colonna_passeggeri_scalo = array_voli(:,4);
colonna_tipologia_voli = array_voli(:,5);

[voli_cancellati ~] = find(colonna_slot_assegnati==slot_dei_voli_cancellati);
[voli_canc_tip_1 ~] = find(colonna_tipologia_voli(voli_cancellati)==1);
[voli_canc_tip_2 ~] = find(colonna_tipologia_voli(voli_cancellati)==2);
[voli_canc_tip_3 ~] = find(colonna_tipologia_voli(voli_cancellati)==3);

% funz ob voli cancellati

f1_cancellati = sum(250*colonna_passeggeri(voli_cancellati(voli_canc_tip_1))+250*colonna_passeggeri_scalo(voli_cancellati(voli_canc_tip_1)));
f2_cancellati = sum(400*colonna_passeggeri(voli_cancellati(voli_canc_tip_2))+400*colonna_passeggeri_scalo(voli_cancellati(voli_canc_tip_2)));
f3_cancellati = sum(600*colonna_passeggeri(voli_cancellati(voli_canc_tip_3))+600*colonna_passeggeri_scalo(voli_cancellati(voli_canc_tip_3)));

colonna_slot_desiderati(voli_cancellati)=[];
colonna_slot_assegnati(voli_cancellati) = [];
colonna_passeggeri(voli_cancellati)=[];
colonna_passeggeri_scalo(voli_cancellati) = [];
colonna_tipologia_voli(voli_cancellati) = []; 

[voli_tip_1 ~] = find(colonna_tipologia_voli==1);
[voli_tip_2 ~] = find(colonna_tipologia_voli==2);
[voli_tip_3 ~] = find(colonna_tipologia_voli==3);

shift = abs(colonna_slot_assegnati-colonna_slot_desiderati);
[voli_senza_shift ~] = find(shift==0);

colonna_slot_desiderati(voli_senza_shift)=[];
colonna_slot_assegnati(voli_senza_shift) = [];
colonna_passeggeri(voli_senza_shift)=[];
colonna_passeggeri_scalo(voli_senza_shift) = [];
colonna_tipologia_voli(voli_senza_shift) = []; 

ind = find(shift>0);
shift = shift(ind);

[voli_tip_1_con_shift ~] = find(colonna_tipologia_voli==1);
[voli_tip_2_con_shift ~] = find(colonna_tipologia_voli==2);
[voli_tip_3_con_shift ~] = find(colonna_tipologia_voli==3);

f1 = alfa1*(colonna_passeggeri(voli_tip_1_con_shift)')*(shift(voli_tip_1_con_shift).^beta)+sum(250*colonna_passeggeri_scalo(voli_tip_1_con_shift));   
f2 = alfa2*(colonna_passeggeri(voli_tip_2_con_shift)')*(shift(voli_tip_2_con_shift).^beta)+sum(400*colonna_passeggeri_scalo(voli_tip_2_con_shift)); 
f3 = alfa3*(colonna_passeggeri(voli_tip_3_con_shift)')*(shift(voli_tip_3_con_shift).^beta)+sum(600*colonna_passeggeri_scalo(voli_tip_3_con_shift)); 

funz_ob =round(f1+f2+f3+f1_cancellati+f2_cancellati+f3_cancellati);

