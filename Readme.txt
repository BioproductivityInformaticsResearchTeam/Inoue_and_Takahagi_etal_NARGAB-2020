# NARGAB-2019-109
 Data associated with NARGAB-2019-109

Data associated with RNA-seq analysis in NARGAB-2019-109
/RNA-seq
    /mapping
        SamToFastq2tmap.pl : Perl script code used to QC of raw fastq files and mapping of the clean reads 
        TableS1.xlsx : Mapping results of RNA-seq reads from four Brachypodium species (corresponding to Supplementary Table 1)
        
    /homoeolog_sorting
        samtoolsview_for_Bd14-1.new.pl : Perl script code used to call samtools to convert bam files to sam files 
        homoeolog_sorting_for_Bh.pl : Perl script code used to sort the RNA-seq reads of B. hybridum into the B. distachyon subgenome origin reads and B. stacei subgenome origin reads.  
        homoeolog_sorting_result.xlsx : Results of RNA seq read assignment to B. hybridum subgenomes (corresponding to Supplementary Figure S1)
    
    /featureCounts
        featureCounts.new.pl : Perl script code used to call featureCounts with bam files resulting from RNA-seq read mapping
        make_featureCounts.out.matrix.pl : Perl script code used to make a read count table from output files from featureCounts
        featureCounts.out.matrix.txt : Read count table resulting from featureCounts
        make_featureCounts.out.matrix.header_changed.sorted.pl : Perl script code used to edit header of the read count table
        header_changed.txt : Converted sample names (ex. Bd21.10.1 = species/sub-genomes.time.replicate)
        featureCounts.out.matrix.header_changed.sorted.txt : Read count table with the converted sample names
        N_*.featureCounts.out : Output files from featureCounts
        N_*.featureCounts.out.summary : Summary files associated with the output files from featureCounts
        featureCounts.out.matrix.header_changed.sorted(BhBd+BhBs).xlsx : Read count table including total read count of BhBd and BhBs as Bh
        featureCounts.out.matrix.header_changed.sorted(BhBd+BhBs)(Count2RPM).xlsx : Reads per million mapped reads (RPM) data based on the read count
           
