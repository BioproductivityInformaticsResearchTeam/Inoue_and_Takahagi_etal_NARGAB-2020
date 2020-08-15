library(DESeq2)

count<-read.csv("Bd21_col_sta_BhBd_BhBs_Bh.txt",sep="\t",row.names=1)
count<-as.matrix(count)

header<-read.csv("DESeq2_header.txt",header=F)
header=as.vector(as.character(header[,1]))

group <- data.frame(con = factor(header))

dds <- DESeqDataSetFromMatrix(countData = count, colData = group, design = ~ con)
dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

save(dds,file="dds.rda")

