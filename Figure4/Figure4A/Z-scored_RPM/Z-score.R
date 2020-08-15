library(genefilter)
d<-read.csv("Bd_meanRPM_selected_peaktime_estimated.txt",sep="\t",row.names=1,header=T)
dz <- genescale(d, axis=1, method="Z")
write.table(dz, file="Bd_meanRPM_selected_peaktime_estimated.Z.txt", sep="\t")

d<-read.csv("Bs_meanRPM_selected_peaktime_estimated.txt",sep="\t",row.names=1,header=T)
dz <- genescale(d, axis=1, method="Z")
write.table(dz, file="Bs_meanRPM_selected_peaktime_estimated.Z.txt", sep="\t")

d<-read.csv("Bh_meanRPM_selected_peaktime_estimated.txt",sep="\t",row.names=1,header=T)
dz <- genescale(d, axis=1, method="Z")
write.table(dz, file="Bh_meanRPM_selected_peaktime_estimated.Z.txt", sep="\t")

d<-read.csv("BhBd_meanRPM_selected_peaktime_estimated.txt",sep="\t",row.names=1,header=T)
dz <- genescale(d, axis=1, method="Z")
write.table(dz, file="BhBd_meanRPM_selected_peaktime_estimated.Z.txt", sep="\t")

d<-read.csv("BhBs_meanRPM_selected_peaktime_estimated.txt",sep="\t",row.names=1,header=T)
dz <- genescale(d, axis=1, method="Z")
write.table(dz, file="BhBs_meanRPM_selected_peaktime_estimated.Z.txt", sep="\t")
