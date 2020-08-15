library(gplots)
d<-read.csv("get_exprssion_patterns_all_timepoints.pl.stdout",sep="\t",row.names=1,header=T)

mycol<-c("#7F7F7F","#ED5654","#F38F8D","#50B9C1","#8AD0D6","#F4A16F","#F8C09F","#764674","#C59EC3")
png(file="get_exprssion_patterns_all_timepoints.pl.png", height=2880, width=2880, res=500)
heatmap.2(as.matrix(d),dendrogram="row",labRow=NA,labCol=NA,trace="none",col=mycol,key=FALSE)
dev.off()

hmp<-heatmap.2(as.matrix(d),dendrogram="row",labRow=NA,labCol=NA,trace="none",col=mycol,key=FALSE)
order<-hmp[1]
write.table(order,file="get_exprssion_patterns_all_timepoints.pl.order.txt",sep="\t")


> rgb(127/255,127/255,127/255)   # P1 -> 1
[1] "#7F7F7F"
> rgb(237/255,86/255,84/255)     # P5 -> 2
[1] "#ED5654"
> rgb(243/255,143/255,141/255)   # P9 -> 3
[1] "#F38F8D"
> rgb(80/255,185/255,193/255)    # P2 -> 4
[1] "#50B9C1"
> rgb(138/255,208/255,214/255)   # P3 -> 5
[1] "#8AD0D6"
> rgb(244/255,161/255,111/255)   # P4 -> 6
[1] "#F4A16F"
> rgb(248/255,192/255,159/255)   # P7 -> 7
[1] "#F8C09F"
> rgb(118/255,70/255,116/255)    # P6 -> 8
[1] "#764674"
> rgb(197/255,158/255,195/255)   # P8 -> 9
[1] "#C59EC3"