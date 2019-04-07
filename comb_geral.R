#Combined 300 sec graphs

#App E 
#FS
#############################First scenario all RSUs free -  Server E

#Compute Server E received
traceserver_e_fs<-read.table(file = 'result/server_etf_car_fs_tt.txt', sep=' ')
names(traceserver_e_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fs$time <- as.POSIXlt(traceserver_e_fs$time, origin = "1987-10-05 11:00:00")
traceserver_e_fs$size<- traceserver_e_fs$size*8
sum1segserver_e_fs<-aggregate(list(size = traceserver_e_fs$size), list(segundos = cut(traceserver_e_fs$time, "1 sec")), sum)
mean1segserver_e_fs<-append(list(size = sum1segserver_e_fs$size), list(time = as.numeric(sum1segserver_e_fs$segundos)))
mean1segserver_e_fs$size[1:150]<- mean1segserver_e_fs$size[1:150]/7
mean1segserver_e_fs$size[151:225]<- mean1segserver_e_fs$size[151:225]/11
mean1segserver_e_fs$size[226:300]<- mean1segserver_e_fs$size[226:300]/15

#Compute Car sent Server E
tracecar_e_fs<-read.table(file = 'result/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_e_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fs$time <- as.POSIXlt(tracecar_e_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e_fs$size<- tracecar_e_fs$size*8
sum1segcar_e_fs<-aggregate(list(size = tracecar_e_fs$size), list(segundos = cut(tracecar_e_fs$time, "1 sec")), sum)
mean1segcar_e_fs<-append(list(size = sum1segcar_e_fs$size), list(time =  as.numeric(sum1segcar_e_fs$segundos)))
mean1segcar_e_fs$size[1:150]<- mean1segcar_e_fs$size[1:150]/7
mean1segcar_e_fs$size[151:225]<- mean1segcar_e_fs$size[151:225]/11
mean1segcar_e_fs$size[226:300]<- mean1segcar_e_fs$size[226:300]/15

#Compute Delay Server E
tracedelay_e_fs<-read.table(file = 'result/delay_e_fs_tt.txt')
names(tracedelay_e_fs)<-c("time", "delay")
tracedelay_e_fs$time <- as.POSIXlt(tracedelay_e_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fs<-aggregate(list(delay = tracedelay_e_fs$delay), list(segundos = cut(tracedelay_e_fs$time, "1 sec")), sum)
mean1segdelay_e_fs<-append(list(size = sum1segdelay_e_fs$delay), list(time = as.numeric(sum1segdelay_e_fs$segundos)))
mean1segdelay_e_fs$size[1:150]<- mean1segdelay_e_fs$size[1:150]/7
mean1segdelay_e_fs$size[151:225]<- mean1segdelay_e_fs$size[151:225]/11
mean1segdelay_e_fs$size[226:300]<- mean1segdelay_e_fs$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_e_fs$time[1:300], mean1segserver_e_fs$size[1:300], type="l", col="blue", main = "Application E (Framework)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
plot(mean1segserver_e_fs$time[1:300], mean1segserver_e_fs$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_e_fs$time[1:300], mean1segcar_e_fs$size[1:300], col="red", lwd=2, ylim = c(0,700000), lty=6)
par(new=T)
plot(mean1segdelay_e_fs$time[1:300], mean1segdelay_e_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,20000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FQ
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
#plot(mean1segserver_e_fq$time[1:300], mean1segserver_e_fq$size[1:300], type="l", col="blue", main = "Application E (QoS)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
plot(mean1segserver_e_fq$time[1:300], mean1segserver_e_fq$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_e_fq$time[1:300], mean1segcar_e_fq$size[1:300], col="red", lwd=2, ylim = c(0,700000), lty=6)
par(new=T)
plot(mean1segdelay_e_fq$time[1:300], mean1segdelay_e_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,20000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FN

#Compute Server E received
traceserver_e_fn<-read.table(file = 'result/server_etf_car_fn_tt.txt', sep=' ')
names(traceserver_e_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fn$time <- as.POSIXlt(traceserver_e_fn$time, origin = "1987-10-05 11:00:00")
traceserver_e_fn$size<- traceserver_e_fn$size*8
sum1segserver_e_fn<-aggregate(list(size = traceserver_e_fn$size), list(segundos = cut(traceserver_e_fn$time, "1 sec")), sum)
mean1segserver_e_fn<-append(list(size = sum1segserver_e_fn$size), list(time = as.numeric(sum1segserver_e_fn$segundos)))
mean1segserver_e_fn$size[1:150]<- mean1segserver_e_fn$size[1:150]/7
mean1segserver_e_fn$size[151:225]<- mean1segserver_e_fn$size[151:225]/11
mean1segserver_e_fn$size[226:300]<- mean1segserver_e_fn$size[226:300]/15

#Compute Car sent Server E
tracecar_e_fn<-read.table(file = 'result/cartf_fn_5003_tt.txt', sep=' ')
names(tracecar_e_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fn$time <- as.POSIXlt(tracecar_e_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e_fn$size<- tracecar_e_fn$size*8
sum1segcar_e_fn<-aggregate(list(size = tracecar_e_fn$size), list(segundos = cut(tracecar_e_fn$time, "1 sec")), sum)
mean1segcar_e_fn<-append(list(size = sum1segcar_e_fn$size), list(time =  as.numeric(sum1segcar_e_fn$segundos)))
mean1segcar_e_fn$size[1:150]<- mean1segcar_e_fn$size[1:150]/7
mean1segcar_e_fn$size[151:225]<- mean1segcar_e_fn$size[151:225]/11
mean1segcar_e_fn$size[226:300]<- mean1segcar_e_fn$size[226:300]/15

#Compute Delay Server E
tracedelay_e_fn<-read.table(file = 'result/delay_e_fn_tt.txt')
names(tracedelay_e_fn)<-c("time", "delay")
tracedelay_e_fn$time <- as.POSIXlt(tracedelay_e_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fn<-aggregate(list(delay = tracedelay_e_fn$delay), list(segundos = cut(tracedelay_e_fn$time, "1 sec")), sum)
mean1segdelay_e_fn<-append(list(size = sum1segdelay_e_fn$delay), list(time = as.numeric(sum1segdelay_e_fn$segundos)))
mean1segdelay_e_fn$size[1:150]<- mean1segdelay_e_fn$size[1:150]/7
mean1segdelay_e_fn$size[151:225]<- mean1segdelay_e_fn$size[151:225]/11
mean1segdelay_e_fn$size[226:300]<- mean1segdelay_e_fn$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_e_fn$time[1:300], mean1segserver_e_fn$size[1:300], type="l", col="blue", main = "Application E (Best Effort)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
plot(mean1segserver_e_fn$time[1:300], mean1segserver_e_fn$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_e_fn$time[1:300], mean1segcar_e_fn$size[1:300], col="red", lwd=2, ylim = c(0,700000), lty=6)
par(new=T)
plot(mean1segdelay_e_fn$time[1:300], mean1segdelay_e_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,20000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

###########################################################App E2

#############################First scenario all RSUs free -  Server E2

#Compute Server E2 received
traceserver_e2_fs<-read.table(file = 'result/server_e2tf_car_fs_tt.txt', sep=' ')
names(traceserver_e2_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e2_fs$time <- as.POSIXlt(traceserver_e2_fs$time, origin = "1987-10-05 11:00:00")
traceserver_e2_fs$size<- traceserver_e2_fs$size*8
sum1segserver_e2_fs<-aggregate(list(size = traceserver_e2_fs$size), list(segundos = cut(traceserver_e2_fs$time, "1 sec")), sum)
mean1segserver_e2_fs<-append(list(size = sum1segserver_e2_fs$size), list(time = as.numeric(sum1segserver_e2_fs$segundos)))
mean1segserver_e2_fs$size[1:150]<- mean1segserver_e2_fs$size[1:150]/7
mean1segserver_e2_fs$size[151:225]<- mean1segserver_e2_fs$size[151:225]/11
mean1segserver_e2_fs$size[226:300]<- mean1segserver_e2_fs$size[226:300]/15

#Compute Car sent Server E2
tracecar_e2_fs<-read.table(file = 'result/cartf_fs_5004_tt.txt', sep=' ')
names(tracecar_e2_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fs$time <- as.POSIXlt(tracecar_e2_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fs$size<- tracecar_e2_fs$size*8
sum1segcar_e2_fs<-aggregate(list(size = tracecar_e2_fs$size), list(segundos = cut(tracecar_e2_fs$time, "1 sec")), sum)
mean1segcar_e2_fs<-append(list(size = sum1segcar_e2_fs$size), list(time =  as.numeric(sum1segcar_e2_fs$segundos)))
mean1segcar_e2_fs$size[1:150]<- mean1segcar_e2_fs$size[1:150]/7
mean1segcar_e2_fs$size[151:225]<- mean1segcar_e2_fs$size[151:225]/11
mean1segcar_e2_fs$size[226:300]<- mean1segcar_e2_fs$size[226:300]/15

#Compute Delay Server E2
tracedelay_e2_fs<-read.table(file = 'result/delay_e2_fs_tt.txt')
names(tracedelay_e2_fs)<-c("time", "delay")
tracedelay_e2_fs$time <- as.POSIXlt(tracedelay_e2_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e2_fs<-aggregate(list(delay = tracedelay_e2_fs$delay), list(segundos = cut(tracedelay_e2_fs$time, "1 sec")), sum)
mean1segdelay_e2_fs<-append(list(size = sum1segdelay_e2_fs$delay), list(time = as.numeric(sum1segdelay_e2_fs$segundos)))
mean1segdelay_e2_fs$size[1:150]<- mean1segdelay_e2_fs$size[1:150]/7
mean1segdelay_e2_fs$size[151:225]<- mean1segdelay_e2_fs$size[151:225]/11
mean1segdelay_e2_fs$size[226:300]<- mean1segdelay_e2_fs$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_e2_fs$time[1:300], mean1segserver_e2_fs$size[1:300], type="l", col="blue", main = "Application E2 (Framework)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)")
plot(mean1segserver_e2_fs$time[1:300], mean1segserver_e2_fs$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_e2_fs$time[1:300], mean1segcar_e2_fs$size[1:300], col="red", lwd=2, ylim = c(0,1300000), lty=6)
par(new=T)
plot(mean1segdelay_e2_fs$time[1:300], mean1segdelay_e2_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,10000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FQ
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
#plot(mean1segserver_e2_fq$time[1:300], mean1segserver_e2_fq$size[1:300], type="l", col="blue", main = "Application E2 (QoS)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)")
plot(mean1segserver_e2_fq$time[1:300], mean1segserver_e2_fq$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_e2_fq$time[1:300], mean1segcar_e2_fq$size[1:300], col="red", lwd=2, ylim = c(0,1300000), lty=6)
par(new=T)
plot(mean1segdelay_e2_fq$time[1:300], mean1segdelay_e2_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,10000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FN

#Compute Server E2 received
traceserver_e2_fn<-read.table(file = 'result/server_e2tf_car_fn_tt.txt', sep=' ')
names(traceserver_e2_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e2_fn$time <- as.POSIXlt(traceserver_e2_fn$time, origin = "1987-10-05 11:00:00")
traceserver_e2_fn$size<- traceserver_e2_fn$size*8
sum1segserver_e2_fn<-aggregate(list(size = traceserver_e2_fn$size), list(segundos = cut(traceserver_e2_fn$time, "1 sec")), sum)
mean1segserver_e2_fn<-append(list(size = sum1segserver_e2_fn$size), list(time = as.numeric(sum1segserver_e2_fn$segundos)))
mean1segserver_e2_fn$size[1:150]<- mean1segserver_e2_fn$size[1:150]/7
mean1segserver_e2_fn$size[151:225]<- mean1segserver_e2_fn$size[151:225]/11
mean1segserver_e2_fn$size[226:300]<- mean1segserver_e2_fn$size[226:300]/15

#Compute Car sent Server E2
tracecar_e2_fn<-read.table(file = 'result/cartf_fn_5004_tt.txt', sep=' ')
names(tracecar_e2_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fn$time <- as.POSIXlt(tracecar_e2_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fn$size<- tracecar_e2_fn$size*8
sum1segcar_e2_fn<-aggregate(list(size = tracecar_e2_fn$size), list(segundos = cut(tracecar_e2_fn$time, "1 sec")), sum)
mean1segcar_e2_fn<-append(list(size = sum1segcar_e2_fn$size), list(time =  as.numeric(sum1segcar_e2_fn$segundos)))
mean1segcar_e2_fn$size[1:150]<- mean1segcar_e2_fn$size[1:150]/7
mean1segcar_e2_fn$size[151:225]<- mean1segcar_e2_fn$size[151:225]/11
mean1segcar_e2_fn$size[226:300]<- mean1segcar_e2_fn$size[226:300]/15

#Compute Delay Server E2
tracedelay_e2_fn<-read.table(file = 'result/delay_e2_fn_tt.txt')
names(tracedelay_e2_fn)<-c("time", "delay")
tracedelay_e2_fn$time <- as.POSIXlt(tracedelay_e2_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e2_fn<-aggregate(list(delay = tracedelay_e2_fn$delay), list(segundos = cut(tracedelay_e2_fn$time, "1 sec")), sum)
mean1segdelay_e2_fn<-append(list(size = sum1segdelay_e2_fn$delay), list(time = as.numeric(sum1segdelay_e2_fn$segundos)))
mean1segdelay_e2_fn$size[1:150]<- mean1segdelay_e2_fn$size[1:150]/7
mean1segdelay_e2_fn$size[151:225]<- mean1segdelay_e2_fn$size[151:225]/11
mean1segdelay_e2_fn$size[226:300]<- mean1segdelay_e2_fn$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_e2_fn$time[1:300], mean1segserver_e2_fn$size[1:300], type="l", col="blue", main = "Application E2 (Best effort)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)")
plot(mean1segserver_e2_fn$time[1:300], mean1segserver_e2_fn$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_e2_fn$time[1:300], mean1segcar_e2_fn$size[1:300], col="red", lwd=2, ylim = c(0,1300000), lty=6)
par(new=T)
plot(mean1segdelay_e2_fn$time[1:300], mean1segdelay_e2_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,10000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

############################################################App G

#Compute Server G received
traceserver_g_fs<-read.table(file = 'result/server_gtf_car_fs_tt.txt', sep=' ')
names(traceserver_g_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_g_fs$time <- as.POSIXlt(traceserver_g_fs$time, origin = "1987-10-05 11:00:00")
traceserver_g_fs$size<- traceserver_g_fs$size*8
sum1segserver_g_fs<-aggregate(list(size = traceserver_g_fs$size), list(segundos = cut(traceserver_g_fs$time, "1 sec")), sum)
mean1segserver_g_fs<-append(list(size = sum1segserver_g_fs$size), list(time = as.numeric(sum1segserver_g_fs$segundos)))
mean1segserver_g_fs$size[1:150]<- mean1segserver_g_fs$size[1:150]/7
mean1segserver_g_fs$size[151:225]<- mean1segserver_g_fs$size[151:225]/11
mean1segserver_g_fs$size[226:300]<- mean1segserver_g_fs$size[226:300]/15

#Compute Car sent Server G
tracecar_g_fs<-read.table(file = 'result/cartf_fs_5005_tt.txt', sep=' ')
names(tracecar_g_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fs$time <- as.POSIXlt(tracecar_g_fs$time, origin = "1987-10-05 11:00:00")
tracecar_g_fs$size<- tracecar_g_fs$size*8
sum1segcar_g_fs<-aggregate(list(size = tracecar_g_fs$size), list(segundos = cut(tracecar_g_fs$time, "1 sec")), sum)
mean1segcar_g_fs<-append(list(size = sum1segcar_g_fs$size), list(time =  as.numeric(sum1segcar_g_fs$segundos)))
mean1segcar_g_fs$size[1:150]<- mean1segcar_g_fs$size[1:150]/7
mean1segcar_g_fs$size[151:225]<- mean1segcar_g_fs$size[151:225]/11
mean1segcar_g_fs$size[226:300]<- mean1segcar_g_fs$size[226:300]/15

#Compute Delay Server G
tracedelay_g_fs<-read.table(file = 'result/delay_g_fs_tt.txt')
names(tracedelay_g_fs)<-c("time", "delay")
tracedelay_g_fs$time <- as.POSIXlt(tracedelay_g_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_g_fs<-aggregate(list(delay = tracedelay_g_fs$delay), list(segundos = cut(tracedelay_g_fs$time, "1 sec")), sum)
mean1segdelay_g_fs<-append(list(size = sum1segdelay_g_fs$delay), list(time = as.numeric(sum1segdelay_g_fs$segundos)))
mean1segdelay_g_fs$size[1:150]<- mean1segdelay_g_fs$size[1:150]/7
mean1segdelay_g_fs$size[151:225]<- mean1segdelay_g_fs$size[151:225]/11
mean1segdelay_g_fs$size[226:300]<- mean1segdelay_g_fs$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_g_fs$time[1:300], mean1segserver_g_fs$size[1:300], type="l", col="blue", main = "Application G (Framework)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
plot(mean1segserver_g_fs$time[1:300], mean1segserver_g_fs$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_g_fs$time[1:300], mean1segcar_g_fs$size[1:300], col="red", lwd=2, ylim = c(0,700000), lty=6)
par(new=T)
plot(mean1segdelay_g_fs$time[1:300], mean1segdelay_g_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,80000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FQ
#Compute Server  received
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
#plot(mean1segserver_g_fq$time[1:300], mean1segserver_g_fq$size[1:300], type="l", col="blue", main = "Application G (QoS)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
plot(mean1segserver_g_fq$time[1:300], mean1segserver_g_fq$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_g_fq$time[1:300], mean1segcar_g_fq$size[1:300], col="red", lwd=2, ylim = c(0,700000), lty=6)
par(new=T)
plot(mean1segdelay_g_fq$time[1:300], mean1segdelay_g_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,80000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FN

#Compute Server G received
traceserver_g_fn<-read.table(file = 'result/server_gtf_car_fn_tt.txt', sep=' ')
names(traceserver_g_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_g_fn$time <- as.POSIXlt(traceserver_g_fn$time, origin = "1987-10-05 11:00:00")
traceserver_g_fn$size<- traceserver_g_fn$size*8
sum1segserver_g_fn<-aggregate(list(size = traceserver_g_fn$size), list(segundos = cut(traceserver_g_fn$time, "1 sec")), sum)
mean1segserver_g_fn<-append(list(size = sum1segserver_g_fn$size), list(time = as.numeric(sum1segserver_g_fn$segundos)))
mean1segserver_g_fn$size[1:150]<- mean1segserver_g_fn$size[1:150]/7
mean1segserver_g_fn$size[151:225]<- mean1segserver_g_fn$size[151:225]/11
mean1segserver_g_fn$size[226:300]<- mean1segserver_g_fn$size[226:300]/15

#Compute Car sent Server G
tracecar_g_fn<-read.table(file = 'result/cartf_fn_5005_tt.txt', sep=' ')
names(tracecar_g_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fn$time <- as.POSIXlt(tracecar_g_fn$time, origin = "1987-10-05 11:00:00")
tracecar_g_fn$size<- tracecar_g_fn$size*8
sum1segcar_g_fn<-aggregate(list(size = tracecar_g_fn$size), list(segundos = cut(tracecar_g_fn$time, "1 sec")), sum)
mean1segcar_g_fn<-append(list(size = sum1segcar_g_fn$size), list(time =  as.numeric(sum1segcar_g_fn$segundos)))
mean1segcar_g_fn$size[1:150]<- mean1segcar_g_fn$size[1:150]/7
mean1segcar_g_fn$size[151:225]<- mean1segcar_g_fn$size[151:225]/11
mean1segcar_g_fn$size[226:300]<- mean1segcar_g_fn$size[226:300]/15

#Compute Delay Server G
tracedelay_g_fn<-read.table(file = 'result/delay_g_fn_tt.txt')
names(tracedelay_g_fn)<-c("time", "delay")
tracedelay_g_fn$time <- as.POSIXlt(tracedelay_g_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_g_fn<-aggregate(list(delay = tracedelay_g_fn$delay), list(segundos = cut(tracedelay_g_fn$time, "1 sec")), sum)
mean1segdelay_g_fn<-append(list(size = sum1segdelay_g_fn$delay), list(time = as.numeric(sum1segdelay_g_fn$segundos)))
mean1segdelay_g_fn$size[1:150]<- mean1segdelay_g_fn$size[1:150]/7
mean1segdelay_g_fn$size[151:225]<- mean1segdelay_g_fn$size[151:225]/11
mean1segdelay_g_fn$size[226:300]<- mean1segdelay_g_fn$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_g_fn$time[1:300], mean1segserver_g_fn$size[1:300], type="l", col="blue", main = "Application G (Best effort)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
plot(mean1segserver_g_fn$time[1:300], mean1segserver_g_fn$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_g_fn$time[1:300], mean1segcar_g_fn$size[1:300], col="red", lwd=2, ylim = c(0,700000), lty=6)
par(new=T)
plot(mean1segdelay_g_fn$time[1:300], mean1segdelay_g_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,80000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

###########################################################################App S

#Compute Server S received
traceserver_s_fs<-read.table(file = 'result/server_stf_car_fs_tt.txt', sep=' ')
names(traceserver_s_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_s_fs$time <- as.POSIXlt(traceserver_s_fs$time, origin = "1987-10-05 11:00:00")
traceserver_s_fs$size<- traceserver_s_fs$size*8
sum1segserver_s_fs<-aggregate(list(size = traceserver_s_fs$size), list(segundos = cut(traceserver_s_fs$time, "1 sec")), sum)
mean1segserver_s_fs<-append(list(size = sum1segserver_s_fs$size), list(time = as.numeric(sum1segserver_s_fs$segundos)))
mean1segserver_s_fs$size[1:150]<- mean1segserver_s_fs$size[1:150]/7
mean1segserver_s_fs$size[151:225]<- mean1segserver_s_fs$size[151:225]/11
mean1segserver_s_fs$size[226:300]<- mean1segserver_s_fs$size[226:300]/15

#Compute Car sent Server S
tracecar_s_fs<-read.table(file = 'result/cartf_fs_5002_tt.txt', sep=' ')
names(tracecar_s_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fs$time <- as.POSIXlt(tracecar_s_fs$time, origin = "1987-10-05 11:00:00")
tracecar_s_fs$size<- tracecar_s_fs$size*8
sum1segcar_s_fs<-aggregate(list(size = tracecar_s_fs$size), list(segundos = cut(tracecar_s_fs$time, "1 sec")), sum)
mean1segcar_s_fs<-append(list(size = sum1segcar_s_fs$size), list(time =  as.numeric(sum1segcar_s_fs$segundos)))
mean1segcar_s_fs$size[1:150]<- mean1segcar_s_fs$size[1:150]/7
mean1segcar_s_fs$size[151:225]<- mean1segcar_s_fs$size[151:225]/11
mean1segcar_s_fs$size[226:300]<- mean1segcar_s_fs$size[226:300]/15

#Compute Delay Server S
tracedelay_s_fs<-read.table(file = 'result/delay_s_fs_tt.txt')
names(tracedelay_s_fs)<-c("time", "delay")
tracedelay_s_fs$time <- as.POSIXlt(tracedelay_s_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_s_fs<-aggregate(list(delay = tracedelay_s_fs$delay), list(segundos = cut(tracedelay_s_fs$time, "1 sec")), sum)
mean1segdelay_s_fs<-append(list(size = sum1segdelay_s_fs$delay), list(time = as.numeric(sum1segdelay_s_fs$segundos)))
mean1segdelay_s_fs$size[1:150]<- mean1segdelay_s_fs$size[1:150]/7
mean1segdelay_s_fs$size[151:225]<- mean1segdelay_s_fs$size[151:225]/11
mean1segdelay_s_fs$size[226:300]<- mean1segdelay_s_fs$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_s_fs$time[1:300], mean1segserver_s_fs$size[1:300], type="l", col="blue", main = "Application S (Framework)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)")
plot(mean1segserver_s_fs$time[1:300], mean1segserver_s_fs$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_s_fs$time[1:300], mean1segcar_s_fs$size[1:300], col="red", lwd=2, ylim = c(0,900000), lty=6)
par(new=T)
plot(mean1segdelay_s_fs$time[1:300], mean1segdelay_s_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,5000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FQ
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
#plot(mean1segserver_s_fq$time[1:300], mean1segserver_s_fq$size[1:300], type="l", col="blue", main = "Application S (QoS)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)")
plot(mean1segserver_s_fq$time[1:300], mean1segserver_s_fq$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_s_fq$time[1:300], mean1segcar_s_fq$size[1:300], col="red", lwd=2, ylim = c(0,900000), lty=6)
par(new=T)
plot(mean1segdelay_s_fq$time[1:300], mean1segdelay_s_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,5000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)

#FN

#Compute Server S received
traceserver_s_fn<-read.table(file = 'result/server_stf_car_fn_tt.txt', sep=' ')
names(traceserver_s_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_s_fn$time <- as.POSIXlt(traceserver_s_fn$time, origin = "1987-10-05 11:00:00")
traceserver_s_fn$size<- traceserver_s_fn$size*8
sum1segserver_s_fn<-aggregate(list(size = traceserver_s_fn$size), list(segundos = cut(traceserver_s_fn$time, "1 sec")), sum)
mean1segserver_s_fn<-append(list(size = sum1segserver_s_fn$size), list(time = as.numeric(sum1segserver_s_fn$segundos)))
mean1segserver_s_fn$size[1:150]<- mean1segserver_s_fn$size[1:150]/7
mean1segserver_s_fn$size[151:225]<- mean1segserver_s_fn$size[151:225]/11
mean1segserver_s_fn$size[226:300]<- mean1segserver_s_fn$size[226:300]/15

#Compute Car sent Server S
tracecar_s_fn<-read.table(file = 'result/cartf_fn_5002_tt.txt', sep=' ')
names(tracecar_s_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fn$time <- as.POSIXlt(tracecar_s_fn$time, origin = "1987-10-05 11:00:00")
tracecar_s_fn$size<- tracecar_s_fn$size*8
sum1segcar_s_fn<-aggregate(list(size = tracecar_s_fn$size), list(segundos = cut(tracecar_s_fn$time, "1 sec")), sum)
mean1segcar_s_fn<-append(list(size = sum1segcar_s_fn$size), list(time =  as.numeric(sum1segcar_s_fn$segundos)))
mean1segcar_s_fn$size[1:150]<- mean1segcar_s_fn$size[1:150]/7
mean1segcar_s_fn$size[151:225]<- mean1segcar_s_fn$size[151:225]/11
mean1segcar_s_fn$size[226:300]<- mean1segcar_s_fn$size[226:300]/15

#Compute Delay Server S
tracedelay_s_fn<-read.table(file = 'result/delay_s_fn_tt.txt')
names(tracedelay_s_fn)<-c("time", "delay")
tracedelay_s_fn$time <- as.POSIXlt(tracedelay_s_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_s_fn<-aggregate(list(delay = tracedelay_s_fn$delay), list(segundos = cut(tracedelay_s_fn$time, "1 sec")), sum)
mean1segdelay_s_fn<-append(list(size = sum1segdelay_s_fn$delay), list(time = as.numeric(sum1segdelay_s_fn$segundos)))
mean1segdelay_s_fn$size[1:150]<- mean1segdelay_s_fn$size[1:150]/7
mean1segdelay_s_fn$size[151:225]<- mean1segdelay_s_fn$size[151:225]/11
mean1segdelay_s_fn$size[226:300]<- mean1segdelay_s_fn$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
#plot(mean1segserver_s_fn$time[1:300], mean1segserver_s_fn$size[1:300], type="l", col="blue", main = "Application S (Best effort)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)")
plot(mean1segserver_s_fn$time[1:300], mean1segserver_s_fn$size[1:300], type="l", col="blue", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)", lty=2, cex.axis=1.5, cex.lab=1.5)
lines(mean1segcar_s_fn$time[1:300], mean1segcar_s_fn$size[1:300], col="red", lwd=2, ylim = c(0,900000), lty=6)
par(new=T)
plot(mean1segdelay_s_fn$time[1:300], mean1segdelay_s_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,5000))
axis(side = 4, cex.axis=1.5)
mtext(side = 4, line = 3, 'RTT (ms)', cex=1.5)
legend("topright", legend=c("Server received", "Car Sent", "RTT"), lty=c(2,6,1), col=c("blue", "red", "orange"), cex=1.3)
