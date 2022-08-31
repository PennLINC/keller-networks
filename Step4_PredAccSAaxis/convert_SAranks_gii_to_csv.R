
# Load in gifti files with S-A axis ranks in fsaverage5 from Val's github repo
SA_axis_gii_L<-read_gifti('/Users/askeller/Documents/Kellernet_PrelimAnalysis/SpinTests/SensorimotorAssociation_Axis_LH.fsaverage5.func.gii')
SA_axis_gii_R<-read_gifti('/Users/askeller/Documents/Kellernet_PrelimAnalysis/SpinTests/SensorimotorAssociation_Axis_RH.fsaverage5.func.gii')

# Extract the list of ranks
SA_L <- SA_axis_gii_L[["data"]][["normal"]]
SA_R <- SA_axis_gii_R[["data"]][["normal"]]

# Save them as a csv
write.csv(SA_L,"/Users/askeller/Documents/Kellernet_PrelimAnalysis/SpinTests/SA_AvgRank_LH.csv")
write.csv(SA_R,"/Users/askeller/Documents/Kellernet_PrelimAnalysis/SpinTests/SA_AvgRank_RH.csv")