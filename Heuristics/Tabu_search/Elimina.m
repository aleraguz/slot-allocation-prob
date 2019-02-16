function current_sol = Elimina(volo,slot_voli_cancellati,sol_corrente)

y = sol_corrente{slot_voli_cancellati,1};
ind = find(y==volo);
y(ind) = [];

sol_corrente{slot_voli_cancellati}= y;
sol_corrente{slot_voli_cancellati,2} =sol_corrente{slot_voli_cancellati,2} +1;
current_sol =sol_corrente;
end

