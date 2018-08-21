#############################First scenario all RSUs free -  Server E

#Compute Server E received
traceserver_e_fq<-read.table(file = 'result/server_etf_car_fq_tt.txt', sep=' ')
names(traceserver_e_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fq$time <- as.POSIXlt(traceserver_e_fq$time, origin = "1987-10-05 11:00:00")
traceserver_e_fq$size<- traceserver_e_fq$size*8
sum1segserver_e_fq<-aggregate(list(size = traceserver_e_fq$size), list(segundos = cut(traceserver_e_fq$time, "1 sec")), sum)
mean1segserver_e_fq<-append(list(size = sum1segserver_e_fq$size), list(time = as.numeric(sum1segserver_e_fq$segundos)))
mean1segserver_e_fq$size[1:150]<- mean1segserver_e_fq$size[1:150]/7
mean1segserver_e_fq$size[151:225]<- mean1segserver_e_fq$size[151:225]/11
mean1segserver_e_fq$size[226:300]<- mean1segserver_e_fq$size[226:300]/15

#Compute Car sent Server E
tracecar_e_fq<-read.table(file = 'result/cartf_fq_5003_tt.txt', sep=' ')
names(tracecar_e_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fq$time <- as.POSIXlt(tracecar_e_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e_fq$size<- tracecar_e_fq$size*8
sum1segcar_e_fq<-aggregate(list(size = tracecar_e_fq$size), list(segundos = cut(tracecar_e_fq$time, "1 sec")), sum)
mean1segcar_e_fq<-append(list(size = sum1segcar_e_fq$size), list(time =  as.numeric(sum1segcar_e_fq$segundos)))
mean1segcar_e_fq$size[1:150]<- mean1segcar_e_fq$size[1:150]/7
mean1segcar_e_fq$size[151:225]<- mean1segcar_e_fq$size[151:225]/11
mean1segcar_e_fq$size[226:300]<- mean1segcar_e_fq$size[226:300]/15

#Compute Delay Server E
tracedelay_e_fq<-read.table(file = 'result/delay_e_fq_tt.txt')
names(tracedelay_e_fq)<-c("time", "delay")
tracedelay_e_fq$time <- as.POSIXlt(tracedelay_e_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fq<-aggregate(list(delay = tracedelay_e_fq$delay), list(segundos = cut(tracedelay_e_fq$time, "1 sec")), sum)
mean1segdelay_e_fq<-append(list(size = sum1segdelay_e_fq$delay), list(time = as.numeric(sum1segdelay_e_fq$segundos)))
mean1segdelay_e_fq$size[1:150]<- mean1segdelay_e_fq$size[1:150]/7
mean1segdelay_e_fq$size[151:225]<- mean1segdelay_e_fq$size[151:225]/11
mean1segdelay_e_fq$size[226:300]<- mean1segdelay_e_fq$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_e_fq$time[1:300], mean1segserver_e_fq$size[1:300], type="l", col="blue", main = "Server E (fq)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,800000), xlab = "time(s)")
lines(mean1segcar_e_fq$time[1:300], mean1segcar_e_fq$size[1:300], col="red", lwd=2, ylim = c(0,800000))
par(new=T)
plot(mean1segdelay_e_fq$time[1:300], mean1segdelay_e_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,50000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E
pdr1seg_e_fq<-mean1segserver_e_fq$size[1:300]/mean1segcar_e_fq$size[1:300]
plot(mean1segserver_e_fq$time[1:300], pdr1seg_e_fq[1:300], type="l", col="blue", main = "Server E PDR (fq)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,7), xlab = "time(s)")

boxplot(pdr1seg_e_fq[1:300], ylim = c(0,1.45), main = "Server E PDR (fq)", lwd=2, ylab="PDR")

#############################First scenario all RSUs free -  Server G

#Compute Server G received
traceserver_g_fq<-read.table(file = 'result/server_gtf_car_fq_tt.txt', sep=' ')
names(traceserver_g_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_g_fq$time <- as.POSIXlt(traceserver_g_fq$time, origin = "1987-10-05 11:00:00")
traceserver_g_fq$size<- traceserver_g_fq$size*8
sum1segserver_g_fq<-aggregate(list(size = traceserver_g_fq$size), list(segundos = cut(traceserver_g_fq$time, "1 sec")), sum)
mean1segserver_g_fq<-append(list(size = sum1segserver_g_fq$size), list(time = as.numeric(sum1segserver_g_fq$segundos)))
mean1segserver_g_fq$size[1:150]<- mean1segserver_g_fq$size[1:150]/7
mean1segserver_g_fq$size[151:225]<- mean1segserver_g_fq$size[151:225]/11
mean1segserver_g_fq$size[226:300]<- mean1segserver_g_fq$size[226:300]/15

#Compute Car sent Server G
tracecar_g_fq<-read.table(file = 'result/cartf_fq_5005_tt.txt', sep=' ')
names(tracecar_g_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fq$time <- as.POSIXlt(tracecar_g_fq$time, origin = "1987-10-05 11:00:00")
tracecar_g_fq$size<- tracecar_g_fq$size*8
sum1segcar_g_fq<-aggregate(list(size = tracecar_g_fq$size), list(segundos = cut(tracecar_g_fq$time, "1 sec")), sum)
mean1segcar_g_fq<-append(list(size = sum1segcar_g_fq$size), list(time =  as.numeric(sum1segcar_g_fq$segundos)))
mean1segcar_g_fq$size[1:150]<- mean1segcar_g_fq$size[1:150]/7
mean1segcar_g_fq$size[151:225]<- mean1segcar_g_fq$size[151:225]/11
mean1segcar_g_fq$size[226:300]<- mean1segcar_g_fq$size[226:300]/15

#Compute Delay Server G
tracedelay_g_fq<-read.table(file = 'result/delay_g_fq_tt.txt')
names(tracedelay_g_fq)<-c("time", "delay")
tracedelay_g_fq$time <- as.POSIXlt(tracedelay_g_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_g_fq<-aggregate(list(delay = tracedelay_g_fq$delay), list(segundos = cut(tracedelay_g_fq$time, "1 sec")), sum)
mean1segdelay_g_fq<-append(list(size = sum1segdelay_g_fq$delay), list(time = as.numeric(sum1segdelay_g_fq$segundos)))
mean1segdelay_g_fq$size[1:150]<- mean1segdelay_g_fq$size[1:150]/7
mean1segdelay_g_fq$size[151:225]<- mean1segdelay_g_fq$size[151:225]/11
mean1segdelay_g_fq$size[226:300]<- mean1segdelay_g_fq$size[226:300]/15
#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_g_fq$time[1:300], mean1segserver_g_fq$size[1:300], type="l", col="blue", main = "Server G (fq)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,650000), xlab = "time(s)")
lines(mean1segcar_g_fq$time[1:300], mean1segcar_g_fq$size[1:300], col="red", lwd=2, ylim = c(0,650000))
par(new=T)
plot(mean1segdelay_g_fq$time[1:300], mean1segdelay_g_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,50000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server G
pdr1seg_g_fq<-mean1segserver_g_fq$size[1:300]/mean1segcar_g_fq$size[1:300]
plot(mean1segserver_g_fq$time[1:300], pdr1seg_g_fq, type="l", col="blue", main = "Server G PDR (fq)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.4), xlab = "time(s)")

boxplot(pdr1seg_g_fq[1:300], ylim = c(0,1.4),main = "Server G PDR (fq)", lwd=2, ylab="PDR")


###############Server E2

#Compute Server E2 received
traceserver_e2_fq<-read.table(file = 'result/server_e2tf_car_fq_tt.txt', sep=' ')
names(traceserver_e2_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e2_fq$time <- as.POSIXlt(traceserver_e2_fq$time, origin = "1987-10-05 11:00:00")
traceserver_e2_fq$size<- traceserver_e2_fq$size*8
sum1segserver_e2_fq<-aggregate(list(size = traceserver_e2_fq$size), list(segundos = cut(traceserver_e2_fq$time, "1 sec")), sum)
mean1segserver_e2_fq<-append(list(size = sum1segserver_e2_fq$size), list(time = as.numeric(sum1segserver_e2_fq$segundos)))
mean1segserver_e2_fq$size[1:150]<- mean1segserver_e2_fq$size[1:150]/7
mean1segserver_e2_fq$size[151:225]<- mean1segserver_e2_fq$size[151:225]/11
mean1segserver_e2_fq$size[226:300]<- mean1segserver_e2_fq$size[226:300]/15

#Compute Car sent Server E2
tracecar_e2_fq<-read.table(file = 'result/cartf_fq_5004_tt.txt', sep=' ')
names(tracecar_e2_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fq$time <- as.POSIXlt(tracecar_e2_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fq$size<- tracecar_e2_fq$size*8
sum1segcar_e2_fq<-aggregate(list(size = tracecar_e2_fq$size), list(segundos = cut(tracecar_e2_fq$time, "1 sec")), sum)
mean1segcar_e2_fq<-append(list(size = sum1segcar_e2_fq$size), list(time =  as.numeric(sum1segcar_e2_fq$segundos)))
mean1segcar_e2_fq$size[1:150]<- mean1segcar_e2_fq$size[1:150]/7
mean1segcar_e2_fq$size[151:225]<- mean1segcar_e2_fq$size[151:225]/11
mean1segcar_e2_fq$size[226:300]<- mean1segcar_e2_fq$size[226:300]/15

#Compute Delay Server E2
tracedelay_e2_fq<-read.table(file = 'result/delay_e2_fq_tt.txt')
names(tracedelay_e2_fq)<-c("time", "delay")
tracedelay_e2_fq$time <- as.POSIXlt(tracedelay_e2_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e2_fq<-aggregate(list(delay = tracedelay_e2_fq$delay), list(segundos = cut(tracedelay_e2_fq$time, "1 sec")), sum)
mean1segdelay_e2_fq<-append(list(size = sum1segdelay_e2_fq$delay), list(time = as.numeric(sum1segdelay_e2_fq$segundos)))
mean1segdelay_e2_fq$size[1:150]<- mean1segdelay_e2_fq$size[1:150]/7
mean1segdelay_e2_fq$size[151:225]<- mean1segdelay_e2_fq$size[151:225]/11
mean1segdelay_e2_fq$size[226:300]<- mean1segdelay_e2_fq$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_e2_fq$time[1:300], mean1segserver_e2_fq$size[1:300], type="l", col="blue", main = "Server E2 (fq)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)")
lines(mean1segcar_e2_fq$time[1:300], mean1segcar_e2_fq$size[1:300], col="red", lwd=2, ylim = c(0,1300000))
par(new=T)
plot(mean1segdelay_e2_fq$time[1:300], mean1segdelay_e2_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,8000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E2
pdr1seg_e2_fq<-mean1segserver_e2_fq$size[1:300]/mean1segcar_e2_fq$size[1:300]
plot(mean1segserver_e2_fq$time[1:300], pdr1seg_e2_fq, type="l", col="blue", main = "Server E2 PDR (fq)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,6), xlab = "time(s)")

boxplot(pdr1seg_e2_fq[1:300], main = "Server E2 PDR (fq)", lwd=2, ylab="PDR", ylim = c(0.1,1.4))

######################################################Server S
#Compute Server S received
traceserver_s_fq<-read.table(file = 'result/server_stf_car_fq_tt.txt', sep=' ')
names(traceserver_s_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_s_fq$time <- as.POSIXlt(traceserver_s_fq$time, origin = "1987-10-05 11:00:00")
traceserver_s_fq$size<- traceserver_s_fq$size*8
sum1segserver_s_fq<-aggregate(list(size = traceserver_s_fq$size), list(segundos = cut(traceserver_s_fq$time, "1 sec")), sum)
mean1segserver_s_fq<-append(list(size = sum1segserver_s_fq$size), list(time = as.numeric(sum1segserver_s_fq$segundos)))
mean1segserver_s_fq$size[1:150]<- mean1segserver_s_fq$size[1:150]/7
mean1segserver_s_fq$size[151:225]<- mean1segserver_s_fq$size[151:225]/11
mean1segserver_s_fq$size[226:300]<- mean1segserver_s_fq$size[226:300]/15

#Compute Car sent Server S
tracecar_s_fq<-read.table(file = 'result/cartf_fq_5002_tt.txt', sep=' ')
names(tracecar_s_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fq$time <- as.POSIXlt(tracecar_s_fq$time, origin = "1987-10-05 11:00:00")
tracecar_s_fq$size<- tracecar_s_fq$size*8
sum1segcar_s_fq<-aggregate(list(size = tracecar_s_fq$size), list(segundos = cut(tracecar_s_fq$time, "1 sec")), sum)
mean1segcar_s_fq<-append(list(size = sum1segcar_s_fq$size), list(time =  as.numeric(sum1segcar_s_fq$segundos)))
mean1segcar_s_fq$size[1:150]<- mean1segcar_s_fq$size[1:150]/7
mean1segcar_s_fq$size[151:225]<- mean1segcar_s_fq$size[151:225]/11
mean1segcar_s_fq$size[226:300]<- mean1segcar_s_fq$size[226:300]/15

#Compute Delay Server S
tracedelay_s_fq<-read.table(file = 'result/delay_s_fq_tt.txt')
names(tracedelay_s_fq)<-c("time", "delay")
tracedelay_s_fq$time <- as.POSIXlt(tracedelay_s_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_s_fq<-aggregate(list(delay = tracedelay_s_fq$delay), list(segundos = cut(tracedelay_s_fq$time, "1 sec")), sum)
mean1segdelay_s_fq<-append(list(size = sum1segdelay_s_fq$delay), list(time = as.numeric(sum1segdelay_s_fq$segundos)))
mean1segdelay_s_fq$size[1:150]<- mean1segdelay_s_fq$size[1:150]/7
mean1segdelay_s_fq$size[151:225]<- mean1segdelay_s_fq$size[151:225]/11
mean1segdelay_s_fq$size[226:300]<- mean1segdelay_s_fq$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_s_fq$time[1:300], mean1segserver_s_fq$size[1:300], type="l", col="blue", main = "Server S (fq)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,750000), xlab = "time(s)")
lines(mean1segcar_s_fq$time[1:300], mean1segcar_s_fq$size[1:300], col="red", lwd=2,  ylim = c(0,750000))
par(new=T)
plot(mean1segdelay_s_fq$time[1:300], mean1segdelay_s_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,4000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server S
pdr1seg_s_fq<-mean1segserver_s_fq$size[1:300]/mean1segcar_s_fq$size[1:300]
plot(mean1segserver_s_fq$time[1:300], pdr1seg_s_fq, type="l", col="blue", main = "Server S PDR (fq)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,3), xlab = "time(s)")

boxplot(pdr1seg_s_fq[1:300], main = "Server S PDR (fq)", lwd=2, ylab="PDR", ylim = c(0.3,1.3))