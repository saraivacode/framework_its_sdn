#############################First scenario all RSUs free -  Server E

#Compute Server E received
traceserver_e_fq<-read.table(file = 'result/server_etf_car_fq_tt.txt', sep=' ')
names(traceserver_e_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fq$time <- as.POSIXlt(traceserver_e_fq$time, origin = "1987-10-05 11:00:00")
traceserver_e_fq$size<- traceserver_e_fq$size*8
sum1segserver_e_fq<-aggregate(list(size = traceserver_e_fq$size), list(segundos = cut(traceserver_e_fq$time, "1 sec")), sum)
mean1segserver_e_fq<-append(list(size = sum1segserver_e_fq$size), list(time = as.numeric(sum1segserver_e_fq$segundos)))

# mean1segserver_e_fq$size[1:157]<- mean1segserver_e_fq$size[1:157]/7
# mean1segserver_e_fq$size[158:235]<- mean1segserver_e_fq$size[158:235]/11
# mean1segserver_e_fq$size[236:300]<- mean1segserver_e_fq$size[236:300]/15

mean1segserver_e_fq$size[1:150]<- mean1segserver_e_fq$size[1:150]/7
mean1segserver_e_fq$size[151:225]<- mean1segserver_e_fq$size[151:225]/11
mean1segserver_e_fq$size[226:300]<- mean1segserver_e_fq$size[226:300]/15

pd_e_server<-traceserver_e_fq
pd_e_server$size<-pd_e_server$size/8/1498
sumpd75segserver_e_fq<-aggregate(list(size = pd_e_server$size), list(segundos = cut(pd_e_server$time, "75 sec")), sum)
meanpd75segserver_e_fq<-append(list(size = sumpd75segserver_e_fq$size), list(time = as.numeric(sumpd75segserver_e_fq$segundos)))

#Compute Car sent Server E
tracecar_e_fq<-read.table(file = 'result/cartf_fq_5003_tt.txt', sep=' ')
names(tracecar_e_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fq$time <- as.POSIXlt(tracecar_e_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e_fq$size<- tracecar_e_fq$size*8

sum1segcar_e_fq<-aggregate(list(size = tracecar_e_fq$size), list(segundos = cut(tracecar_e_fq$time, "1 sec")), sum)
mean1segcar_e_fq<-append(list(size = sum1segcar_e_fq$size), list(time =  as.numeric(sum1segcar_e_fq$segundos)))

# mean1segcar_e_fq$size[1:157]<- mean1segcar_e_fq$size[1:157]/7
# mean1segcar_e_fq$size[158:235]<- mean1segcar_e_fq$size[158:235]/11
# mean1segcar_e_fq$size[236:300]<- mean1segcar_e_fq$size[236:300]/15

mean1segcar_e_fq$size[1:150]<- mean1segcar_e_fq$size[1:150]/7
mean1segcar_e_fq$size[151:225]<- mean1segcar_e_fq$size[151:225]/11
mean1segcar_e_fq$size[226:300]<- mean1segcar_e_fq$size[226:300]/15

pd_e_car<-tracecar_e_fq
pd_e_car$size<-pd_e_car$size/8/1498
sumpd75segcar_e_fq<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "75 sec")), sum)
meanpd75segcar_e_fq<-append(list(size = sumpd75segcar_e_fq$size), list(time = as.numeric(sumpd75segcar_e_fq$segundos)))

# boxplot(pdr75seg_e_fq[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

#Compute Delay Server E
tracedelay_e_fq<-read.table(file = 'result/delay_e_fq_tt.txt')
names(tracedelay_e_fq)<-c("time", "delay")
tracedelay_e_fq$time <- as.POSIXlt(tracedelay_e_fq$time, origin = "1987-10-05 11:00:00")
sum1segdelay_e_fq<-aggregate(list(delay = tracedelay_e_fq$delay), list(segundos = cut(tracedelay_e_fq$time, "1 sec")), sum)
mean1segdelay_e_fq<-append(list(size = sum1segdelay_e_fq$delay), list(time = as.numeric(sum1segdelay_e_fq$segundos)))

