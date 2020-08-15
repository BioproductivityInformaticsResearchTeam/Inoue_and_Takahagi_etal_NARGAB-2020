#GO frame of a custom annotation prepared as a GeneSetCollection object
library(org.Hs.eg.db) 
frame <- toTable(org.Hs.egGO) 
#summary(frame)
goframeData <- data.frame(frame$go_id, frame$Evidence, frame$gene_id) 
#summary(goframeData)
goframeData <- read.table("Bdistachyon.edited.annot.GO_annot_file_edit.pl.stdout", header = TRUE)
summary(goframeData)

library(GSEABase) 
goFrame <- GOFrame(goframeData, organism = "Brachypodium distachion") 
goAllFrame <- GOAllFrame(goFrame)
gsc <- GeneSetCollection(goAllFrame, setType = GOCollection())

#import gene_id list for backgrownd
bg <- read.csv("Bdistachyon_gene_id_list.txt", header = F)
bg <- as.character(bg[,1])

#file globbing 
files<-list.files("./", pattern="*_Bh.txt")
#files<-c("test1.txt","test2.txt")

for(file.name in files){
  print (file.name)

  deg <-read.csv(file.name, header =F) 
  deg <- as.character(deg[,1])
  summary(deg)
  
  #paramete settings
  p <- GSEAGOHyperGParams(name = "Paramaters", geneSetCollection = gsc, geneIds = deg, universeGeneIds = bg, ontology = "BP", pvalueCutoff = 0.0001, conditional = FALSE, testDirection = "over")
  
  #run hyperGTest 
  result <- hyperGTest(p)
  #view the result 
  head(summary(result))
  
  #upgrade the number of "max.print"
  options(max.print=100000)
  
  #setting the output filename
  ONTOLOGY="BP"
  Pval="0.0001"
  SAVEFILENAME <- paste(file.name,"_GOHYP_",ONTOLOGY,"_",Pval,".txt",sep="")
  
  #output the result
  write.table(summary(result), file = SAVEFILENAME, sep="\t")
  print (SAVEFILENAME)
}


