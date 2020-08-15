# read data
Data_Bd   = read.csv("Bd_RPM.csv",header=T)  #Bd
m_n = nrow(Data_Bd)
m_t = 6   # number of time points

Data = array(dim=c(m_n, 3, m_t))  
for(k in 1:3){
  Data[ , k, ]   = as.matrix(Data_Bd[, 1+(1:6)*3-(3-k)])
#  Data[ , k+3, ] = as.matrix(Data_Bd[, 1+(7:12)*3-(3-k)])
}

# log2(x+1)
Data = log2(Data+1)

rm(Data_Bd)


###### wavelet 
library(WaveletComp)

#plot
par(mar=c(4,4,1,1))
for(i in 1:m_n){
  plot( 1:(m_t*3), c(Data[i,1,], Data[i,2,],Data[i,3,]), col="blue", type="l", 
        ylim=range(Data[i,,]),xlab="", ylab="Expression", main=i)
  Sys.sleep(0.3)
}

library(gtools)
perm = permutations(3,3)

# power spectrum
res_pow = array(Inf, dim=c(m_n, 3*m_t)) 
res_p = array(Inf, dim=c(m_n, 3*m_t+1))  
res_phase = array(Inf, dim=c(m_n, 3*m_t)) 
per=18
for(k in 1:6){
  for(i in 1:m_n){
    if(sum(Data[i,,])==0) next
    x = as.vector(t(Data[i, perm[k,], ]))      
    # calculate power spectrum
    wtres = analyze.wavelet(data.frame(x=x), dt=1/m_t, dj = 1/ m_t/2, make.pval = T, verbose=F)
    res_pow[i,]        = wtres$Power[per,]
    res_p[i,1:(3*m_t)] = wtres$Power.pval[per,]
    res_p[i,3*m_t+1]   = wtres$Power.avg.pval[per]
    res_phase[i,]      = wtres$Phase[per,]
    if(i%%100==0){
      print(c(k,i))
    }
  }

  write.csv(res_pow, paste(k, "_pow_Bd.csv", sep=""))
  write.csv(res_p, paste(k, "_p_Bd.csv", sep=""))
  write.csv(res_phase, paste(k, "_phase_Bd.csv", sep=""))
  
}

