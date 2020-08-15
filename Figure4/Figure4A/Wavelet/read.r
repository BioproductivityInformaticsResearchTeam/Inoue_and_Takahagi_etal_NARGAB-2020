#

# read data
Data_Bd   = read.csv("Bd_RPM_selected.csv",header=T)  #Bd
m_n = nrow(Data_Bd)
m_t = 6   # number of time points

Data = array(dim=c(m_n, 3, m_t))
for(k in 1:3){
  Data[ , k, ]   = as.matrix(Data_Bd[, 1+(1:6)*3-(3-k)])
  #  Data[ , k+3, ] = as.matrix(Data_Bd[, 1+(7:12)*3-(3-k)])
}
# log2(x+1)
Data = log2(Data+1)


par(mar=c(4,4,1,1))
for(i in 1:m_n){
  plot( 1:(m_t*3), c(Data[i,1,],Data[i,2,], Data[i,3,]), type="l", 
        ylim=range(Data[i,,]),xlab="", ylab="Expression", main=i)
  Sys.sleep(0.3)
}


m_n = dim(Data)[1]
res_p = array(dim=c(m_n, 19, 6))

for(k in 1:6){
  buf = paste("permute6/", k, "_p_Bd.csv", sep="")

  res_p[, , k] = as.matrix(read.csv(buf,header = T,row.names = 1))
  print(k)
}

#####
buf = res_p[,19,]<0.05
res = apply(buf, 1, sum)
sum(res>=3)

#####

a = which(res>=6)  
b = Data_Bd[a, ]
write.csv(b, "select.csv")


#####
# power spectorum
m_n = dim(Data)[1]
res_pow = array(dim=c(m_n, 18, 6))

for(k in 1:6){
  buf = paste("permute6/", k, "_pow_Bd.csv", sep="")
  
  #  res_p[, , k] = as.matrix(read.csv(buf,header = T)[,38])<0.01
  res_pow[, , k] = as.matrix(read.csv(buf,header = T,row.names = 1))
  print(k)
}


### pick up power spectra
buf = apply(res_pow[,,1], 1, mean)
num_pow = intersect(which(buf>3.5), which(buf<Inf))
num = num_pow

name = c(10,14,18,22,2,6)
par(mar=c(5,5,2,2))
plot(1:6, 1:6,type="n", ylab="Expression", xlab="Time",xaxt="n", yaxt="n", cex.axis=1.2, cex.lab=1.2)
axis(side=1, at=1:6, cex.axis=1.2, labels=name)
par(new=T)
for(i in 1:length(num)){
  plot( 1:(m_t), Data[num[i],1,], type="l", 
        ylim=range(Data[num[i],,]),xlab="", ylab="", main="", yaxt="n", xaxt="n", lwd=3, col="gray")
  par(new=T)
}
plot( 1:(m_t), Data[num[i],1,], type="l", 
      ylim=range(Data[num[i],,]),xlab="", ylab="", main="", lwd=3, xaxt="n",
      cex.axis=1.2)
par(new=F)



#####
# phase
m_n = dim(Data)[1]
res_phase = array(dim=c(m_n, 18, 6))

for(k in 1:6){
  buf = paste("permute6/", k, "_phase_Bd.csv", sep="")
  
  res_phase[, , k] = as.matrix(read.csv(buf,header = T, row.names = 1))
  print(k)
}

peaktime = matrix(nr=length(a), nc=300)
peaktime2 = 1:length(a)
maxnum = 0
for(i in 1:length(a)){
  peakbuf = NULL
  for(k in 1:6){
    buf = which(cos(res_phase[a[i],,k]) > 0.86)*4+6  # > sqrt(3)/2 sampling period
    peakbuf = append(peakbuf, buf)
  }
  if(maxnum < length(peakbuf)) maxnum = length(peakbuf)
  peakbuf = peakbuf %% 24
  peaktime[i, 1:length(peakbuf)] = peakbuf
  if(min(peakbuf)==2 && max(peakbuf)==22){
    peakbuf[peakbuf==2] = peakbuf[peakbuf==2]+24
  }
  peaktime2[i] = mean(peakbuf) %% 24
}
write.csv(cbind(peaktime2, peaktime), "peaktime.csv")

# plot expression
name = c(10,14,18,22,2,6)
par(mar=c(5,5,2,2))
plot(1:6, 1:6,type="n", ylab="Expression", xlab="Time",xaxt="n", yaxt="n", cex.axis=1.2, cex.lab=1.2)
axis(side=1, at=1:6, cex.axis=1.2, labels=name)
par(new=T)
for(i in 1:length(num)){
  #  plot(c(Data[i,1,,1], Data[i,4,,1], Data[i,2,,1], Data[i,5,,1], Data[i,3,,1], Data[i,6,,1]),type="l")
  #  plot(buf[i,],type="l", ylab="", xlab="", yaxt="n", xaxt="n")
  plot( 1:(m_t), Data[a[num[i]],1,], type="l", 
        ylim=range(Data[a[num[i]],,]),xlab="", ylab="", main="", yaxt="n", xaxt="n", lwd=1, col="gray")
  #  lines(buf[i,],type="l")
  #    Sys.sleep(0.2)
  par(new=T)
}
par(new=F)


