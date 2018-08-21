traceserver_s3_car0<-read.table(file = 'server_s3tf_car0.txt', sep=' ')
names(traceserver_s3_car0)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s3_car0$time <- as.POSIXlt(traceserver_s3_car0$time, origin = "1987-10-05 11:00:00")
traceserver_s3_car0$size<- traceserver_s3_car0$size*8
taxabps1segserver_s3_car0<-aggregate(list(size = traceserver_s3_car0$size), list(segundos = cut(traceserver_s3_car0$time, "1 sec")), sum)
taxabps1segserverts_s3_car0<-ts(traceserver_s3_car0$size, frequency = 1)

taxabps1segserver_s_car0 <-taxabps1segserver_s3_car0

traceserver_s3_car1<-read.table(file = 'server_s3tf_car1.txt', sep=' ')
names(traceserver_s3_car1)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s3_car1$time <- as.POSIXlt(traceserver_s3_car1$time, origin = "1987-10-05 11:00:00")
traceserver_s3_car1$size<- traceserver_s3_car1$size*8
taxabps1segserver_s3_car1<-aggregate(list(size = traceserver_s3_car1$size), list(segundos = cut(traceserver_s3_car1$time, "1 sec")), sum)
taxabps1segserverts_s3_car1<-ts(traceserver_s3_car1$size, frequency = 1)

taxabps1segserver_s_car1 <-taxabps1segserver_s3_car1

traceserver_s3_car2<-read.table(file = 'server_s3tf_car2.txt', sep=' ')
names(traceserver_s3_car2)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s3_car2$time <- as.POSIXlt(traceserver_s3_car2$time, origin = "1987-10-05 11:00:00")
traceserver_s3_car2$size<- traceserver_s3_car2$size*8
taxabps1segserver_s3_car2<-aggregate(list(size = traceserver_s3_car2$size), list(segundos = cut(traceserver_s3_car2$time, "1 sec")), sum)
taxabps1segserverts_s3_car2<-ts(traceserver_s3_car2$size, frequency = 1)

taxabps1segserver_s_car2 <-taxabps1segserver_s3_car2

traceserver_s2_car3<-read.table(file = 'server_s2tf_car3.txt', sep=' ')
names(traceserver_s2_car3)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s2_car3$time <- as.POSIXlt(traceserver_s2_car3$time, origin = "1987-10-05 11:00:00")
traceserver_s2_car3$size<- traceserver_s2_car3$size*8
taxabps1segserver_s2_car3<-aggregate(list(size = traceserver_s2_car3$size), list(segundos = cut(traceserver_s2_car3$time, "1 sec")), sum)
taxabps1segserverts_s2_car3<-ts(traceserver_s2_car3$size, frequency = 1)

taxabps1segserver_s_car3 <-taxabps1segserver_s2_car3

traceserver_s2_car4<-read.table(file = 'server_s2tf_car4.txt', sep=' ')
names(traceserver_s2_car4)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s2_car4$time <- as.POSIXlt(traceserver_s2_car4$time, origin = "1987-10-05 11:00:00")
traceserver_s2_car4$size<- traceserver_s2_car4$size*8
taxabps1segserver_s2_car4<-aggregate(list(size = traceserver_s2_car4$size), list(segundos = cut(traceserver_s2_car4$time, "1 sec")), sum)
taxabps1segserverts_s2_car4<-ts(traceserver_s2_car4$size, frequency = 1)

taxabps1segserver_s_car4 <-taxabps1segserver_s2_car4

