d<-read.csv("col_Bh_DEG_all_Z.txt",sep="\t",row.names=1,header=T)
dim(d)
min(d)
max(d)

#mycol<-colorRampPalette(c("#0000FF", "#FFFFFF", "#FF0000"))(n = 100)
#png(file="Expressed_genes_ave_Z.png", height=2000, width=3500, res=500)
#heatmap.2(as.matrix(d),Colv=NA,labRow=NA,col=mycol, trace="none", scale="none", dendrogram = "none", hclustfun = function(d) { hclust(d, method = "complete") })
#dev.off()

hc<-hclust(dist(as.matrix(d), method = "euclidean"))
label<-c(hc$labels)
order<-c(hc$order)
ordered_label<-label[order]
write.table(ordered_label, file="col_Bh_DEG_all_Z_clustered.txt", sep="\t")
