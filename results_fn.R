#############################First scenario all RSUs free -  Server E

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
plot(mean1segserver_e_fn$time[1:300], mean1segserver_e_fn$size[1:300], type="l", col="blue", main = "Server E (fn)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,650000), xlab = "time(s)")
lines(mean1segcar_e_fn$time[1:300], mean1segcar_e_fn$size[1:300], col="red", lwd=2, ylim = c(0,650000))
par(new=T)
plot(mean1segdelay_e_fn$time[1:300], mean1segdelay_e_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,8000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E
pdr1seg_e_fn<-mean1segserver_e_fn$size[1:300]/mean1segcar_e_fn$size[1:300]
plot(mean1segserver_e_fn$time[1:300], pdr1seg_e_fn[1:300], type="l", col="blue", main = "Server E PDR (fn)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.5), xlab = "time(s)")

boxplot(pdr1seg_e_fn[1:300], ylim = c(0.3,1.2), main = "Server E PDR (fn)", lwd=2, ylab="PDR")

#############################First scenario all RSUs free -  Server G

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
plot(mean1segserver_g_fn$time[1:300], mean1segserver_g_fn$size[1:300], type="l", col="blue", main = "Server G (fn)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,650000), xlab = "time(s)")
lines(mean1segcar_g_fn$time[1:300], mean1segcar_g_fn$size[1:300], col="red", lwd=2, ylim = c(0,650000))
par(new=T)
plot(mean1segdelay_g_fn$time[1:300], mean1segdelay_g_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,50000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server G
pdr1seg_g_fn<-mean1segserver_g_fn$size[1:300]/mean1segcar_g_fn$size[1:300]
plot(mean1segserver_g_fn$time[1:300], pdr1seg_g_fn, type="l", col="blue", main = "Server G PDR (fn)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.4), xlab = "time(s)")

boxplot(pdr1seg_g_fn[1:300], ylim = c(0,1.4),main = "Server G PDR (fn)", lwd=2, ylab="PDR")


###############Server E2

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
plot(mean1segserver_e2_fn$time[1:300], mean1segserver_e2_fn$size[1:300], type="l", col="blue", main = "Server E2 (fn)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,1300000), xlab = "time(s)")
lines(mean1segcar_e2_fn$time[1:300], mean1segcar_e2_fn$size[1:300], col="red", lwd=2, ylim = c(0,1300000))
par(new=T)
plot(mean1segdelay_e2_fn$time[1:300], mean1segdelay_e2_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,8000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E2
pdr1seg_e2_fn<-mean1segserver_e2_fn$size[1:300]/mean1segcar_e2_fn$size[1:300]
plot(mean1segserver_e2_fn$time[1:300], pdr1seg_e2_fn, type="l", col="blue", main = "Server E2 PDR (fn)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,1.4), xlab = "time(s)")

boxplot(pdr1seg_e2_fn[1:300], main = "Server E2 PDR (fn)", lwd=2, ylab="PDR", ylim = c(0.1,1.3))

######################################################Server S
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
plot(mean1segserver_s_fn$time[1:300], mean1segserver_s_fn$size[1:300], type="l", col="blue", main = "Server S (fn)", lwd=2, xlim = c(0,300), ylab="Throughput (bps)", ylim = c(0,1000000), xlab = "time(s)")
lines(mean1segcar_s_fn$time[1:300], mean1segcar_s_fn$size[1:300], col="red", lwd=2,  ylim = c(0,1000000))
par(new=T)
plot(mean1segdelay_s_fn$time[1:300], mean1segdelay_s_fn$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,4000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server S
pdr1seg_s_fn<-mean1segserver_s_fn$size[1:300]/mean1segcar_s_fn$size[1:300]
plot(mean1segserver_s_fn$time[1:300], pdr1seg_s_fn, type="l", col="blue", main = "Server S PDR (fn)", lwd=2, xlim = c(0,300), ylab="PDR", ylim = c(0,2.5), xlab = "time(s)")

boxplot(pdr1seg_s_fn[1:300], main = "Server S PDR (fn)", lwd=2, ylab="PDR", ylim = c(0.3,1.3))
