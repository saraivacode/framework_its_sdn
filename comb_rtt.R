#Delay cdf

###AppE
#FS
#Compute Delay Server E
tracedelay_e_fs<-read.table(file = 'result/delay_e_fs_tt.txt')
names(tracedelay_e_fs)<-c("time", "delay")
tracedelay_e_fs$time <- as.POSIXlt(tracedelay_e_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fs<-aggregate(list(delay = tracedelay_e_fs$delay), list(segundos = cut(tracedelay_e_fs$time, "1 sec")), sum)
mean1segdelay_e_fs<-append(list(size = sum1segdelay_e_fs$delay), list(time = as.numeric(sum1segdelay_e_fs$segundos)))

mean1segdelay_e_fs$size[1:150]<- mean1segdelay_e_fs$size[1:150]/7
mean1segdelay_e_fs$size[151:225]<- mean1segdelay_e_fs$size[151:225]/11
mean1segdelay_e_fs$size[226:300]<- mean1segdelay_e_fs$size[226:300]/15

#FQ
#Compute Delay Server E
tracedelay_e_fq<-read.table(file = 'result/delay_e_fq_tt.txt')
names(tracedelay_e_fq)<-c("time", "delay")
tracedelay_e_fq$time <- as.POSIXlt(tracedelay_e_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fq<-aggregate(list(delay = tracedelay_e_fq$delay), list(segundos = cut(tracedelay_e_fq$time, "1 sec")), sum)
mean1segdelay_e_fq<-append(list(size = sum1segdelay_e_fq$delay), list(time = as.numeric(sum1segdelay_e_fq$segundos)))

mean1segdelay_e_fq$size[1:150]<- mean1segdelay_e_fq$size[1:150]/7
mean1segdelay_e_fq$size[151:225]<- mean1segdelay_e_fq$size[151:225]/11
mean1segdelay_e_fq$size[226:300]<- mean1segdelay_e_fq$size[226:300]/15

#FN
#Compute Delay Server E
tracedelay_e_fn<-read.table(file = 'result/delay_e_fn_tt.txt')
names(tracedelay_e_fn)<-c("time", "delay")
tracedelay_e_fn$time <- as.POSIXlt(tracedelay_e_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fn<-aggregate(list(delay = tracedelay_e_fn$delay), list(segundos = cut(tracedelay_e_fn$time, "1 sec")), sum)
mean1segdelay_e_fn<-append(list(size = sum1segdelay_e_fn$delay), list(time = as.numeric(sum1segdelay_e_fn$segundos)))

mean1segdelay_e_fn$size[1:150]<- mean1segdelay_e_fn$size[1:150]/7
mean1segdelay_e_fn$size[151:225]<- mean1segdelay_e_fn$size[151:225]/11
mean1segdelay_e_fn$size[226:300]<- mean1segdelay_e_fn$size[226:300]/15

plot(ecdf(mean1segdelay_e_fs$size), col.01line = "gray70", pch = 19, col="red", xlim = c(0,6000), ylim = c(0,1), main="RTT Application E", ylab = "CDF", xlab = "RTT (ms)")
# abline( h= 0.8, lty =3, col = "gray60")
# abline( v= 650, lty =3, col = "gray60")
par(new=T)
plot(ecdf(mean1segdelay_e_fq$size), col.01line = "gray70", pch = 19, col="blue", xlim = c(0,6000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA, main ="")
par(new=T)
plot(ecdf(mean1segdelay_e_fn$size), col.01line = "gray70", pch = 19, col="orange", xlim = c(0,6000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA,  main ="")
legend("right", legend=c("Framework", "QoS", "Best effort"), lty=c(1,1,1), col=c("red", "blue", "orange"))

#############################################
###################################################################################################AppE2

#FS
#Compute Delay Server E2
tracedelay_e2_fs<-read.table(file = 'result/delay_e2_fs_tt.txt')
names(tracedelay_e2_fs)<-c("time", "delay")
tracedelay_e2_fs$time <- as.POSIXlt(tracedelay_e2_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e2_fs<-aggregate(list(delay = tracedelay_e2_fs$delay), list(segundos = cut(tracedelay_e2_fs$time, "1 sec")), sum)
mean1segdelay_e2_fs<-append(list(size = sum1segdelay_e2_fs$delay), list(time = as.numeric(sum1segdelay_e2_fs$segundos)))

mean1segdelay_e2_fs$size[1:150]<- mean1segdelay_e2_fs$size[1:150]/7
mean1segdelay_e2_fs$size[151:225]<- mean1segdelay_e2_fs$size[151:225]/11
mean1segdelay_e2_fs$size[226:300]<- mean1segdelay_e2_fs$size[226:300]/15

#FQ
#Compute Delay Server E2
tracedelay_e2_fq<-read.table(file = 'result/delay_e2_fq_tt.txt')
names(tracedelay_e2_fq)<-c("time", "delay")
tracedelay_e2_fq$time <- as.POSIXlt(tracedelay_e2_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e2_fq<-aggregate(list(delay = tracedelay_e2_fq$delay), list(segundos = cut(tracedelay_e2_fq$time, "1 sec")), sum)
mean1segdelay_e2_fq<-append(list(size = sum1segdelay_e2_fq$delay), list(time = as.numeric(sum1segdelay_e2_fq$segundos)))

mean1segdelay_e2_fq$size[1:150]<- mean1segdelay_e2_fq$size[1:150]/7
mean1segdelay_e2_fq$size[151:225]<- mean1segdelay_e2_fq$size[151:225]/11
mean1segdelay_e2_fq$size[226:300]<- mean1segdelay_e2_fq$size[226:300]/15

#FN
#Compute Delay Server E2
tracedelay_e2_fn<-read.table(file = 'result/delay_e2_fn_tt.txt')
names(tracedelay_e2_fn)<-c("time", "delay")
tracedelay_e2_fn$time <- as.POSIXlt(tracedelay_e2_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e2_fn<-aggregate(list(delay = tracedelay_e2_fn$delay), list(segundos = cut(tracedelay_e2_fn$time, "1 sec")), sum)
mean1segdelay_e2_fn<-append(list(size = sum1segdelay_e2_fn$delay), list(time = as.numeric(sum1segdelay_e2_fn$segundos)))

mean1segdelay_e2_fn$size[1:150]<- mean1segdelay_e2_fn$size[1:150]/7
mean1segdelay_e2_fn$size[151:225]<- mean1segdelay_e2_fn$size[151:225]/11
mean1segdelay_e2_fn$size[226:300]<- mean1segdelay_e2_fn$size[226:300]/15

plot(ecdf(mean1segdelay_e2_fs$size), col.01line = "gray70", pch = 19, col="red", xlim = c(0,6000), ylim = c(0,1), main="RTT Application E2", ylab = "CDF", xlab = "RTT (ms)")
# abline( h= 0.8, lty =3, col = "gray60")
# abline( v= 650, lty =3, col = "gray60")
par(new=T)
plot(ecdf(mean1segdelay_e2_fq$size), col.01line = "gray70", pch = 19, col="blue", xlim = c(0,6000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA, main ="")
par(new=T)
plot(ecdf(mean1segdelay_e2_fn$size), col.01line = "gray70", pch = 19, col="orange", xlim = c(0,6000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA,  main ="")
legend("right", legend=c("Framework", "QoS", "Best effort"), lty=c(1,1,1), col=c("red", "blue", "orange"))

##############################################################################3#App G

#FS
#Compute Delay Server G
tracedelay_g_fs<-read.table(file = 'result/delay_g_fs_tt.txt')
names(tracedelay_g_fs)<-c("time", "delay")
tracedelay_g_fs$time <- as.POSIXlt(tracedelay_g_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_g_fs<-aggregate(list(delay = tracedelay_g_fs$delay), list(segundos = cut(tracedelay_g_fs$time, "1 sec")), sum)
mean1segdelay_g_fs<-append(list(size = sum1segdelay_g_fs$delay), list(time = as.numeric(sum1segdelay_g_fs$segundos)))

mean1segdelay_g_fs$size[1:150]<- mean1segdelay_g_fs$size[1:150]/7
mean1segdelay_g_fs$size[151:225]<- mean1segdelay_g_fs$size[151:225]/11
mean1segdelay_g_fs$size[226:300]<- mean1segdelay_g_fs$size[226:300]/15

#FQ
#Compute Delay Server G
tracedelay_g_fq<-read.table(file = 'result/delay_g_fq_tt.txt')
names(tracedelay_g_fq)<-c("time", "delay")
tracedelay_g_fq$time <- as.POSIXlt(tracedelay_g_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_g_fq<-aggregate(list(delay = tracedelay_g_fq$delay), list(segundos = cut(tracedelay_g_fq$time, "1 sec")), sum)
mean1segdelay_g_fq<-append(list(size = sum1segdelay_g_fq$delay), list(time = as.numeric(sum1segdelay_g_fq$segundos)))

mean1segdelay_g_fq$size[1:150]<- mean1segdelay_g_fq$size[1:150]/7
mean1segdelay_g_fq$size[151:225]<- mean1segdelay_g_fq$size[151:225]/11
mean1segdelay_g_fq$size[226:300]<- mean1segdelay_g_fq$size[226:300]/15

#FN
#Compute Delay Server G
tracedelay_g_fn<-read.table(file = 'result/delay_g_fn_tt.txt')
names(tracedelay_g_fn)<-c("time", "delay")
tracedelay_g_fn$time <- as.POSIXlt(tracedelay_g_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_g_fn<-aggregate(list(delay = tracedelay_g_fn$delay), list(segundos = cut(tracedelay_g_fn$time, "1 sec")), sum)
mean1segdelay_g_fn<-append(list(size = sum1segdelay_g_fn$delay), list(time = as.numeric(sum1segdelay_g_fn$segundos)))

mean1segdelay_g_fn$size[1:150]<- mean1segdelay_g_fn$size[1:150]/7
mean1segdelay_g_fn$size[151:225]<- mean1segdelay_g_fn$size[151:225]/11
mean1segdelay_g_fn$size[226:300]<- mean1segdelay_g_fn$size[226:300]/15

plot(ecdf(mean1segdelay_g_fs$size), col.01line = "gray70", pch = 19, col="red", ylim = c(0,1), xlim = c(0,15000), main="RTT Application G", ylab = "CDF", xlab = "delay")
abline( h= 0.8, lty =3, col = "gray60")
par(new=T)
plot(ecdf(mean1segdelay_g_fq$size), col.01line = "gray70", pch = 19, col="blue", ylim = c(0,1), xlim = c(0,15000), axes=F, xlab=NA, ylab=NA, main ="")
par(new=T)
plot(ecdf(mean1segdelay_g_fn$size), col.01line = "gray70", pch = 19, col="orange", ylim = c(0,1), xlim = c(0,15000), axes=F, xlab=NA, ylab=NA,  main ="")
legend("right", legend=c("FS", "FQ", "FN"), lty=c(1,1,1), col=c("red", "blue", "orange"))

####################################################App S

#FS
#Compute Delay Server S
tracedelay_s_fs<-read.table(file = 'result/delay_s_fs_tt.txt')
names(tracedelay_s_fs)<-c("time", "delay")
tracedelay_s_fs$time <- as.POSIXlt(tracedelay_s_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_s_fs<-aggregate(list(delay = tracedelay_s_fs$delay), list(segundos = cut(tracedelay_s_fs$time, "1 sec")), sum)
mean1segdelay_s_fs<-append(list(size = sum1segdelay_s_fs$delay), list(time = as.numeric(sum1segdelay_s_fs$segundos)))

mean1segdelay_s_fs$size[1:150]<- mean1segdelay_s_fs$size[1:150]/7
mean1segdelay_s_fs$size[151:225]<- mean1segdelay_s_fs$size[151:225]/11
mean1segdelay_s_fs$size[226:300]<- mean1segdelay_s_fs$size[226:300]/15

#FQ
#Compute Delay Server S
tracedelay_s_fq<-read.table(file = 'result/delay_s_fq_tt.txt')
names(tracedelay_s_fq)<-c("time", "delay")
tracedelay_s_fq$time <- as.POSIXlt(tracedelay_s_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_s_fq<-aggregate(list(delay = tracedelay_s_fq$delay), list(segundos = cut(tracedelay_s_fq$time, "1 sec")), sum)
mean1segdelay_s_fq<-append(list(size = sum1segdelay_s_fq$delay), list(time = as.numeric(sum1segdelay_s_fq$segundos)))

mean1segdelay_s_fq$size[1:150]<- mean1segdelay_s_fq$size[1:150]/7
mean1segdelay_s_fq$size[151:225]<- mean1segdelay_s_fq$size[151:225]/11
mean1segdelay_s_fq$size[226:300]<- mean1segdelay_s_fq$size[226:300]/15

#FN
#Compute Delay Server S
tracedelay_s_fn<-read.table(file = 'result/delay_s_fn_tt.txt')
names(tracedelay_s_fn)<-c("time", "delay")
tracedelay_s_fn$time <- as.POSIXlt(tracedelay_s_fn$time, origin = "1987-10-05 11:00:00")
sum1segdelay_s_fn<-aggregate(list(delay = tracedelay_s_fn$delay), list(segundos = cut(tracedelay_s_fn$time, "1 sec")), sum)
mean1segdelay_s_fn<-append(list(size = sum1segdelay_s_fn$delay), list(time = as.numeric(sum1segdelay_s_fn$segundos)))

mean1segdelay_s_fn$size[1:150]<- mean1segdelay_s_fn$size[1:150]/7
mean1segdelay_s_fn$size[151:225]<- mean1segdelay_s_fn$size[151:225]/11
mean1segdelay_s_fn$size[226:300]<- mean1segdelay_s_fn$size[226:300]/15

plot(ecdf(mean1segdelay_s_fs$size), col.01line = "gray70", pch = 19, col="red", xlim = c(0,300), ylim = c(0,1), main="RTT Application S", ylab = "CDF", xlab = "RTT (ms)")
# abline( h= 0.8, lty =3, col = "gray60")
# abline( v= 10, lty =3, col = "gray60")
par(new=T)
plot(ecdf(mean1segdelay_s_fq$size), pch = 19, col="blue", xlim = c(0,300), ylim = c(0,1), axes=F, xlab=NA, ylab=NA, main ="")
par(new=T)
plot(ecdf(mean1segdelay_s_fn$size), pch = 19, col="orange", xlim = c(0,300), ylim = c(0,1), axes=F, xlab=NA, ylab=NA,  main ="")
legend("right", legend=c("Framework", "QoS", "Best effort"), lty=c(1,1,1), col=c("red", "blue", "orange"))