traceserver_s1_car5<-read.table(file = 'server_s1tf_car5.txt', sep=' ')
names(traceserver_s1_car5)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s1_car5$time <- as.POSIXlt(traceserver_s1_car5$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car5$size<- traceserver_s1_car5$size*8
taxabps1segserver_s1_car5<-aggregate(list(size = traceserver_s1_car5$size), list(segundos = cut(traceserver_s1_car5$time, "1 sec")), sum)
taxabps1segserverts_s1_car5<-ts(traceserver_s1_car5$size, frequency = 1)

taxabps1segserver_s_car5 <-taxabps1segserver_s1_car5

traceserver_s1_car6<-read.table(file = 'server_s1tf_car6.txt', sep=' ')
names(traceserver_s1_car6)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s1_car6$time <- as.POSIXlt(traceserver_s1_car6$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car6$size<- traceserver_s1_car6$size*8
taxabps1segserver_s1_car6<-aggregate(list(size = traceserver_s1_car6$size), list(segundos = cut(traceserver_s1_car6$time, "1 sec")), sum)
taxabps1segserverts_s1_car6<-ts(traceserver_s1_car6$size, frequency = 1)

taxabps1segserver_s_car6 <-taxabps1segserver_s1_car6

tracecar0_s<-read.table(file = 'car0tf_5002.txt', sep=' ')
names(tracecar0_s)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar0_s$time <- as.POSIXlt(tracecar0_s$time, origin = "1987-10-05 11:00:00")
tracecar0_s$size<- tracecar0_s$size*8
taxabps1segcar0_s<-aggregate(list(size = tracecar0_s$size), list(segundos = cut(tracecar0_s$time, "1 sec")), sum)
taxabps1segcar0_sts<-ts(tracecar0_s$size, frequency = 1)

tracecar1_s<-read.table(file = 'car1tf_5002.txt', sep=' ')
names(tracecar1_s)<-c("time", "id", "size", "ori", "dest" )
tracecar1_s$time <- as.POSIXlt(tracecar1_s$time, origin = "1987-10-05 11:00:00")
tracecar1_s$size<- tracecar1_s$size*8
taxabps1segcar1_s<-aggregate(list(size = tracecar1_s$size), list(segundos = cut(tracecar1_s$time, "1 sec")), sum)
taxabps1segcar1_sts<-ts(tracecar1_s$size, frequency = 1)

tracecar2_s<-read.table(file = 'car2tf_5002.txt', sep=' ')
names(tracecar2_s)<-c("time", "id", "size", "ori", "dest" )
tracecar2_s$time <- as.POSIXlt(tracecar2_s$time, origin = "1987-10-05 11:00:00")
tracecar2_s$size<- tracecar2_s$size*8
taxabps1segcar2_s<-aggregate(list(size = tracecar2_s$size), list(segundos = cut(tracecar2_s$time, "1 sec")), sum)
taxabps1segcar2_sts<-ts(tracecar2_s$size, frequency = 1)

tracecar3_s<-read.table(file = 'car3tf_5002.txt', sep=' ')
names(tracecar3_s)<-c("time", "id", "size", "ori", "dest" )
tracecar3_s$time <- as.POSIXlt(tracecar3_s$time, origin = "1987-10-05 11:00:00")
tracecar3_s$size<- tracecar3_s$size*8
taxabps1segcar3_s<-aggregate(list(size = tracecar3_s$size), list(segundos = cut(tracecar3_s$time, "1 sec")), sum)
taxabps1segcar3_sts<-ts(tracecar3_s$size, frequency = 1)

tracecar4_s<-read.table(file = 'car4tf_5002.txt', sep=' ')
names(tracecar4_s)<-c("time", "id", "size", "ori", "dest" )
tracecar4_s$time <- as.POSIXlt(tracecar4_s$time, origin = "1987-10-05 11:00:00")
tracecar4_s$size<- tracecar4_s$size*8
taxabps1segcar4_s<-aggregate(list(size = tracecar4_s$size), list(segundos = cut(tracecar4_s$time, "1 sec")), sum)
taxabps1segcar4_sts<-ts(tracecar4_s$size, frequency = 1)

tracecar5_s<-read.table(file = 'car5tf_5002.txt', sep=' ')
names(tracecar5_s)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar5_s$time <- as.POSIXlt(tracecar5_s$time, origin = "1987-10-05 11:00:00")
tracecar5_s$size<- tracecar5_s$size*8
taxabps1segcar5_s<-aggregate(list(size = tracecar5_s$size), list(segundos = cut(tracecar5_s$time, "1 sec")), sum)
taxabps1segcar5_sts<-ts(tracecar5_s$size, frequency = 1)

tracecar6_s<-read.table(file = 'car6tf_5002.txt', sep=' ')
names(tracecar6_s)<-c("time", "id", "size", "ori", "dest" )
tracecar6_s$time <- as.POSIXlt(tracecar6_s$time, origin = "1987-10-05 11:00:00")
tracecar6_s$size<- tracecar6_s$size*8
taxabps1segcar6_s<-aggregate(list(size = tracecar6_s$size), list(segundos = cut(tracecar6_s$time, "1 sec")), sum)
taxabps1segcar6_sts<-ts(tracecar6_s$size, frequency = 1)



tracedelay_s0<-read.table(file = 'delay0_s.txt')
delay_s0<-append(list(delay = tracedelay_s0$V1), list(time = c(1:length(tracedelay_s0$V1))))

tracedelay_s1<-read.table(file = 'delay1_s.txt')
delay_s1<-append(list(delay = tracedelay_s1$V1), list(time = c(1:length(tracedelay_s1$V1))))

tracedelay_s2<-read.table(file = 'delay2_s.txt')
delay_s2<-append(list(delay = tracedelay_s2$V1), list(time = c(1:length(tracedelay_s2$V1))))

tracedelay_s3<-read.table(file = 'delay3_s.txt')
delay_s3<-append(list(delay = tracedelay_s3$V1), list(time = c(1:length(tracedelay_s3$V1))))

tracedelay_s4<-read.table(file = 'delay4_s.txt')
delay_s4<-append(list(delay = tracedelay_s4$V1), list(time = c(1:length(tracedelay_s4$V1))))

tracedelay_s5<-read.table(file = 'delay5_s.txt')
delay_s5<-append(list(delay = tracedelay_s5$V1), list(time = c(1:length(tracedelay_s5$V1))))

tracedelay_s6<-read.table(file = 'delay6_s.txt')
delay_s6<-append(list(delay = tracedelay_s6$V1), list(time = c(1:length(tracedelay_s6$V1))))

ctime_s<-c(0:299)
#tt<-c(taxabps1segcar0_s$size[1:195], taxabps1segcar1_s$size[1:195], taxabps1segcar2_s$size[1:195], taxabps1segcar3_s$size[1:195], taxabps1segcar4_s$size[1:195], taxabps1segcar5_s$size[1:195], taxabps1segcar6_s$size[1:195], taxabps1segcar7_s$size[1:195], taxabps1segcar8_s$size[1:195], taxabps1segcar9_s$size[1:195], taxabps1segcar10_s$size[1:195], taxabps1segcar11_s$size[1:195], taxabps1segcar12_s$size[1:195], taxabps1segcar13_s$size[1:195], taxabps1segcar14_s$size[1:195], taxabps1segcar15_s$size[1:195], taxabps1segcar16_s$size[1:195], taxabps1segcar17_s$size[1:195], taxabps1segcar18_s$size[1:195], taxabps1segcar19_s$size[1:195])
cartotal_s<-c(taxabps1segcar0_s$size[1:300], taxabps1segcar1_s$size[1:300], taxabps1segcar2_s$size[1:300], taxabps1segcar3_s$size[1:300], taxabps1segcar4_s$size[1:300], taxabps1segcar5_s$size[1:300], taxabps1segcar6_s$size[1:300])
carmean_s<-c(taxabps1segcar0_s$size[1:300] + taxabps1segcar1_s$size[1:300] + taxabps1segcar2_s$size[1:300] + taxabps1segcar3_s$size[1:300] + taxabps1segcar4_s$size[1:300] + taxabps1segcar5_s$size[1:300] + taxabps1segcar6_s$size[1:300])/7
fctime_s<-c(ctime, ctime, ctime, ctime, ctime, ctime, ctime)

stime_s<-c(0:299)
#tt<-c(taxabps1segserver_s_car0$size[1:195], taxabps1segserver_s_car1$size[1:195], taxabps1segserver_s_car2$size[1:195], taxabps1segserver_s_car3$size[1:195], taxabps1segserver_s_car4$size[1:195], taxabps1segserver_s_car5$size[1:195], taxabps1segserver_s_car6$size[1:195], taxabps1segserver_s_car7$size[1:195], taxabps1segserver_s_car8$size[1:195], taxabps1segserver_s_car9$size[1:195], taxabps1segserver_s_car10$size[1:195], taxabps1segserver_s_car11$size[1:195], taxabps1segserver_s_car12$size[1:195], taxabps1segserver_s_car13$size[1:195], taxabps1segserver_s_car14$size[1:195], taxabps1segserver_s_car15$size[1:195], taxabps1segserver_s_car16$size[1:195], taxabps1segserver_s_car17$size[1:195], taxabps1segserver_s_car18$size[1:195], taxabps1segserver_s_car19$size[1:195])
servertotal_s<-c(taxabps1segserver_s_car0$size[1:300], taxabps1segserver_s_car1$size[1:300], taxabps1segserver_s_car2$size[1:300], taxabps1segserver_s_car3$size[1:300], taxabps1segserver_s_car4$size[1:300], taxabps1segserver_s_car5$size[1:300], taxabps1segserver_s_car6$size[1:300])
servermean_s<-c(taxabps1segserver_s_car0$size[1:300] + taxabps1segserver_s_car1$size[1:300] + taxabps1segserver_s_car2$size[1:300] + taxabps1segserver_s_car3$size[1:300] + taxabps1segserver_s_car4$size[1:300] + taxabps1segserver_s_car5$size[1:300] + taxabps1segserver_s_car6$size[1:300])/7
fstime_s<-c(stime_s, stime_s, stime_s, stime_s, stime_s, stime_s, stime_s)

dtime_s<-c(0:299)
delaytotal_s<-c(delay_s0$delay[1:300], delay_s1$delay[1:300], delay_s2$delay[1:300], delay_s3$delay[1:300], delay_s4$delay[1:300], delay_s5$delay[1:300], delay_s6$delay[1:300])
delaymean_s<-c(delay_s0$delay[1:300] + delay_s1$delay[1:300] + delay_s2$delay[1:300] + delay_s3$delay[1:300] + delay_s4$delay[1:300] + delay_s5$delay[1:300] + delay_s6$delay[1:300])/7
fdtime_s<-c(dtime_s, dtime_s, dtime_s, dtime_s, dtime_s, dtime_s, dtime_s)

require(Rmisc)
x1<- cbind(fctime_s,cartotal_s)
x1<-data.frame(x1)
y1<-group.CI(cartotal_s~fctime_s,x1,ci = 0.95)

x2<- cbind(fstime_s,servertotal_s)
x2<-data.frame(x2)
y2<-group.CI(servertotal_s~fstime_s,x2,ci = 0.95)

x3<- cbind(fdtime_s,delaytotal_s)
x3<-data.frame(x3)
y3<-group.CI(delaytotal_s~fdtime_s,x3,ci = 0.95)


require(plotrix)

par(mar = c(5,5,2,5))

plotCI(ctime_s, carmean_s, ui=y1$cartotal_s.upper, li=y1$cartotal_s.lower, col="red", main="Server S", ylab = "Throughput (bps)", xlab = "time(s)", ylim = range(0:1e+06) )
lines(ctime_s,carmean_s, type = "l", col="black", lwd="2")

par(new=T)
plotCI(stime_s, servermean_s, ui=y2$servertotal_s.upper, li=y2$servertotal_s.lower, col="blue", axes=F, xlab=NA, ylab=NA, ylim = range(0:1e+06) )
lines(stime_s,servermean_s, type = "l", col="black", lwd="2")

par(new = T)
plotCI(dtime_s[2:300], delaymean_s[2:300], ui=y3$delaytotal_s.upper[2:300], li=y3$delaytotal_s.lower[2:300], col="orange", axes=F, xlab=NA, ylab=NA, ylim = range(0:50))
lines(dtime_s[2:300],delaymean_s[2:300], type = "l", col="black", lwd="2")
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft",
       legend=c("Server received", "Car Sent", "Delay"),
       lty=c(1,1,1), col=c("blue", "red", "orange"))
