#############################First scenario all RSUs free -  Server E

#Compute Server E received
traceserver_e_fs<-read.table(file = 'server_etf_car_fs_tt.txt', sep=' ')
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
tracecar_e_fs<-read.table(file = 'cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_e_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fs$time <- as.POSIXlt(tracecar_e_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e_fs$size<- tracecar_e_fs$size*8
sum1segcar_e_fs<-aggregate(list(size = tracecar_e_fs$size), list(segundos = cut(tracecar_e_fs$time, "1 sec")), sum)
mean1segcar_e_fs<-append(list(size = sum1segcar_e_fs$size), list(time =  as.numeric(sum1segcar_e_fs$segundos)))
mean1segcar_e_fs$size[1:150]<- mean1segcar_e_fs$size[1:150]/7
mean1segcar_e_fs$size[151:225]<- mean1segcar_e_fs$size[151:225]/11
mean1segcar_e_fs$size[226:300]<- mean1segcar_e_fs$size[226:300]/15

#Compute Delay Server E
tracedelay_e_fs<-read.table(file = 'delay_e_fs_tt.txt')
names(tracedelay_e_fs)<-c("time", "delay")
tracedelay_e_fs$time <- as.POSIXlt(tracedelay_e_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fs<-aggregate(list(delay = tracedelay_e_fs$delay), list(segundos = cut(tracedelay_e_fs$time, "1 sec")), sum)
mean1segdelay_e_fs<-append(list(size = sum1segdelay_e_fs$delay), list(time = as.numeric(sum1segdelay_e_fs$segundos)))
mean1segdelay_e_fs$size[1:150]<- mean1segdelay_e_fs$size[1:150]/7
mean1segdelay_e_fs$size[151:225]<- mean1segdelay_e_fs$size[151:225]/11
mean1segdelay_e_fs$size[226:300]<- mean1segdelay_e_fs$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_e_fs$time[1:300], mean1segserver_e_fs$size[1:300], type="l", col="blue", main = "Server E (FS)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,1000000), xlab = "time(s)")
lines(mean1segcar_e_fs$time[1:300], mean1segcar_e_fs$size[1:300], col="red", lwd=2, ylim = c(0,1000000))
par(new=T)
plot(mean1segdelay_e_fs$time[1:300], mean1segdelay_e_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,2000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E
pdr1seg_e_fs<-mean1segserver_e_fs$size/mean1segcar_e_fs$size
plot(mean1segserver_e_fs$time, pdr1seg_e_fs, type="l", col="blue", main = "Server E PDR (FS)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.2), xlab = "time(s)")

boxplot(pdr1seg_e_fs[1:300], ylim = c(0.96,1.04), main = "Server E PDR (FS)", lwd=2, ylab="PDR")

#############################First scenario all RSUs free -  Server G

#Compute Server G received
traceserver_g_fs<-read.table(file = 'server_gtf_car_fs_tt.txt', sep=' ')
names(traceserver_g_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_g_fs$time <- as.POSIXlt(traceserver_g_fs$time, origin = "1987-10-05 11:00:00")
traceserver_g_fs$size<- traceserver_g_fs$size*8
sum1segserver_g_fs<-aggregate(list(size = traceserver_g_fs$size), list(segundos = cut(traceserver_g_fs$time, "1 sec")), sum)
mean1segserver_g_fs<-append(list(size = sum1segserver_g_fs$size/7), list(time = sum1segserver_g_fs$segundos))
mean1segserver_g_fs$time <- as.numeric(mean1segserver_g_fs$time)

#Compute Car sent Server G
tracecar_g_fs<-read.table(file = 'cartf_fs_5005_tt.txt', sep=' ')
names(tracecar_g_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fs$time <- as.POSIXlt(tracecar_g_fs$time, origin = "1987-10-05 11:00:00")
tracecar_g_fs$size<- tracecar_g_fs$size*8
sum1segcar_g_fs<-aggregate(list(size = tracecar_g_fs$size), list(segundos = cut(tracecar_g_fs$time, "1 sec")), sum)
mean1segcar_g_fs<-append(list(size = sum1segcar_g_fs$size/7), list(time = sum1segcar_g_fs$segundos))
mean1segcar_g_fs$time <- as.numeric(mean1segcar_g_fs$time)

#Compute Delay Server G
tracedelay_g_fs<-read.table(file = 'delay_g_fs_tt.txt')
names(tracedelay_g_fs)<-c("time", "delay")
tracedelay_g_fs$time <- as.POSIXlt(tracedelay_g_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_g_fs<-aggregate(list(delay = tracedelay_g_fs$delay), list(segundos = cut(tracedelay_g_fs$time, "1 sec")), sum)
mean1segdelay_g_fs<-append(list(size = sum1segdelay_g_fs$delay/7), list(time = sum1segdelay_g_fs$segundos))
mean1segdelay_g_fs$time <- as.numeric(mean1segdelay_g_fs$time)

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_g_fs$time, mean1segserver_g_fs$size, type="l", col="blue", main = "Server G (FS)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
lines(mean1segcar_g_fs$time, mean1segcar_g_fs$size, col="red", lwd=2)
par(new=T)
plot(mean1segdelay_g_fs$time, mean1segdelay_g_fs$size, type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,50000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server G
pdr1seg_g_fs<-mean1segserver_g_fs$size[1:300]/mean1segcar_g_fs$size[1:300]
plot(mean1segserver_g_fs$time[1:300], pdr1seg_g_fs, type="l", col="blue", main = "Server G PDR (FS)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.2), xlab = "time(s)")

boxplot(pdr1seg_g_fs[1:300], main = "Server G PDR (FS)", lwd=2, ylab="PDR")


###############Server E2

#Compute Server E2 received
traceserver_e2_fs<-read.table(file = 'server_e2tf_car_fs_tt.txt', sep=' ')
names(traceserver_e2_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e2_fs$time <- as.POSIXlt(traceserver_e2_fs$time, origin = "1987-10-05 11:00:00")
traceserver_e2_fs$size<- traceserver_e2_fs$size*8
sum1segserver_e2_fs<-aggregate(list(size = traceserver_e2_fs$size), list(segundos = cut(traceserver_e2_fs$time, "1 sec")), sum)
mean1segserver_e2_fs<-append(list(size = sum1segserver_e2_fs$size/7), list(time = sum1segserver_e2_fs$segundos))
mean1segserver_e2_fs$time <- as.numeric(mean1segserver_e2_fs$time)

#Compute Car sent Server E2
tracecar_e2_fs<-read.table(file = 'cartf_fs_5004_tt.txt', sep=' ')
names(tracecar_e2_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fs$time <- as.POSIXlt(tracecar_e2_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fs$size<- tracecar_e2_fs$size*8
sum1segcar_e2_fs<-aggregate(list(size = tracecar_e2_fs$size), list(segundos = cut(tracecar_e2_fs$time, "1 sec")), sum)
mean1segcar_e2_fs<-append(list(size = sum1segcar_e2_fs$size/7), list(time = sum1segcar_e2_fs$segundos))
mean1segcar_e2_fs$time <- as.numeric(mean1segcar_e2_fs$time)

#Compute Delay Server E2
tracedelay_e2_fs<-read.table(file = 'delay_e2_fs_tt.txt')
names(tracedelay_e2_fs)<-c("time", "delay")
tracedelay_e2_fs$time <- as.POSIXlt(tracedelay_e2_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e2_fs<-aggregate(list(delay = tracedelay_e2_fs$delay), list(segundos = cut(tracedelay_e2_fs$time, "1 sec")), sum)
mean1segdelay_e2_fs<-append(list(size = sum1segdelay_e2_fs$delay/7), list(time = sum1segdelay_e2_fs$segundos))
mean1segdelay_e2_fs$time <- as.numeric(mean1segdelay_e2_fs$time)

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_e2_fs$time, mean1segserver_e2_fs$size, type="l", col="blue", main = "Server E2 (FS)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,1500000), xlab = "time(s)")
lines(mean1segcar_e2_fs$time, mean1segcar_e2_fs$size, col="red", lwd=2)
par(new=T)
plot(mean1segdelay_e2_fs$time, mean1segdelay_e2_fs$size, type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,2000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E2
pdr1seg_e2_fs<-mean1segserver_e2_fs$size[1:300]/mean1segcar_e2_fs$size[1:300]
plot(mean1segserver_e2_fs$time[1:300], pdr1seg_e2_fs, type="l", col="blue", main = "Server E2 PDR (FS)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.2), xlab = "time(s)")

boxplot(pdr1seg_e2_fs[1:300], main = "Server E2 PDR (FS)", lwd=2, ylab="PDR", ylim = c(0.95,1.03))

######################################################Server S
#Compute Server S received
traceserver_s_fs<-read.table(file = 'server_stf_car_fs_tt.txt', sep=' ')
names(traceserver_s_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_s_fs$time <- as.POSIXlt(traceserver_s_fs$time, origin = "1987-10-05 11:00:00")
traceserver_s_fs$size<- traceserver_s_fs$size*8
sum1segserver_s_fs<-aggregate(list(size = traceserver_s_fs$size), list(segundos = cut(traceserver_s_fs$time, "1 sec")), sum)
mean1segserver_s_fs<-append(list(size = sum1segserver_s_fs$size/7), list(time = sum1segserver_s_fs$segundos))
mean1segserver_s_fs$time <- as.numeric(mean1segserver_s_fs$time)

#Compute Car sent Server S
tracecar_s_fs<-read.table(file = 'cartf_fs_5002_tt.txt', sep=' ')
names(tracecar_s_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fs$time <- as.POSIXlt(tracecar_s_fs$time, origin = "1987-10-05 11:00:00")
tracecar_s_fs$size<- tracecar_s_fs$size*8
sum1segcar_s_fs<-aggregate(list(size = tracecar_s_fs$size), list(segundos = cut(tracecar_s_fs$time, "1 sec")), sum)
mean1segcar_s_fs<-append(list(size = sum1segcar_s_fs$size/7), list(time = sum1segcar_s_fs$segundos))
mean1segcar_s_fs$time <- as.numeric(mean1segcar_s_fs$time)

#Compute Delay Server S
tracedelay_s_fs<-read.table(file = 'delay_s_fs_tt.txt')
names(tracedelay_s_fs)<-c("time", "delay")
tracedelay_s_fs$time <- as.POSIXlt(tracedelay_s_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_s_fs<-aggregate(list(delay = tracedelay_s_fs$delay), list(segundos = cut(tracedelay_s_fs$time, "1 sec")), sum)
mean1segdelay_s_fs<-append(list(size = sum1segdelay_s_fs$delay/7), list(time = sum1segdelay_s_fs$segundos))
mean1segdelay_s_fs$time <- as.numeric(mean1segdelay_s_fs$time)

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_s_fs$time, mean1segserver_s_fs$size, type="l", col="blue", main = "Server S (FS)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,1000000), xlab = "time(s)")
lines(mean1segcar_s_fs$time, mean1segcar_s_fs$size, col="red", lwd=2)
par(new=T)
plot(mean1segdelay_s_fs$time, mean1segdelay_s_fs$size, type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,50))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server S
pdr1seg_s_fs<-mean1segserver_s_fs$size[1:300]/mean1segcar_s_fs$size[1:300]
plot(mean1segserver_s_fs$time[1:300], pdr1seg_s_fs, type="l", col="blue", main = "Server S PDR (FS)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.2), xlab = "time(s)")

boxplot(pdr1seg_s_fs[1:300], main = "Server S PDR (FS)", lwd=2, ylab="PDR", ylim = c(0.97,1.02))