/DEGs
    /DESeq2
        Bd21_col_sta_BhBd_BhBs_Bh.txt : Read count table used to DESeq2
        DESeq2_header.txt : File describing sample groups
        DESeq2_R_script.R : R script code used to make dds.rda file in DESeq2
        DESeq2_R_script2.*.R : R script code used to call DESeq2
        B*_B*.[2-22].txt : Output files from DESeq2 (Species#1_Species#2.time.txt)   
    /expressed_gene_list
        RPM_Bd21_col_sta_BhBd_BhBs_Bh.txt : RPM data table used to identify "expressed genes (RPM ≥1 in all biological replicates) in at least one time)"
        make_expressed_gene_list.pl : Perl script code used to identify "expressed genes (RPM ≥1 in all biological replicates) in at least one time)"
        *.expressed_gene_list.txt : Lists of expressed genes
        collect_num_expressed_genes.pl : Perl script code use to summarize numbers of expressed genes
        collect_num_expressed_genes.pl.stdout : Output file from collect_num_expressed_genes.pl
    /DEG_list
        make_DEG_lists_Up_or_Down_for_BdVscol_BdVsBh_BsVsBh.pl : Perl script code used to make lists of differentially expressed genes between the diploids and tetraploids: Bd vs 4xBd, Bd vs Bh, and Bs vs Bh
        /diploid_vs_tetraploid : Directory containing lists of differentially expressed genes between the diploids and tetraploids
        make_DEG_lists_Up_or_Down_for_colVsBh.pl : Perl script code used to make lists of differentially expressed genes between the auto- and allo-tetraploid: 4xBd vs Bh
        /autotetraploid_vs_allopolyploid : Directory containing lists of differentially expressed genes between the auto- and allo-tetraploid
        make_DEG_lists_Up_or_Down_for_BdVsBs_BhBdVsBhBs.pl : Perl script code used to make lists of differentially expressed genes between the subgenomes in B. hybridum: BhBd vs BhBs
        /BhBd_vs_BhBs : Directory containg lists of differentially expressed genes between the subgenomes

Data associated with every figure
/Figure1
    /Figure1A
        B.distachyon autotetraploid.jpg : Raw data output from CyFlow space in a B.distachyon autotetraploid Bd21 sample
        B.distachyon.jpg : Raw data output from CyFlow space in a B. distachyon Bd21 sample
    /Figure1B
        BT-62o.TIF : Original image file used to Figure 1B
        Scale 100 standard(Right)10um.tif : Micrometer image file used to Figure 1B
     /Figure1C
        /mapping
            tmap_samtools.sh : Shell script code used to map whole-genome sequencing reads from B.distachyon autotetraploid to the B. distachyon Bd21 reference genome
            run.log : Run.log file with the result of mapping
         /circos
            snpcall.pl : Perl script code used to pileup read coverage of B. distachyon autotetraploid on the B. distachyon Bd21 reference genome
            get_same_pos.pl : Perl script code used to identify polymorphic sites between the B.distachyon autotetraploid and B. distachyon Bd21 reference genomes
            same_nucleotide_average.pl : Perl script code used to make same_nucleotide_average_100kb.txt (corresponding to track#2 in the circos plot of Figure 1C)
            get_MQ.pl : Perl script code used to mapping quality data of the B. distachyon autotetraploid on the B. distachyon Bd21 reference genome
            MQ_average.pl : Perl script code used to make MQ_average_100kb.txt (corresponding to track#3 in the circos plot of Figure 1C)
            coverage_average.pl : Perl script code used to make 4xBd_read_cov.1mb.txt (corresponding to track#4 in the circos plot of Figure 1C) 
    /Figure1D
        DSC_0669_Bd21_and_4xBd21_plants.JPG : Original image file used to Figure 1D (Representative diploid Bd21 and autotetraploid Bd21 plants)
    /Figure1E
        B.distachyon.tif : Original image file for grain morphology in Bd21
        B.distachyon_autotetraploid.tif Original image file for grain morphology in autotetraploid Bd21
        Seed_size_measure_IMGP4852.JPG : Original image file for seed size measurement
        Seed_size.xlsx : Excel file use to make the bar graph that represents relative area of seed grains of autotetraploid Bd21 compared with those of Bd21 

/Figure2
    /Figure2A
        RPM_matrix_expressed_genes_average.txt :  Reads per million mapped reads (RPM) data table composed of 23,306 expressed genes (mean RPM of three biological replicates)
        RPM_matrix_for_DESeq2_Up_Down_in_polyploid_RPM_ave_Z2.xlsx : Excel file use to Z-score-based scaling the gene expression level of 23,306 expressed genes
        Expressed_genes_ave_Z.txt : Z-score(RPM) data table use to make the heatmap of Figure2A
        DEG_heatmap_Figure2A.R : R script code make the heatmap of Figure2A
        Expressed_genes_ave_Z.png : Original image data of the heatmap output from DEG_heatmap_Figure2A.R
        Expressed_genes_ave_Z_trimed.png : Trimmed image data the heatmap used to make Figure 2A
    /Figure2B,E
        collect_num_DEGs.pl : Perl script code use to Number of differentially expressed genes
        collect_num_DEGs.pl.stdout : Output file from collect_num_DEGs.pl
        Number_of_DEGs.xlsx : Excel file use to make graphs that represent number of differentially expressed genes (corresponding to Figure 2B and Figure 2E)
    /Figure2C
        *_in_polyploid.txt : Lists of DEGs
        *.svg : Orgincal image files of Venn diagrams (by using http://bioinformatics.psb.ugent.be/webtools/Venn/)
        Up_or_Down_in_polyploid.pptx : PowerPoint file use to make Figure 2C 
    /Figure2D
        /GOStats
            Bdistachyon.edited.annot : GO annotation of genes in the B. distachyon Bd21 genome
            GO_annot_file_edit.pl : Perl scrip code to convert format of the GO annotation of genes in the B. distachyon Bd21 genome
            Bdistachyon.edited.annot.GO_annot_file_edit.pl.stdout : Output file from GO_annot_file_edit.pl
            call_GOstats.R : R script code to call GOStats with GO annotation of genes in the B. distachyon Bd21 genome
            /diploid_vs_tetraploid_GOStats
                *.txt : Output files from call_GOstats.R
                summarize_gostat_data.pl : Perl script code to summarize the results of hyperG test based on GOStats
                summarize*.stdout : Summaized results of the hyperG test based on GOStats
        HyperGtest_GOID_clustered(p0.0001).xlsx : Excel file use to make heatmaps of Figure 2D
    /Figure2F
        /DEGs_col_Bh : Directory containing lists of differentially expressed genes between autotetraploid Bd21 and B. hybridum
        RPM_matrix_for_DESeq2_Up_Down_in_polyploid_RPM_ave_Z(col_Bh).xlsx : Excel file use to Z-score-based scaling the gene expression level of 11,316 DEGs between autotetraploid Bd21 and B. hybridum
        col_Bh_DEG_all_Z.txt : Z-score(RPM) data table use to make the heatmap of Figure2F
        DEG_heatmap_Figure2F.R : R script code to hierarchically cluster 11,316 DEGs
        col_Bh_DEG_all_Z_clustered.txt : List of 11,316 DEGs ordered by using DEG_heatmap_Figure2F.R
        col_Bh_DEG_all_Z_clsutered.xlsx : Excel file use to combine the hierarchically clustered expression profile of the 11,316 DEGs and regulatory patterns in B. hybridum, B. distachyon autotetraploid, B. distachyon, and B. stacei
        col_Bh_DEG_all_Z_clsutered.pdf :  Original image data of the heatmap of Figure2F
/Figure3
    /Figure3A
        Figure3A.pptx : PowerPoint file showing "Categories of HEB pattern"
    /Figure3B,C
        make_DEG_lists_for_BdVsBs_BhBdvsBhBs.pl : Perl Script code used to identify DEGs lists between B. distachion and B. stacei, and those between subgenomes in B. hybridum
        make_DEG_lists_Up_or_Down_for_BdVsBs_BhBdVsBhBs.pl : Perl Script code used to classify the DEGs from make_DEG_lists_for_BdVsBs_BhBdvsBhBs.pl into up- or down- regulated DEGs
        /Homoeolog_expression_bias
            *.DEG_list.txt : DEGs list files output from  make_DEG_lists_for_BdVsBs_BhBdvsBhBs.pl
            *.DEG_list.up_*.txt : Up-regulated DEGs list files output from make_DEG_lists_Up_or_Down_for_BdVsBs_BhBdVsBhBs.pl
            *.DEG_list.down_*.txt : Down-regulated DEGs list files output from make_DEG_lists_Up_or_Down_for_BdVsBs_BhBdVsBhBs.pl
            get_each_exprssion_patterns_each_time.pl : Perl script code used to classify genes to the categories of HEB pattern in Figure3A
            RPM_matrix_for_DESeq2_*.txt : RPM data tables used in get_each_exprssion_patterns_each_time.pl
            *.expressed_genes.txt : Lists of expressed genes used in get_each_exprssion_patterns_each_time.pl
            *P[1-9].*.gene.list.txt : List files of genes classified to each of the categories of HEB pattern in Figure3A
            get_exprssion_patterns_all_timepoints.pl : Perl script code used to convert P[1-9] categories of HEB pattern to numeric 1-9
            get_exprssion_patterns_all_timepoints.pl.stdout : HEB pattern table output from get_exprssion_patterns_all_timepoints.pl
                /Clustering
                    Figure3C.R : R script code used to make clustered heatmap image of Figure3C with get_exprssion_patterns_all_timepoints.pl.stdout
                    get_exprssion_patterns_all_timepoints.pl.png : Clustered heatmap image of Figure3C with get_exprssion_patterns_all_timepoints.pl.stdout
        get_exprssion_patterns_all_timepoints.pl.stdout.xlsx : Excel file used to make Figure 3B                
 
 /Figure4
    /Figure4A
        /15864_genes_in Figure3C
            get_RPM2.pl : Perl script code use to make RPM data table (*_RPM_selected.csv) with get_exprssion_patterns_all_timepoints.pl.stdout
            *_RPM_selected.csv : CSV files of RPM data of the 15864 genes analyzed in Figure3C (corresponding to genes in get_exprssion_patterns_all_timepoints.pl.stdout)
        /Z-scored_RPM
            *_meanRPM_selected_peaktime_estimated.txt : Mean RPM data table of peaktime-estimated genes
            *_meanRPM_selected_peaktime_estimated.Z.txt : Z-scored mean RPM data table of peaktime-estimated genes use to visualize gene expression patterns in heatmaps of Figure 4A
            Z-score.R : R script code use to scale the mean RPM data with the genescale function of the genefilter library
        /Wavelet
            analysis.r : R script code used to estimate expression peaktime and power spectrum of periodic gene expression with the WaveletComp library
            /analysis.r_input
                *_RPM_selected.csv : CSV files of RPM data table of the 15864 genes (input data for analysis.r)
            /analysis.r_output
                /permute6 : Directory containing output files from analysis.r
            read.r : R script code used to select with highly significant power (p < 0.05) of the 24 h cycle as candidates for diurnally-expressed genes                                
        Bd_Bs_Bh_periodic_genes_union_expression.xlsx: Excel file used to combine expression pattern and estimated peaktime for the diurnally-expressed genes, and used to make the heatmaps shown in Figure 4A (Corresponding to Supplementary Table S2-S4)
        
    Figure4B
        BhBd_BhBs_periodic_genes_union_expression.xlsx : Excel file used to combine expression pattern and estimated peaktime for the diurnally-expressed genes, and used to make the heatmaps shown in Figure 4B (Corresponding to Supplementary Table S5 and S6)
    Figure4C    
        get_exprssion_patterns_all_timepoints.pl_periodic_genes.xlsx : Excel file used to assess HEB patterns in the 1,268 rhythmically-expressed genes, and used to make the pie chart shown in Figure 4C 

 /Figure5
    RPM_matrix_for_DESeq2(*).expression.xlsx : Excel files use to make the graphs in Figure 5

 /Figure6
    /Figure6A
        HEB_15864_genes_correlation_graph.xlsx : Excel file used to calculate Pearson’s correlation coefficients between B. distachyon and B. stacei and homoeologues in Bd-subgenome and Bs-subgenome, and used to make the histogram shown in Figure 6A
    /Figure6B    
        periodic_gene_correlation_graph.xlsx :  Excel file used to caluculate Pearson’s correlation coefficients between diurnally-expressed gene pairs in the diploid sister genomes and subgenomes, and used to make the histgram shown in Figure 6B
    /Figure6C
        Bd_Bs_periodic_genes_peaktime_correlation.xlsx : Excel file used to make the scatterplot that represents correlation of peak time of diurnally-expressed genes between B. distachyon and B. stacei
        BhBd_BhBs_periodic_genes_peaktime_correlation.xlsx : Excel file used to make the scatterplot that represents correlation of peak time of diurnally-expressed homoeologues between the Bd-subgenome and Bs-subgenome

/SuppFigure1
    homoeolog_sorting_result.xlsx : Results of RNA seq read assignment to B. hybridum subgenomes (corresponding to Supplementary Figure S1)

/SuppFigure2
    SuppFigure2.pptx : Original image file of Supplementary Figure S2

/SuppFigure3
    periodic_gene_expression_correlation (Bd-BhBs_Bs-BhBd).xlsx : Excel file used to calculate Pearson’s correlation coefficients in diurnally-expressed homoeologues between each of the B. hybridum subgenomes and the sister
genomes of its diploid progenitors





