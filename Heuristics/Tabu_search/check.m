function n = check(glob_voli,num_voli)

colonna_des = cell2mat(glob_voli(2:(num_voli+1),4));
n = find(colonna_des == 76);
end