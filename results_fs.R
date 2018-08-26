#############################First scenario all RSUs free -  Server E

#Compute Server E received
traceserver_e_fs<-read.table(file = 'result/server_etf_car_fs_tt.txt', sep=' ')
names(traceserver_e_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fs$time <- as.POSIXlt(traceserver_e_fs$time, origin = "1987-10-05 11:00:00")
traceserver_e_fs$size<- traceserver_e_fs$size*8
sum1segserver_e_fs<-aggregate(list(size = traceserver_e_fs$size), list(segundos = cut(traceserver_e_fs$time, "1 sec")), sum)
mean1segserver_e_fs<-append(list(size = sum1segserver_e_fs$size), list(time = as.numeric(sum1segserver_e_fs$segundos)))

# mean1segserver_e_fs$size[1:157]<- mean1segserver_e_fs$size[1:157]/7
# mean1segserver_e_fs$size[158:235]<- mean1segserver_e_fs$size[158:235]/11
# mean1segserver_e_fs$size[236:300]<- mean1segserver_e_fs$size[236:300]/15

mean1segserver_e_fs$size[1:150]<- mean1segserver_e_fs$size[1:150]/7
mean1segserver_e_fs$size[151:225]<- mean1segserver_e_fs$size[151:225]/11
mean1segserver_e_fs$size[226:300]<- mean1segserver_e_fs$size[226:300]/15

pd_e_server<-traceserver_e_fs
pd_e_server$size<-pd_e_server$size/8/1498
sumpd75segserver_e_fs<-aggregate(list(size = pd_e_server$size), list(segundos = cut(pd_e_server$time, "75 sec")), sum)
meanpd75segserver_e_fs<-append(list(size = sumpd75segserver_e_fs$size), list(time = as.numeric(sumpd75segserver_e_fs$segundos)))

#Compute Car sent Server E
tracecar_e_fs<-read.table(file = 'result/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_e_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fs$time <- as.POSIXlt(tracecar_e_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e_fs$size<- tracecar_e_fs$size*8
sum1segcar_e_fs<-aggregate(list(size = tracecar_e_fs$size), list(segundos = cut(tracecar_e_fs$time, "1 sec")), sum)
mean1segcar_e_fs<-append(list(size = sum1segcar_e_fs$size), list(time =  as.numeric(sum1segcar_e_fs$segundos)))

# mean1segcar_e_fs$size[1:157]<- mean1segcar_e_fs$size[1:157]/7
# mean1segcar_e_fs$size[158:235]<- mean1segcar_e_fs$size[158:235]/11
# mean1segcar_e_fs$size[236:300]<- mean1segcar_e_fs$size[236:300]/15

mean1segcar_e_fs$size[1:150]<- mean1segcar_e_fs$size[1:150]/7
mean1segcar_e_fs$size[151:225]<- mean1segcar_e_fs$size[151:225]/11
mean1segcar_e_fs$size[226:300]<- mean1segcar_e_fs$size[226:300]/15

pd_e_car<-tracecar_e_fs
pd_e_car$size<-pd_e_car$size/8/1498
sumpd75segcar_e_fs<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "75 sec")), sum)
meanpd75segcar_e_fs<-append(list(size = sumpd75segcar_e_fs$size), list(time = as.numeric(sumpd75segcar_e_fs$segundos)))

# boxplot(pdr75seg_e_fs[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