# mean1segdelay_e_fq$size[1:157]<- mean1segdelay_e_fq$size[1:157]/7
# mean1segdelay_e_fq$size[158:235]<- mean1segdelay_e_fq$size[158:235]/11
# mean1segdelay_e_fq$size[236:300]<- mean1segdelay_e_fq$size[236:300]/15

mean1segdelay_e_fq$size[1:150]<- mean1segdelay_e_fq$size[1:150]/7
mean1segdelay_e_fq$size[151:225]<- mean1segdelay_e_fq$size[151:225]/11
mean1segdelay_e_fq$size[226:300]<- mean1segdelay_e_fq$size[226:300]/15

#Plot
par(mar = c(5,5,2,5))
plot(mean1segserver_e_fq$time[1:300], mean1segserver_e_fq$size[1:300], type="l", col="blue", main = "Application E (fq)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
lines(mean1segcar_e_fq$time[1:300], mean1segcar_e_fq$size[1:300], col="red", lwd=2, ylim = c(0,700000))
par(new=T)
plot(mean1segdelay_e_fq$time[1:300], mean1segdelay_e_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,10000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E
pdr75seg_e_fq<-meanpd75segserver_e_fq$size/meanpd75segcar_e_fq$size

pdr1seg_e_fq<-mean1segserver_e_fq$size[1:300]/mean1segcar_e_fq$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_e_fq[1:75], ci=0.95)
x<-CI(pdr1seg_e_fq[76:150], ci=0.95)
y<-CI(pdr1seg_e_fq[151:225], ci=0.95)
z<-CI(pdr1seg_e_fq[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_e_fq[1:4], ui=up, li=lo, col="red", main="PDR Application E", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_e_fq[1:4], type = "l", col="red", lwd="2")

#############################First scenario all RSUs free -  Server G

##Compute Server G received
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

pd_g_server<-traceserver_g_fq
pd_g_server$size<-pd_g_server$size/8/1498
sumpd75segserver_g_fq<-aggregate(list(size = pd_g_server$size), list(segundos = cut(pd_g_server$time, "75 sec")), sum)
meanpd75segserver_g_fq<-append(list(size = sumpd75segserver_g_fq$size), list(time = as.numeric(sumpd75segserver_g_fq$segundos)))

#Compute Car sent Server G
tracecar_g_fq<-read.table(file = 'result/cartf_fq_5003_tt.txt', sep=' ')
names(tracecar_g_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fq$time <- as.POSIXlt(tracecar_g_fq$time, origin = "1987-10-05 11:00:00")
tracecar_g_fq$size<- tracecar_g_fq$size*8
sum1segcar_g_fq<-aggregate(list(size = tracecar_g_fq$size), list(segundos = cut(tracecar_g_fq$time, "1 sec")), sum)
mean1segcar_g_fq<-append(list(size = sum1segcar_g_fq$size), list(time =  as.numeric(sum1segcar_g_fq$segundos)))

mean1segcar_g_fq$size[1:150]<- mean1segcar_g_fq$size[1:150]/7
mean1segcar_g_fq$size[151:225]<- mean1segcar_g_fq$size[151:225]/11
mean1segcar_g_fq$size[226:300]<- mean1segcar_g_fq$size[226:300]/15

pd_g_car<-tracecar_g_fq
pd_g_car$size<-pd_g_car$size/8/1498
sumpd75segcar_g_fq<-aggregate(list(size = pd_g_car$size), list(segundos = cut(pd_g_car$time, "75 sec")), sum)
meanpd75segcar_g_fq<-append(list(size = sumpd75segcar_g_fq$size), list(time = as.numeric(sumpd75segcar_g_fq$segundos)))

# boxplot(pdr75seg_g_fq[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

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
plot(mean1segserver_g_fq$time[1:300], mean1segserver_g_fq$size[1:300], type="l", col="blue", main = "Application G (fq)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
lines(mean1segcar_g_fq$time[1:300], mean1segcar_g_fq$size[1:300], col="red", lwd=2, ylim = c(0,700000))
par(new=T)
plot(mean1segdelay_g_fq$time[1:300], mean1segdelay_g_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,100000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server G
pdr75seg_g_fq<-meanpd75segserver_g_fq$size/meanpd75segcar_g_fq$size

pdr1seg_g_fq<-mean1segserver_g_fq$size[1:300]/mean1segcar_g_fq$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_g_fq[1:75], ci=0.95)
x<-CI(pdr1seg_g_fq[76:150], ci=0.95)
y<-CI(pdr1seg_g_fq[151:225], ci=0.95)
z<-CI(pdr1seg_g_fq[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_g_fq[1:4], ui=up, li=lo, col="red", main="PDR Application G", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_g_fq[1:4], type = "l", col="red", lwd="2")

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

pd_e2_server<-traceserver_e2_fq
pd_e2_server$size<-pd_e2_server$size/8/1498
sumpd75segserver_e2_fq<-aggregate(list(size = pd_e2_server$size), list(segundos = cut(pd_e2_server$time, "75 sec")), sum)
meanpd75segserver_e2_fq<-append(list(size = sumpd75segserver_e2_fq$size), list(time = as.numeric(sumpd75segserver_e2_fq$segundos)))

#Compute Car sent Server E2
tracecar_e2_fq<-read.table(file = 'result/cartf_fq_5003_tt.txt', sep=' ')
names(tracecar_e2_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fq$time <- as.POSIXlt(tracecar_e2_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fq$size<- tracecar_e2_fq$size*8
sum1segcar_e2_fq<-aggregate(list(size = tracecar_e2_fq$size), list(segundos = cut(tracecar_e2_fq$time, "1 sec")), sum)
mean1segcar_e2_fq<-append(list(size = sum1segcar_e2_fq$size), list(time =  as.numeric(sum1segcar_e2_fq$segundos)))

mean1segcar_e2_fq$size[1:150]<- mean1segcar_e2_fq$size[1:150]/7
mean1segcar_e2_fq$size[151:225]<- mean1segcar_e2_fq$size[151:225]/11
mean1segcar_e2_fq$size[226:300]<- mean1segcar_e2_fq$size[226:300]/15

pd_e2_car<-tracecar_e2_fq
pd_e2_car$size<-pd_e2_car$size/8/1498
sumpd75segcar_e2_fq<-aggregate(list(size = pd_e2_car$size), list(segundos = cut(pd_e2_car$time, "75 sec")), sum)
meanpd75segcar_e2_fq<-append(list(size = sumpd75segcar_e2_fq$size), list(time = as.numeric(sumpd75segcar_e2_fq$segundos)))

# boxplot(pdr75seg_e2_fq[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

#Compute Delay Server G
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
plot(mean1segserver_e2_fq$time[1:300], mean1segserver_e2_fq$size[1:300], type="l", col="blue", main = "Application E2 (fq)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,700000), xlab = "time(s)")
lines(mean1segcar_e2_fq$time[1:300], mean1segcar_e2_fq$size[1:300], col="red", lwd=2, ylim = c(0,700000))
par(new=T)
plot(mean1segdelay_e2_fq$time[1:300], mean1segdelay_e2_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,10000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server E2
pdr75seg_e2_fq<-meanpd75segserver_e2_fq$size/meanpd75segcar_e2_fq$size

pdr1seg_e2_fq<-mean1segserver_e2_fq$size[1:300]/mean1segcar_e2_fq$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_e2_fq[1:75], ci=0.95)
x<-CI(pdr1seg_e2_fq[76:150], ci=0.95)
y<-CI(pdr1seg_e2_fq[151:225], ci=0.95)
z<-CI(pdr1seg_e2_fq[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_e2_fq[1:4], ui=up, li=lo, col="red", main="PDR Application E2", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_e2_fq[1:4], type = "l", col="red", lwd="2")

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

pd_s_server<-traceserver_s_fq
pd_s_server$size<-pd_s_server$size/8/1498
sumpd75segserver_s_fq<-aggregate(list(size = pd_s_server$size), list(segundos = cut(pd_s_server$time, "75 sec")), sum)
meanpd75segserver_s_fq<-append(list(size = sumpd75segserver_s_fq$size), list(time = as.numeric(sumpd75segserver_s_fq$segundos)))

#Compute Car sent Server S
tracecar_s_fq<-read.table(file = 'result/cartf_fq_5003_tt.txt', sep=' ')
names(tracecar_s_fq)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fq$time <- as.POSIXlt(tracecar_s_fq$time, origin = "1987-10-05 11:00:00")
tracecar_s_fq$size<- tracecar_s_fq$size*8
sum1segcar_s_fq<-aggregate(list(size = tracecar_s_fq$size), list(segundos = cut(tracecar_s_fq$time, "1 sec")), sum)
mean1segcar_s_fq<-append(list(size = sum1segcar_s_fq$size), list(time =  as.numeric(sum1segcar_s_fq$segundos)))

mean1segcar_s_fq$size[1:150]<- mean1segcar_s_fq$size[1:150]/7
mean1segcar_s_fq$size[151:225]<- mean1segcar_s_fq$size[151:225]/11
mean1segcar_s_fq$size[226:300]<- mean1segcar_s_fq$size[226:300]/15

pd_s_car<-tracecar_s_fq
pd_s_car$size<-pd_s_car$size/8/1498
sumpd75segcar_s_fq<-aggregate(list(size = pd_s_car$size), list(segundos = cut(pd_s_car$time, "75 sec")), sum)
meanpd75segcar_s_fq<-append(list(size = sumpd75segcar_s_fq$size), list(time = as.numeric(sumpd75segcar_s_fq$segundos)))

# boxplot(pdr75seg_s_fq[1:4], yaxt="n")
# axis(2, xaxp=c(0.5, 1.3, 10))

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
plot(mean1segserver_s_fq$time[1:300], mean1segserver_s_fq$size[1:300], type="l", col="blue", main = "Application S (fq)", lwd=2, xlim = c(1,300), ylab="Throughput (bps)", ylim = c(0,900000), xlab = "time(s)")
lines(mean1segcar_s_fq$time[1:300], mean1segcar_s_fq$size[1:300], col="red", lwd=2, ylim = c(0,900000))
par(new=T)
plot(mean1segdelay_s_fq$time[1:300], mean1segdelay_s_fq$size[1:300], type="l", col="orange", lwd=2, xlim = c(0,300), axes=F, xlab=NA, ylab=NA, ylim = c(0,4000))
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft", legend=c("Server received", "Car Sent", "Delay"), lty=c(1,1,1), col=c("blue", "red", "orange"))

#Compute PDR Server S
pdr75seg_s_fq<-meanpd75segserver_s_fq$size/meanpd75segcar_s_fq$size

pdr1seg_s_fq<-mean1segserver_s_fq$size[1:300]/mean1segcar_s_fq$size[1:300]

require(Rmisc)
w<-CI(pdr1seg_s_fq[1:75], ci=0.95)
x<-CI(pdr1seg_s_fq[76:150], ci=0.95)
y<-CI(pdr1seg_s_fq[151:225], ci=0.95)
z<-CI(pdr1seg_s_fq[225:300], ci=0.95)

up<-c(w[1], x[1], y[1], z[1])
lo<-c(w[3], x[3], y[3], z[3])

require(plotrix)

plotCI(c(1:4), pdr75seg_s_fq[1:4], ui=up, li=lo, col="red", main="PDR Application S", ylab = "PDR", xlab = "time(s)", lwd="2" )
lines(c(1:4),pdr75seg_s_fq[1:4], type = "l", col="red", lwd="2")

