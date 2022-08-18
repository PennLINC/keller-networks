

data<-read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/data_for_ridge_031822.csv")

familyIDs_group1 <- data[data$matched_group==1,]$rel_family_id
familyIDs_group2 <- data[data$matched_group==2,]$rel_family_id

intersect(familyIDs_group1,familyIDs_group2)

sum(familyIDs_group1==473)