#Compute Delay Server E
tracedelay_e_fs<-read.table(file = 'result/delay_e_fs_tt.txt')
names(tracedelay_e_fs)<-c("time", "delay")
tracedelay_e_fs$time <- as.POSIXlt(tracedelay_e_fs$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fs<-aggregate(list(delay = tracedelay_e_fs$delay), list(segundos = cut(tracedelay_e_fs$time, "1 sec")), sum)
mean1segdelay_e_fs<-append(list(size = sum1segdelay_e_fs$delay), list(time = as.numeric(sum1segdelay_e_fs$segundos)))

# mean1segdelay_e_fs$size[1:157]<- mean1segdelay_e_fs$size[1:157]/7
# mean1segdelay_e_fs$size[158:235]<- mean1segdelay_e_fs$size[158:235]/11
# mean1segdelay_e_fs$size[236:300]<- mean1segdelay_e_fs$size[236:300]/15

mean1segdelay_e_fs$size[1:150]<- mean1segdelay_e_fs$size[1:150]/7
mean1segdelay_e_fs$size[151:225]<- mean1segdelay_e_fs$size[151:225]/11
mean1segdelay_e_fs$size[226:300]<- mean1segdelay_e_fs$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_e_fs$time[1:300], mean1segserver_e_fs$size[1:300], type="l", col="blue", main = "Application E (fs)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
lines(mean1segcar_e_fs$time[1:300], mean1segcar_e_fs$size[1:300], col="red", lwd=2, ylim = c(0,700000))
par(new=T)
plot(mean1segdelay_e_fs$time[1:300], mean1segdelay_e_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,10000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E
pdr75seg_e_fs<-meanpd75segserver_e_fs$size/meanpd75segcar_e_fs$size

pdr1seg_e_fs<-mean1segserver_e_fs$size[1:300]/mean1segcar_e_fs$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_e_fs[1:75], ci=0.95)
x<-CI(pdr1seg_e_fs[76:150], ci=0.95)
y<-CI(pdr1seg_e_fs[151:225], ci=0.95)
z<-CI(pdr1seg_e_fs[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_e_fs[1:4], ui=up, li=lo, col="red", main="PDR Application E", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_e_fs[1:4], type = "l", col="red", lwd="2")

#############################First scenario all RSUs free -  Server G

##Compute Server G received
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

pd_g_server<-traceserver_g_fs
pd_g_server$size<-pd_g_server$size/8/1498
sumpd75segserver_g_fs<-aggregate(list(size = pd_g_server$size), list(segundos = cut(pd_g_server$time, "75 sec")), sum)
meanpd75segserver_g_fs<-append(list(size = sumpd75segserver_g_fs$size), list(time = as.numeric(sumpd75segserver_g_fs$segundos)))

#Compute Car sent Server G
tracecar_g_fs<-read.table(file = 'result/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_g_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fs$time <- as.POSIXlt(tracecar_g_fs$time, origin = "1987-10-05 11:00:00")
tracecar_g_fs$size<- tracecar_g_fs$size*8
sum1segcar_g_fs<-aggregate(list(size = tracecar_g_fs$size), list(segundos = cut(tracecar_g_fs$time, "1 sec")), sum)
mean1segcar_g_fs<-append(list(size = sum1segcar_g_fs$size), list(time =  as.numeric(sum1segcar_g_fs$segundos)))

mean1segcar_g_fs$size[1:150]<- mean1segcar_g_fs$size[1:150]/7
mean1segcar_g_fs$size[151:225]<- mean1segcar_g_fs$size[151:225]/11
mean1segcar_g_fs$size[226:300]<- mean1segcar_g_fs$size[226:300]/15

pd_g_car<-tracecar_g_fs
pd_g_car$size<-pd_g_car$size/8/1498
sumpd75segcar_g_fs<-aggregate(list(size = pd_g_car$size), list(segundos = cut(pd_g_car$time, "75 sec")), sum)
meanpd75segcar_g_fs<-append(list(size = sumpd75segcar_g_fs$size), list(time = as.numeric(sumpd75segcar_g_fs$segundos)))

# boxplot(pdr75seg_g_fs[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

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
plot(mean1segserver_g_fs$time[1:300], mean1segserver_g_fs$size[1:300], type="l", col="blue", main = "Application G (fs)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
lines(mean1segcar_g_fs$time[1:300], mean1segcar_g_fs$size[1:300], col="red", lwd=2, ylim = c(0,700000))
par(new=T)
plot(mean1segdelay_g_fs$time[1:300], mean1segdelay_g_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,100000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server G
pdr75seg_g_fs<-meanpd75segserver_g_fs$size/meanpd75segcar_g_fs$size

pdr1seg_g_fs<-mean1segserver_g_fs$size[1:300]/mean1segcar_g_fs$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_g_fs[1:75], ci=0.95)
x<-CI(pdr1seg_g_fs[76:150], ci=0.95)
y<-CI(pdr1seg_g_fs[151:225], ci=0.95)
z<-CI(pdr1seg_g_fs[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_g_fs[1:4], ui=up, li=lo, col="red", main="PDR Application G", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_g_fs[1:4], type = "l", col="red", lwd="2")

###############Server E2

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

pd_e2_server<-traceserver_e2_fs
pd_e2_server$size<-pd_e2_server$size/8/1498
sumpd75segserver_e2_fs<-aggregate(list(size = pd_e2_server$size), list(segundos = cut(pd_e2_server$time, "75 sec")), sum)
meanpd75segserver_e2_fs<-append(list(size = sumpd75segserver_e2_fs$size), list(time = as.numeric(sumpd75segserver_e2_fs$segundos)))

#Compute Car sent Server E2
tracecar_e2_fs<-read.table(file = 'result/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_e2_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fs$time <- as.POSIXlt(tracecar_e2_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fs$size<- tracecar_e2_fs$size*8
sum1segcar_e2_fs<-aggregate(list(size = tracecar_e2_fs$size), list(segundos = cut(tracecar_e2_fs$time, "1 sec")), sum)
mean1segcar_e2_fs<-append(list(size = sum1segcar_e2_fs$size), list(time =  as.numeric(sum1segcar_e2_fs$segundos)))

mean1segcar_e2_fs$size[1:150]<- mean1segcar_e2_fs$size[1:150]/7
mean1segcar_e2_fs$size[151:225]<- mean1segcar_e2_fs$size[151:225]/11
mean1segcar_e2_fs$size[226:300]<- mean1segcar_e2_fs$size[226:300]/15

pd_e2_car<-tracecar_e2_fs
pd_e2_car$size<-pd_e2_car$size/8/1498
sumpd75segcar_e2_fs<-aggregate(list(size = pd_e2_car$size), list(segundos = cut(pd_e2_car$time, "75 sec")), sum)
meanpd75segcar_e2_fs<-append(list(size = sumpd75segcar_e2_fs$size), list(time = as.numeric(sumpd75segcar_e2_fs$segundos)))

# boxplot(pdr75seg_e2_fs[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

#Compute Delay Server G
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
plot(mean1segserver_e2_fs$time[1:300], mean1segserver_e2_fs$size[1:300], type="l", col="blue", main = "Application E2 (fs)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
lines(mean1segcar_e2_fs$time[1:300], mean1segcar_e2_fs$size[1:300], col="red", lwd=2, ylim = c(0,700000))
par(new=T)
plot(mean1segdelay_e2_fs$time[1:300], mean1segdelay_e2_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,10000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E2
pdr75seg_e2_fs<-meanpd75segserver_e2_fs$size/meanpd75segcar_e2_fs$size

pdr1seg_e2_fs<-mean1segserver_e2_fs$size[1:300]/mean1segcar_e2_fs$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_e2_fs[1:75], ci=0.95)
x<-CI(pdr1seg_e2_fs[76:150], ci=0.95)
y<-CI(pdr1seg_e2_fs[151:225], ci=0.95)
z<-CI(pdr1seg_e2_fs[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_e2_fs[1:4], ui=up, li=lo, col="red", main="PDR Application E2", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_e2_fs[1:4], type = "l", col="red", lwd="2")

######################################################Server S
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

pd_s_server<-traceserver_s_fs
pd_s_server$size<-pd_s_server$size/8/1498
sumpd75segserver_s_fs<-aggregate(list(size = pd_s_server$size), list(segundos = cut(pd_s_server$time, "75 sec")), sum)
meanpd75segserver_s_fs<-append(list(size = sumpd75segserver_s_fs$size), list(time = as.numeric(sumpd75segserver_s_fs$segundos)))

#Compute Car sent Server S
tracecar_s_fs<-read.table(file = 'result/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_s_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fs$time <- as.POSIXlt(tracecar_s_fs$time, origin = "1987-10-05 11:00:00")
tracecar_s_fs$size<- tracecar_s_fs$size*8
sum1segcar_s_fs<-aggregate(list(size = tracecar_s_fs$size), list(segundos = cut(tracecar_s_fs$time, "1 sec")), sum)
mean1segcar_s_fs<-append(list(size = sum1segcar_s_fs$size), list(time =  as.numeric(sum1segcar_s_fs$segundos)))

mean1segcar_s_fs$size[1:150]<- mean1segcar_s_fs$size[1:150]/7
mean1segcar_s_fs$size[151:225]<- mean1segcar_s_fs$size[151:225]/11
mean1segcar_s_fs$size[226:300]<- mean1segcar_s_fs$size[226:300]/15

pd_s_car<-tracecar_s_fs
pd_s_car$size<-pd_s_car$size/8/1498
sumpd75segcar_s_fs<-aggregate(list(size = pd_s_car$size), list(segundos = cut(pd_s_car$time, "75 sec")), sum)
meanpd75segcar_s_fs<-append(list(size = sumpd75segcar_s_fs$size), list(time = as.numeric(sumpd75segcar_s_fs$segundos)))

# boxplot(pdr75seg_s_fs[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

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
plot(mean1segserver_s_fs$time[1:300], mean1segserver_s_fs$size[1:300], type="l", col="blue", main = "Application S (fs)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)")
lines(mean1segcar_s_fs$time[1:300], mean1segcar_s_fs$size[1:300], col="red", lwd=2, ylim = c(0,900000))
par(new=T)
plot(mean1segdelay_s_fs$time[1:300], mean1segdelay_s_fs$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,4000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server S
pdr75seg_s_fs<-meanpd75segserver_s_fs$size/meanpd75segcar_s_fs$size

pdr1seg_s_fs<-mean1segserver_s_fs$size[1:300]/mean1segcar_s_fs$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_s_fs[1:75], ci=0.95)
x<-CI(pdr1seg_s_fs[76:150], ci=0.95)
y<-CI(pdr1seg_s_fs[151:225], ci=0.95)
z<-CI(pdr1seg_s_fs[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_s_fs[1:4], ui=up, li=lo, col="red", main="PDR Application S", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_s_fs[1:4], type = "l", col="red", lwd="2")
