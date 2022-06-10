
clear all

z_vec = [-0.7272896 -3.0618619  3.2424142 -4.1576597  0.4844896  2.7263041  1.5161223  2.2195368 -0.2067699 -1.0122599 -1.1448722  1.2091494  2.3374685  1.1452890  3.4992115  1.0181162  4.2734299];
z_vec_sorted = sort(z_vec);
keep_p = [0 1 1 1 0 0 0 0 0 0 0 0 0 0 1 0 1];
network_colors = [1 0.2 0.2; 0.4 0.6 0.8; 1 0.8 0.2; 0.4 0.6 0.8; 0 .4 0; 0.6 0 0.6; 1 0 0.8; 1 0.2 0.2; 1 0 0.8; 0.6 0 0.6; 0.4 0.6 0.8; 1 0.2 0.2; 0.4 0.6 0.8; 0 .4 0; 1 0.8 0.2; 0 0 0.6; 1 0.8 0.2];

figure()
for i = 1:17
if keep_p(z_vec==z_vec_sorted(i))
  bar(i,z_vec_sorted(i),'FaceColor',network_colors(z_vec==z_vec_sorted(i),1:3),'EdgeColor','w')
hold on  
else
     bar(i,z_vec_sorted(i),'w','EdgeColor',network_colors(z_vec==z_vec_sorted(i),1:3))
hold on  
end
end
xticks([1:17])
xticklabels({'4','2','11','10','1','9','5','16','14','12','7','8','13','6','3','15','17'})
xlabel('Networks')
ylabel('Cognition Association (Z)')
axis([0 18 -4.5 6])


%% SAME THING IN TEST SET

clear all

z_vec = [2.3579583 -1.3893710  3.0733065 -7.8620168  0.5033792  5.2102436 -0.7345963  0.9642072 -1.5014385  0.2726571  2.7748788 -0.4367185 -2.2333869  0.9093127  3.7563792  0.6383354  4.6654067];
z_vec_sorted = sort(z_vec);
keep_p = [0 0 1 1 0 1 0 0 0 0 0 0 0 0 1 0 1];
network_colors = [1 0.2 0.2; 0.4 0.6 0.8; 1 0.8 0.2; 0.4 0.6 0.8; 0 .4 0; 0.6 0 0.6; 1 0 0.8; 1 0.2 0.2; 1 0 0.8; 0.6 0 0.6; 0.4 0.6 0.8; 1 0.2 0.2; 0.4 0.6 0.8; 0 .4 0; 1 0.8 0.2; 0 0 0.6; 1 0.8 0.2];

figure()
for i = 1:17
if keep_p(z_vec==z_vec_sorted(i))
  bar(i,z_vec_sorted(i),'FaceColor',network_colors(z_vec==z_vec_sorted(i),1:3),'EdgeColor','w')
hold on  
else
     bar(i,z_vec_sorted(i),'w','EdgeColor',network_colors(z_vec==z_vec_sorted(i),1:3))
hold on  
end
end
xticks([1:17])
xticklabels({'4','13','9','2','7','12','10','5','16','14','8','1','11','3','15','17','6'})
xlabel('Networks')
ylabel('Cognition Association (Z)')
axis([0 18 -8 6])