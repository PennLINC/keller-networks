%% PC1 - test in subsample A (Discovery)

clear all

% note: the coefs matrix is 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC1_coefs_testA.mat');
coefs = coefs.PC1_testA;

VertexQuantity = 59412; % 17734;

w_Brain_EFAccuracy_Abs = abs(coefs); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;


% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_PC1_testA.mat'], 'w_Brain_EFAccuracy_Matrix');



%% PC 2 - test in subsample A (Discovery)

clear all

% note: the coefs matrix is 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC2_coefs_testA.mat');
coefs = coefs.PC2_testA;

VertexQuantity = 59412; % 17734;

% Display the weight of the first 25% regions with the highest absolute weight
w_Brain_EFAccuracy_Abs = abs(coefs); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;

% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_PC2_testA.mat'], 'w_Brain_EFAccuracy_Matrix');


%% PC 3 - test in subsample A (Discovery)

clear all

% note: the coefs matrix is 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC3_coefs_testA.mat');
coefs = coefs.PC3_testA;

VertexQuantity = 59412; % 17734;

% Display the weight of the first 25% regions with the highest absolute weight
w_Brain_EFAccuracy_Abs = abs(coefs); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;

% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_PC3_testA.mat'], 'w_Brain_EFAccuracy_Matrix');


%% PC1 - test in subsample B (Replication)

clear all

% note: the coefs matrix is 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC1_coefs_testB.mat');
coefs = coefs.PC1_testB;

VertexQuantity = 59412; % 17734;

w_Brain_EFAccuracy_Abs = abs(coefs); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;


% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_PC1_testB.mat'], 'w_Brain_EFAccuracy_Matrix');



%% PC 2 - test in subsample B (Replication)

clear all

% note: the coefs matrix is 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC2_coefs_testB.mat');
coefs = coefs.PC2_testB;

VertexQuantity = 59412; % 17734;

% Display the weight of the first 25% regions with the highest absolute weight
w_Brain_EFAccuracy_Abs = abs(coefs); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;

% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_PC2_testB.mat'], 'w_Brain_EFAccuracy_Matrix');


%% PC 3 - test in subsample B (Replication)

clear all

% note: the coefs matrix is 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC3_coefs_testB.mat');
coefs = coefs.PC3_testB;

VertexQuantity = 59412; % 17734;

% Display the weight of the first 25% regions with the highest absolute weight
w_Brain_EFAccuracy_Abs = abs(coefs); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;

% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_PC3_testB.mat'], 'w_Brain_EFAccuracy_Matrix');




