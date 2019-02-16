function [new_sol, colonna_slot_assegnati] = InsertVelocizzato(voloi,sloti, sol_corrente, colonna_slot_assegnati) %%aggiungere array di voli e modificare slot
%slot assegnato all'interno di insert

y = sol_corrente{sloti,1};

sol_corrente{sloti}= [y voloi];

colonna_slot_assegnati(voloi)=sloti;

sol_corrente{sloti,2}=sol_corrente{sloti,2}-1;

new_sol = sol_corrente;
end

