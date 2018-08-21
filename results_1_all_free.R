#############################First scenario all RSUs free -  Server E

#Compute Server E received

traceserver_e_car0<-read.table(file = 'server_etf_car0.txt', sep=' ')
names(traceserver_e_car0)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_car0$time <- as.POSIXlt(traceserver_e_car0$time, origin = "1987-10-05 11:00:00")
traceserver_e_car0$size<- traceserver_e_car0$size*8
taxabps1segserver_e_car0<-aggregate(list(size = traceserver_e_car0$size), list(segundos = cut(traceserver_e_car0$time, "1 sec")), sum)

traceserver_e_car1<-read.table(file = 'server_etf_car1.txt', sep=' ')
names(traceserver_e_car1)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car1$time <- as.POSIXlt(traceserver_e_car1$time, origin = "1987-10-05 11:00:00")
traceserver_e_car1$size<- traceserver_e_car1$size*8
taxabps1segserver_e_car1<-aggregate(list(size = traceserver_e_car1$size), list(segundos = cut(traceserver_e_car1$time, "1 sec")), sum)

traceserver_e_car2<-read.table(file = 'server_etf_car2.txt', sep=' ')
names(traceserver_e_car2)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car2$time <- as.POSIXlt(traceserver_e_car2$time, origin = "1987-10-05 11:00:00")
traceserver_e_car2$size<- traceserver_e_car2$size*8
taxabps1segserver_e_car2<-aggregate(list(size = traceserver_e_car2$size), list(segundos = cut(traceserver_e_car2$time, "1 sec")), sum)

traceserver_e_car3<-read.table(file = 'server_etf_car3.txt', sep=' ')
names(traceserver_e_car3)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car3$time <- as.POSIXlt(traceserver_e_car3$time, origin = "1987-10-05 11:00:00")
traceserver_e_car3$size<- traceserver_e_car3$size*8
taxabps1segserver_e_car3<-aggregate(list(size = traceserver_e_car3$size), list(segundos = cut(traceserver_e_car3$time, "1 sec")), sum)

traceserver_e_car4<-read.table(file = 'server_etf_car4.txt', sep=' ')
names(traceserver_e_car4)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car4$time <- as.POSIXlt(traceserver_e_car4$time, origin = "1987-10-05 11:00:00")
traceserver_e_car4$size<- traceserver_e_car4$size*8
taxabps1segserver_e_car4<-aggregate(list(size = traceserver_e_car4$size), list(segundos = cut(traceserver_e_car4$time, "1 sec")), sum)

traceserver_e_car5<-read.table(file = 'server_etf_car5.txt', sep=' ')
names(traceserver_e_car5)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car5$time <- as.POSIXlt(traceserver_e_car5$time, origin = "1987-10-05 11:00:00")
traceserver_e_car5$size<- traceserver_e_car5$size*8
taxabps1segserver_e_car5<-aggregate(list(size = traceserver_e_car5$size), list(segundos = cut(traceserver_e_car5$time, "1 sec")), sum)

traceserver_e_car6<-read.table(file = 'server_etf_car6.txt', sep=' ')
names(traceserver_e_car6)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car6$time <- as.POSIXlt(traceserver_e_car6$time, origin = "1987-10-05 11:00:00")
traceserver_e_car6$size<- traceserver_e_car6$size*8
taxabps1segserver_e_car6<-aggregate(list(size = traceserver_e_car6$size), list(segundos = cut(traceserver_e_car6$time, "1 sec")), sum)

#Compute Car sent Server E

tracecar0_e<-read.table(file = 'car0tf_5003.txt', sep=' ')
names(tracecar0_e)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar0_e$time <- as.POSIXlt(tracecar0_e$time, origin = "1987-10-05 11:00:00")
tracecar0_e$size<- tracecar0_e$size*8
taxabps1segcar0_e<-aggregate(list(size = tracecar0_e$size), list(segundos = cut(tracecar0_e$time, "1 sec")), sum)
taxabps1segcar0_ets<-ts(tracecar0_e$size, frequency = 1)

tracecar1_e<-read.table(file = 'car1tf_5003.txt', sep=' ')
names(tracecar1_e)<-c("time", "id", "size", "ori", "dest" )
tracecar1_e$time <- as.POSIXlt(tracecar1_e$time, origin = "1987-10-05 11:00:00")
tracecar1_e$size<- tracecar1_e$size*8
taxabps1segcar1_e<-aggregate(list(size = tracecar1_e$size), list(segundos = cut(tracecar1_e$time, "1 sec")), sum)
taxabps1segcar1_ets<-ts(tracecar1_e$size, frequency = 1)

tracecar2_e<-read.table(file = 'car2tf_5003.txt', sep=' ')
names(tracecar2_e)<-c("time", "id", "size", "ori", "dest" )
tracecar2_e$time <- as.POSIXlt(tracecar2_e$time, origin = "1987-10-05 11:00:00")
tracecar2_e$size<- tracecar2_e$size*8
taxabps1segcar2_e<-aggregate(list(size = tracecar2_e$size), list(segundos = cut(tracecar2_e$time, "1 sec")), sum)
taxabps1segcar2_ets<-ts(tracecar2_e$size, frequency = 1)

tracecar3_e<-read.table(file = 'car3tf_5003.txt', sep=' ')
names(tracecar3_e)<-c("time", "id", "size", "ori", "dest" )
tracecar3_e$time <- as.POSIXlt(tracecar3_e$time, origin = "1987-10-05 11:00:00")
tracecar3_e$size<- tracecar3_e$size*8
taxabps1segcar3_e<-aggregate(list(size = tracecar3_e$size), list(segundos = cut(tracecar3_e$time, "1 sec")), sum)
taxabps1segcar3_ets<-ts(tracecar3_e$size, frequency = 1)

tracecar4_e<-read.table(file = 'car4tf_5003.txt', sep=' ')
names(tracecar4_e)<-c("time", "id", "size", "ori", "dest" )
tracecar4_e$time <- as.POSIXlt(tracecar4_e$time, origin = "1987-10-05 11:00:00")
tracecar4_e$size<- tracecar4_e$size*8
taxabps1segcar4_e<-aggregate(list(size = tracecar4_e$size), list(segundos = cut(tracecar4_e$time, "1 sec")), sum)
taxabps1segcar4_ets<-ts(tracecar4_e$size, frequency = 1)

tracecar5_e<-read.table(file = 'car5tf_5003.txt', sep=' ')
names(tracecar5_e)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar5_e$time <- as.POSIXlt(tracecar5_e$time, origin = "1987-10-05 11:00:00")
tracecar5_e$size<- tracecar5_e$size*8
taxabps1segcar5_e<-aggregate(list(size = tracecar5_e$size), list(segundos = cut(tracecar5_e$time, "1 sec")), sum)
taxabps1segcar5_ets<-ts(tracecar5_e$size, frequency = 1)

tracecar6_e<-read.table(file = 'car6tf_5003.txt', sep=' ')
names(tracecar6_e)<-c("time", "id", "size", "ori", "dest" )
tracecar6_e$time <- as.POSIXlt(tracecar6_e$time, origin = "1987-10-05 11:00:00")
tracecar6_e$size<- tracecar6_e$size*8
taxabps1segcar6_e<-aggregate(list(size = tracecar6_e$size), list(segundos = cut(tracecar6_e$time, "1 sec")), sum)
taxabps1segcar6_ets<-ts(tracecar6_e$size, frequency = 1)

#Compute Delay Server E

tracedelay_e0<-read.table(file = 'delay0_e.txt')
delay_e0<-append(list(delay = tracedelay_e0$V1), list(time = c(1:length(tracedelay_e0$V1))))

tracedelay_e1<-read.table(file = 'delay1_e.txt')
delay_e1<-append(list(delay = tracedelay_e1$V1), list(time = c(1:length(tracedelay_e1$V1))))

tracedelay_e2<-read.table(file = 'delay2_e.txt')
delay_e2<-append(list(delay = tracedelay_e2$V1), list(time = c(1:length(tracedelay_e2$V1))))

tracedelay_e3<-read.table(file = 'delay3_e.txt')
delay_e3<-append(list(delay = tracedelay_e3$V1), list(time = c(1:length(tracedelay_e3$V1))))

tracedelay_e4<-read.table(file = 'delay4_e.txt')
delay_e4<-append(list(delay = tracedelay_e4$V1), list(time = c(1:length(tracedelay_e4$V1))))

tracedelay_e5<-read.table(file = 'delay5_e.txt')
delay_e5<-append(list(delay = tracedelay_e5$V1), list(time = c(1:length(tracedelay_e5$V1))))

tracedelay_e6<-read.table(file = 'delay6_e.txt')
delay_e6<-append(list(delay = tracedelay_e6$V1), list(time = c(1:length(tracedelay_e6$V1))))


#Plot Graphs Server E

ctime_e<-c(0:299)
#tt<-c(taxabps1segcar0_e$size[1:195], taxabps1segcar1_e$size[1:195], taxabps1segcar2_e$size[1:195], taxabps1segcar3_e$size[1:195], taxabps1segcar4_e$size[1:195], taxabps1segcar5_e$size[1:195], taxabps1segcar6_e$size[1:195], taxabps1segcar7_e$size[1:195], taxabps1segcar8_e$size[1:195], taxabps1segcar9_e$size[1:195], taxabps1segcar10_e$size[1:195], taxabps1segcar11_e$size[1:195], taxabps1segcar12_e$size[1:195], taxabps1segcar13_e$size[1:195], taxabps1segcar14_e$size[1:195], taxabps1segcar15_e$size[1:195], taxabps1segcar16_e$size[1:195], taxabps1segcar17_e$size[1:195], taxabps1segcar18_e$size[1:195], taxabps1segcar19_e$size[1:195])
cartotal_e<-c(taxabps1segcar0_e$size[1:300], taxabps1segcar1_e$size[1:300], taxabps1segcar2_e$size[1:300], taxabps1segcar3_e$size[1:300], taxabps1segcar4_e$size[1:300], taxabps1segcar5_e$size[1:300], taxabps1segcar6_e$size[1:300])
carmean_e<-c(taxabps1segcar0_e$size[1:300] + taxabps1segcar1_e$size[1:300] + taxabps1segcar2_e$size[1:300] + taxabps1segcar3_e$size[1:300] + taxabps1segcar4_e$size[1:300] + taxabps1segcar5_e$size[1:300] + taxabps1segcar6_e$size[1:300])/7
fctime_e<-c(ctime, ctime, ctime, ctime, ctime, ctime, ctime)

stime_e<-c(0:299)
#tt<-c(taxabps1segserver_e_car0$size[1:195], taxabps1segserver_e_car1$size[1:195], taxabps1segserver_e_car2$size[1:195], taxabps1segserver_e_car3$size[1:195], taxabps1segserver_e_car4$size[1:195], taxabps1segserver_e_car5$size[1:195], taxabps1segserver_e_car6$size[1:195], taxabps1segserver_e_car7$size[1:195], taxabps1segserver_e_car8$size[1:195], taxabps1segserver_e_car9$size[1:195], taxabps1segserver_e_car10$size[1:195], taxabps1segserver_e_car11$size[1:195], taxabps1segserver_e_car12$size[1:195], taxabps1segserver_e_car13$size[1:195], taxabps1segserver_e_car14$size[1:195], taxabps1segserver_e_car15$size[1:195], taxabps1segserver_e_car16$size[1:195], taxabps1segserver_e_car17$size[1:195], taxabps1segserver_e_car18$size[1:195], taxabps1segserver_e_car19$size[1:195])
servertotal_e<-c(taxabps1segserver_e_car0$size[1:300], taxabps1segserver_e_car1$size[1:300], taxabps1segserver_e_car2$size[1:300], taxabps1segserver_e_car3$size[1:300], taxabps1segserver_e_car4$size[1:300], taxabps1segserver_e_car5$size[1:300], taxabps1segserver_e_car6$size[1:300])
servermean_e<-c(taxabps1segserver_e_car0$size[1:300] + taxabps1segserver_e_car1$size[1:300] + taxabps1segserver_e_car2$size[1:300] + taxabps1segserver_e_car3$size[1:300] + taxabps1segserver_e_car4$size[1:300] + taxabps1segserver_e_car5$size[1:300] + taxabps1segserver_e_car6$size[1:300])/7
fstime_e<-c(stime_e, stime_e, stime_e, stime_e, stime_e, stime_e, stime_e)

dtime_e<-c(0:299)
delaytotal_e<-c(delay_e0$delay[1:300], delay_e1$delay[1:300], delay_e2$delay[1:300], delay_e3$delay[1:300], delay_e4$delay[1:300], delay_e5$delay[1:300], delay_e6$delay[1:300])
delaymean_e<-c(delay_e0$delay[1:300] + delay_e1$delay[1:300] + delay_e2$delay[1:300] + delay_e3$delay[1:300] + delay_e4$delay[1:300] + delay_e5$delay[1:300] + delay_e6$delay[1:300])/7
fdtime_e<-c(dtime_e, dtime_e, dtime_e, dtime_e, dtime_e, dtime_e, dtime_e)

ptime_e<-c(0:299)
PDRtotal_e<- c(taxabps1segserver_e_car0$size[1:300]/taxabps1segcar0_e$size[1:300], taxabps1segserver_e_car1$size[1:300]/taxabps1segcar1_e$size[1:300], taxabps1segserver_e_car2$size[1:300]/taxabps1segcar2_e$size[1:300], taxabps1segserver_e_car3$size[1:300]/taxabps1segcar3_e$size[1:300], taxabps1segserver_e_car4$size[1:300]/taxabps1segcar4_e$size[1:300], taxabps1segserver_e_car5$size[1:300]/taxabps1segcar5_e$size[1:300], taxabps1segserver_e_car6$size[1:300]/taxabps1segcar6_e$size[1:300])
PDRmean_e<-c(taxabps1segserver_e_car0$size[1:300]/taxabps1segcar0_e$size[1:300] + taxabps1segserver_e_car1$size[1:300]/taxabps1segcar1_e$size[1:300] + taxabps1segserver_e_car2$size[1:300]/taxabps1segcar2_e$size[1:300] + taxabps1segserver_e_car3$size[1:300]/taxabps1segcar3_e$size[1:300] + taxabps1segserver_e_car4$size[1:300]/taxabps1segcar4_e$size[1:300] + taxabps1segserver_e_car5$size[1:300]/taxabps1segcar5_e$size[1:300] + taxabps1segserver_e_car6$size[1:300]/taxabps1segcar6_e$size[1:300])/7
fptime_e<-c(ptime_e, ptime_e, ptime_e, ptime_e, ptime_e, ptime_e, ptime_e) 


require(Rmisc)
x1<- cbind(fctime_e,cartotal_e)
x1<-data.frame(x1)
y1<-group.CI(cartotal_e~fctime_e,x1,ci = 0.95)

x2<- cbind(fstime_e,servertotal_e)
x2<-data.frame(x2)
y2<-group.CI(servertotal_e~fstime_e,x2,ci = 0.95)

x3<- cbind(fdtime_e,delaytotal_e)
x3<-data.frame(x3)
y3<-group.CI(delaytotal_e~fdtime_e,x3,ci = 0.95)

x4<- cbind(fptime_e,PDRtotal_e)
x4<-data.frame(x4)
y4<-group.CI(PDRtotal_e~fptime_e,x4,ci = 0.95)


require(plotrix)

par(mar = c(5,5,2,5))

plotCI(ctime_e, carmean_e, ui=y1$cartotal_e.upper, li=y1$cartotal_e.lower, col="red", main="Server E", ylab = "Throughput (bps)", xlab = "time(s)", ylim = range(0:1e+06) )
lines(ctime_e,carmean_e, type = "l", col="black", lwd="2")

par(new=T)
plotCI(stime_e, servermean_e, ui=y2$servertotal_e.upper, li=y2$servertotal_e.lower, col="blue", axes=F, xlab=NA, ylab=NA, ylim = range(0:1e+06) )
lines(stime_e,servermean_e, type = "l", col="black", lwd="2")

par(new = T)
plotCI(dtime_e[2:300], delaymean_e[2:300], ui=y3$delaytotal_e.upper[2:300], li=y3$delaytotal_e.lower[2:300], col="orange", axes=F, xlab=NA, ylab=NA, ylim = range(0:1000))
lines(dtime_e[2:300],delaymean_e[2:300], type = "l", col="black", lwd="2")
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft",
       legend=c("Server received", "Car Sent", "Delay"),
       lty=c(1,1,1), col=c("blue", "red", "orange"))


plotCI(ptime_e, PDRmean_e, ui=y4$PDRtotal_e.upper, li=y4$PDRtotal_e.lower, col="red", main="PDR E", ylab = "PDR mean (%)", xlab = "time(s)")
lines(ptime_e,PDRmean_e, type = "l", col="black", lwd="2")


#############################First scenario all RSUs free -  Server G


#Compute Server G received

traceserver_g_car0<-read.table(file = 'server_gtf_car0.txt', sep=' ')
names(traceserver_g_car0)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_g_car0$time <- as.POSIXlt(traceserver_g_car0$time, origin = "1987-10-05 11:00:00")
traceserver_g_car0$size<- traceserver_g_car0$size*8
taxabps1segserver_g_car0<-aggregate(list(size = traceserver_g_car0$size), list(segundos = cut(traceserver_g_car0$time, "1 sec")), sum)
taxabps1segserver_g_car0$segundos<-as.numeric(taxabps1segserver_g_car0$segundos)

traceserver_g_car1<-read.table(file = 'server_gtf_car1.txt', sep=' ')
names(traceserver_g_car1)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car1$time <- as.POSIXlt(traceserver_g_car1$time, origin = "1987-10-05 11:00:00")
traceserver_g_car1$size<- traceserver_g_car1$size*8
taxabps1segserver_g_car1<-aggregate(list(size = traceserver_g_car1$size), list(segundos = cut(traceserver_g_car1$time, "1 sec")), sum)
taxabps1segserver_g_car1$segundos<-as.numeric(taxabps1segserver_g_car1$segundos)

traceserver_g_car2<-read.table(file = 'server_gtf_car2.txt', sep=' ')
names(traceserver_g_car2)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car2$time <- as.POSIXlt(traceserver_g_car2$time, origin = "1987-10-05 11:00:00")
traceserver_g_car2$size<- traceserver_g_car2$size*8
taxabps1segserver_g_car2<-aggregate(list(size = traceserver_g_car2$size), list(segundos = cut(traceserver_g_car2$time, "1 sec")), sum)
taxabps1segserver_g_car2$segundos<-as.numeric(taxabps1segserver_g_car2$segundos)

traceserver_g_car3<-read.table(file = 'server_gtf_car3.txt', sep=' ')
names(traceserver_g_car3)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car3$time <- as.POSIXlt(traceserver_g_car3$time, origin = "1987-10-05 11:00:00")
traceserver_g_car3$size<- traceserver_g_car3$size*8
taxabps1segserver_g_car3<-aggregate(list(size = traceserver_g_car3$size), list(segundos = cut(traceserver_g_car3$time, "1 sec")), sum)
taxabps1segserver_g_car3$segundos<-as.numeric(taxabps1segserver_g_car3$segundos)

traceserver_g_car4<-read.table(file = 'server_gtf_car4.txt', sep=' ')
names(traceserver_g_car4)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car4$time <- as.POSIXlt(traceserver_g_car4$time, origin = "1987-10-05 11:00:00")
traceserver_g_car4$size<- traceserver_g_car4$size*8
taxabps1segserver_g_car4<-aggregate(list(size = traceserver_g_car4$size), list(segundos = cut(traceserver_g_car4$time, "1 sec")), sum)
taxabps1segserver_g_car4$segundos<-as.numeric(taxabps1segserver_g_car4$segundos)

traceserver_g_car5<-read.table(file = 'server_gtf_car5.txt', sep=' ')
names(traceserver_g_car5)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car5$time <- as.POSIXlt(traceserver_g_car5$time, origin = "1987-10-05 11:00:00")
traceserver_g_car5$size<- traceserver_g_car5$size*8
taxabps1segserver_g_car5<-aggregate(list(size = traceserver_g_car5$size), list(segundos = cut(traceserver_g_car5$time, "1 sec")), sum)
taxabps1segserver_g_car5$segundos<-as.numeric(taxabps1segserver_g_car5$segundos)

traceserver_g_car6<-read.table(file = 'server_gtf_car6.txt', sep=' ')
names(traceserver_g_car6)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car6$time <- as.POSIXlt(traceserver_g_car6$time, origin = "1987-10-05 11:00:00")
traceserver_g_car6$size<- traceserver_g_car6$size*8
taxabps1segserver_g_car6<-aggregate(list(size = traceserver_g_car6$size), list(segundos = cut(traceserver_g_car6$time, "1 sec")), sum)
taxabps1segserver_g_car6$segundos<-as.numeric(taxabps1segserver_g_car6$segundos)

plot(taxabps1segserver_g_car0$segundos, taxabps1segserver_g_car0$size, type = "o", col="red", pch=19, lty=6)
lines(taxabps1segserver_g_car1$segundos, taxabps1segserver_g_car1$size, type = "o", col="blue", pch=19, lty=6)
lines(taxabps1segserver_g_car2$segundos, taxabps1segserver_g_car2$size, type = "o", col="green", pch=19, lty=6)
lines(taxabps1segserver_g_car3$segundos, taxabps1segserver_g_car3$size, type = "o", col="orange", pch=19, lty=6)
lines(taxabps1segserver_g_car4$segundos, taxabps1segserver_g_car4$size, type = "o", col="brown", pch=19, lty=6)
lines(taxabps1segserver_g_car5$segundos, taxabps1segserver_g_car5$size, type = "o", col="yellow", pch=19, lty=6)
lines(taxabps1segserver_g_car6$segundos, taxabps1segserver_g_car6$size, type = "o", col="pink", pch=19, lty=6)



#Compute Car sent Server G

tracecar0_g<-read.table(file = 'car0tf_5005.txt', sep=' ')
names(tracecar0_g)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar0_g$time <- as.POSIXlt(tracecar0_g$time, origin = "1987-10-05 11:00:00")
tracecar0_g$size<- tracecar0_g$size*8
taxabps1segcar0_g<-aggregate(list(size = tracecar0_g$size), list(segundos = cut(tracecar0_g$time, "1 sec")), sum)
taxabps1segcar0_g$segundos<-as.numeric(taxabps1segcar0_g$segundos)

tracecar1_g<-read.table(file = 'car1tf_5005.txt', sep=' ')
names(tracecar1_g)<-c("time", "id", "size", "ori", "dest" )
tracecar1_g$time <- as.POSIXlt(tracecar1_g$time, origin = "1987-10-05 11:00:00")
tracecar1_g$size<- tracecar1_g$size*8
taxabps1segcar1_g<-aggregate(list(size = tracecar1_g$size), list(segundos = cut(tracecar1_g$time, "1 sec")), sum)
taxabps1segcar1_g$segundos<-as.numeric(taxabps1segcar1_g$segundos)

tracecar2_g<-read.table(file = 'car2tf_5005.txt', sep=' ')
names(tracecar2_g)<-c("time", "id", "size", "ori", "dest" )
tracecar2_g$time <- as.POSIXlt(tracecar2_g$time, origin = "1987-10-05 11:00:00")
tracecar2_g$size<- tracecar2_g$size*8
taxabps1segcar2_g<-aggregate(list(size = tracecar2_g$size), list(segundos = cut(tracecar2_g$time, "1 sec")), sum)
taxabps1segcar2_g$segundos<-as.numeric(taxabps1segcar2_g$segundos)

tracecar3_g<-read.table(file = 'car3tf_5005.txt', sep=' ')
names(tracecar3_g)<-c("time", "id", "size", "ori", "dest" )
tracecar3_g$time <- as.POSIXlt(tracecar3_g$time, origin = "1987-10-05 11:00:00")
tracecar3_g$size<- tracecar3_g$size*8
taxabps1segcar3_g<-aggregate(list(size = tracecar3_g$size), list(segundos = cut(tracecar3_g$time, "1 sec")), sum)
taxabps1segcar3_g$segundos<-as.numeric(taxabps1segcar3_g$segundos)

tracecar4_g<-read.table(file = 'car4tf_5005.txt', sep=' ')
names(tracecar4_g)<-c("time", "id", "size", "ori", "dest" )
tracecar4_g$time <- as.POSIXlt(tracecar4_g$time, origin = "1987-10-05 11:00:00")
tracecar4_g$size<- tracecar4_g$size*8
taxabps1segcar4_g<-aggregate(list(size = tracecar4_g$size), list(segundos = cut(tracecar4_g$time, "1 sec")), sum)
taxabps1segcar4_g$segundos<-as.numeric(taxabps1segcar4_g$segundos)

tracecar5_g<-read.table(file = 'car5tf_5005.txt', sep=' ')
names(tracecar5_g)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar5_g$time <- as.POSIXlt(tracecar5_g$time, origin = "1987-10-05 11:00:00")
tracecar5_g$size<- tracecar5_g$size*8
taxabps1segcar5_g<-aggregate(list(size = tracecar5_g$size), list(segundos = cut(tracecar5_g$time, "1 sec")), sum)
taxabps1segcar5_g$segundos<-as.numeric(taxabps1segcar5_g$segundos)

tracecar6_g<-read.table(file = 'car6tf_5005.txt', sep=' ')
names(tracecar6_g)<-c("time", "id", "size", "ori", "dest" )
tracecar6_g$time <- as.POSIXlt(tracecar6_g$time, origin = "1987-10-05 11:00:00")
tracecar6_g$size<- tracecar6_g$size*8
taxabps1segcar6_g<-aggregate(list(size = tracecar6_g$size), list(segundos = cut(tracecar6_g$time, "1 sec")), sum)
taxabps1segcar6_g$segundos<-as.numeric(taxabps1segcar6_g$segundos)

#Compute Delay Server G

tracedelay_g0<-read.table(file = 'delay0_g.txt')
names(tracedelay_g0)<-c("time", "delay")

tracedelay_g1<-read.table(file = 'delay1_g.txt')
names(tracedelay_g1)<-c("time", "delay")

tracedelay_g2<-read.table(file = 'delay2_g.txt')
names(tracedelay_g2)<-c("time", "delay")

tracedelay_g3<-read.table(file = 'delay3_g.txt')
names(tracedelay_g3)<-c("time", "delay")

tracedelay_g4<-read.table(file = 'delay4_g.txt')
names(tracedelay_g4)<-c("time", "delay")

tracedelay_g5<-read.table(file = 'delay5_g.txt')
names(tracedelay_g5)<-c("time", "delay")

tracedelay_g6<-read.table(file = 'delay6_g.txt')
names(tracedelay_g6)<-c("time", "delay")

tracedelayfc_g<-read.table(file = "delayfc_g.txt")
names(tracedelayfc_g)<-c("time", "delay")
tracedelayfc_g$time <- as.POSIXlt(tracedelayfc_g$time, origin = "1987-10-05 11:00:00")
taxameansecfc_g<-aggregate(list(delay = tracedelayfc_g$delay), list(segundos = cut(tracedelayfc_g$time, "1 sec")), mean)
taxameansecfc_g$segundos<-as.numeric(taxameansecfc_g$segundos)

lines(taxameansecfc_g$segundos, taxameansecfc_g$delay, type = "l", col="red", lwd="2")


taxameansecfc_g
hist(taxameansecfc_g$delay, axes=F, xlab=NA, ylab=NA)

hist(taxameansecfc_g$delay)
boxplot(taxameansecfc_g$delay, ylim=c(22000,25000), ylab="delay (ms)", main="Delay")
plot(taxameansecfc_g$segundos, taxameansecfc_g$delay, type = "l", col="red", lwd="2")



taxasdsecfc_g<-aggregate(list(delay = tracedelayfc_g$delay), list(segundos = cut(tracedelayfc_g$time, "1 sec")), sd)


taxasdsecfc_g


#delaytotal_g<-c(delay_g0$delay, delay_g1$delay, delay_g2$delay, delay_g3$delay, delay_g4$delay, delay_g5$delay, delay_g6$delay)
#delaymean_g<-c(delay_g0$delay + delay_g1$delay + delay_g2$delay + delay_g3$delay + delay_g4$delay + delay_g5$delay + delay_g6$delay)/7
# fdtime_g<-c(delay_g0$time, delay_g1$time, delay_g2$time, delay_g3$time, delay_g4$time, delay_g5$time, delay_g6$time)

delaytotal_g<-tracedelayfc_g$delay
delaymean_g<-taxameansecfc_g$delay
fdtime_g<-taxameansecfc_g$segundos
  


x3<- cbind(fdtime_g,delaytotal_g)
x3<-data.frame(x3)
y3<-group.CI(delaytotal_g~fdtime_g,x3,ci = 0.95)





#Plot Graphs Server G

cartotal_g<-c(taxabps1segcar0_g$size, taxabps1segcar1_g$size, taxabps1segcar2_g$size, taxabps1segcar3_g$size, taxabps1segcar4_g$size, taxabps1segcar5_g$size, taxabps1segcar6_g$size)
carmean_g<-c(taxabps1segcar0_g$size + taxabps1segcar1_g$size + taxabps1segcar2_g$size + taxabps1segcar3_g$size + taxabps1segcar4_g$size + taxabps1segcar5_g$size + taxabps1segcar6_g$size)/7
fctime_g<-c(taxabps1segcar0_g$segundos, taxabps1segcar1_g$segundos, taxabps1segcar2_g$segundos, taxabps1segcar3_g$segundos, taxabps1segcar4_g$segundos, taxabps1segcar5_g$segundos, taxabps1segcar6_g$segundos)

round(length(cartotal_g)/7)







servertotal_g<-c(taxabps1segserver_g_car0$size, taxabps1segserver_g_car1$size, taxabps1segserver_g_car2$size, taxabps1segserver_g_car3$size, taxabps1segserver_g_car4$size, taxabps1segserver_g_car5$size, taxabps1segserver_g_car6$size)
servermean_g<-c(taxabps1segserver_g_car0$size + taxabps1segserver_g_car1$size + taxabps1segserver_g_car2$size + taxabps1segserver_g_car3$size + taxabps1segserver_g_car4$size + taxabps1segserver_g_car5$size + taxabps1segserver_g_car6$size)/7
fstime_g<-c(taxabps1segserver_g_car0$segundos, taxabps1segserver_g_car1$segundos, taxabps1segserver_g_car2$segundos, taxabps1segserver_g_car3$segundos, taxabps1segserver_g_car4$segundos, taxabps1segserver_g_car5$segundos, taxabps1segserver_g_car6$segundos)

delaytotal_g<-c(delay_g0$delay, delay_g1$delay, delay_g2$delay, delay_g3$delay, delay_g4$delay, delay_g5$delay, delay_g6$delay)
delaymean_g<-c(delay_g0$delay + delay_g1$delay + delay_g2$delay + delay_g3$delay + delay_g4$delay + delay_g5$delay + delay_g6$delay)/7
fdtime_g<-c(delay_g0$time, delay_g1$time, delay_g2$time, delay_g3$time, delay_g4$time, delay_g5$time, delay_g6$time)

PDRtotal_g<- c(taxabps1segserver_g_car0$size/taxabps1segcar0_g$size, taxabps1segserver_g_car1$size/taxabps1segcar1_g$size, taxabps1segserver_g_car2$size/taxabps1segcar2_g$size, taxabps1segserver_g_car3$size/taxabps1segcar3_g$size, taxabps1segserver_g_car4$size/taxabps1segcar4_g$size, taxabps1segserver_g_car5$size/taxabps1segcar5_g$size, taxabps1segserver_g_car6$size/taxabps1segcar6_g$size)
PDRmean_g<-c(taxabps1segserver_g_car0$size/taxabps1segcar0_g$size + taxabps1segserver_g_car1$size/taxabps1segcar1_g$size + taxabps1segserver_g_car2$size/taxabps1segcar2_g$size + taxabps1segserver_g_car3$size/taxabps1segcar3_g$size + taxabps1segserver_g_car4$size/taxabps1segcar4_g$size + taxabps1segserver_g_car5$size/taxabps1segcar5_g$size + taxabps1segserver_g_car6$size/taxabps1segcar6_g$size)/7
fptime_g<-c(taxabps1segserver_g_car0$segundos, taxabps1segserver_g_car1$segundos, taxabps1segserver_g_car2$segundos, taxabps1segserver_g_car3$segundos, taxabps1segserver_g_car4$segundos, taxabps1segserver_g_car5$segundos, taxabps1segserver_g_car6$segundos) 


require(Rmisc)
x1<- cbind(fctime_g,cartotal_g)
x1<-data.frame(x1)
y1<-group.CI(cartotal_g~fctime_g,x1,ci = 0.95)

length(cartotal_g)
length(fctime_g)

x[is.na(x)] <-0

x2<- cbind(fstime_g,servertotal_g)
x2<-data.frame(x2)
y2<-group.CI(servertotal_g~fstime_g,x2,ci = 0.95)

x3<- cbind(fdtime_g,delaytotal_g)
x3<-data.frame(x3)
y3<-group.CI(delaytotal_g~fdtime_g,x3,ci = 0.95)

x4<- cbind(fptime_g,PDRtotal_g)
x4<-data.frame(x4)
y4<-group.CI(PDRtotal_g~fptime_g,x4,ci = 0.95)


require(plotrix)

par(mar = c(5,5,2,5))

plotCI(ctime_g, carmean_g, ui=y1$cartotal_g.upper, li=y1$cartotal_g.lower, col="red", main="Server G", ylab = "Throughput (bps)", xlab = "time(s)", ylim = range(0:1e+06) )
lines(ctime_g,carmean_g, type = "l", col="black", lwd="2")

par(new=T)
plotCI(stime_g, servermean_g, ui=y2$servertotal_g.upper, li=y2$servertotal_g.lower, col="blue", axes=F, xlab=NA, ylab=NA, ylim = range(0:1e+06) )
lines(stime_g,servermean_g, type = "l", col="black", lwd="2")

par(new = T)
plotCI(dtime_g[2:300], delaymean_g[2:300], ui=y3$delaytotal_g.upper[2:300], li=y3$delaytotal_g.lower[2:300], col="orange", axes=F, xlab=NA, ylab=NA, ylim = range(0:1000))
lines(dtime_g[2:300],delaymean_g[2:300], type = "l", col="black", lwd="2")
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft",
       legend=c("Server received", "Car Sent", "Delay"),
       lty=c(1,1,1), col=c("blue", "red", "orange"))

plotCI(ptime_g, PDRmean_g, ui=y4$PDRtotal_g.upper, li=y4$PDRtotal_g.lower, col="red", main="PDR G", ylab = "PDR mean (%)", xlab = "time(s)")
lines(ptime_g,PDRmean_g, type = "l", col="black", lwd="2")

###############Server E2

#Compute Server E2 received

traceserver_e2_car0<-read.table(file = 'server_e2tf_car0.txt', sep=' ')
names(traceserver_e2_car0)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_e2_car0$time <- as.POSIXlt(traceserver_e2_car0$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car0$size<- traceserver_e2_car0$size*8
taxabps1segserver_e2_car0<-aggregate(list(size = traceserver_e2_car0$size), list(segundos = cut(traceserver_e2_car0$time, "1 sec")), sum)
taxabps1segserverts_e2_car0<-ts(traceserver_e2_car0$size, frequency = 1)

traceserver_e2_car1<-read.table(file = 'server_e2tf_car1.txt', sep=' ')
names(traceserver_e2_car1)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car1$time <- as.POSIXlt(traceserver_e2_car1$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car1$size<- traceserver_e2_car1$size*8
taxabps1segserver_e2_car1<-aggregate(list(size = traceserver_e2_car1$size), list(segundos = cut(traceserver_e2_car1$time, "1 sec")), sum)
taxabps1segserverts_e2_car1<-ts(traceserver_e2_car1$size, frequency = 1)

traceserver_e2_car2<-read.table(file = 'server_e2tf_car2.txt', sep=' ')
names(traceserver_e2_car2)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car2$time <- as.POSIXlt(traceserver_e2_car2$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car2$size<- traceserver_e2_car2$size*8
taxabps1segserver_e2_car2<-aggregate(list(size = traceserver_e2_car2$size), list(segundos = cut(traceserver_e2_car2$time, "1 sec")), sum)
taxabps1segserverts_e2_car2<-ts(traceserver_e2_car2$size, frequency = 1)

traceserver_e2_car3<-read.table(file = 'server_e2tf_car3.txt', sep=' ')
names(traceserver_e2_car3)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car3$time <- as.POSIXlt(traceserver_e2_car3$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car3$size<- traceserver_e2_car3$size*8
taxabps1segserver_e2_car3<-aggregate(list(size = traceserver_e2_car3$size), list(segundos = cut(traceserver_e2_car3$time, "1 sec")), sum)
taxabps1segserverts_e2_car3<-ts(traceserver_e2_car3$size, frequency = 1)

traceserver_e2_car4<-read.table(file = 'server_e2tf_car4.txt', sep=' ')
names(traceserver_e2_car4)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car4$time <- as.POSIXlt(traceserver_e2_car4$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car4$size<- traceserver_e2_car4$size*8
taxabps1segserver_e2_car4<-aggregate(list(size = traceserver_e2_car4$size), list(segundos = cut(traceserver_e2_car4$time, "1 sec")), sum)
taxabps1segserverts_e2_car4<-ts(traceserver_e2_car4$size, frequency = 1)

traceserver_e2_car5<-read.table(file = 'server_e2tf_car5.txt', sep=' ')
names(traceserver_e2_car5)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car5$time <- as.POSIXlt(traceserver_e2_car5$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car5$size<- traceserver_e2_car5$size*8
taxabps1segserver_e2_car5<-aggregate(list(size = traceserver_e2_car5$size), list(segundos = cut(traceserver_e2_car5$time, "1 sec")), sum)
taxabps1segserverts_e2_car5<-ts(traceserver_e2_car5$size, frequency = 1)

traceserver_e2_car6<-read.table(file = 'server_e2tf_car6.txt', sep=' ')
names(traceserver_e2_car6)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car6$time <- as.POSIXlt(traceserver_e2_car6$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car6$size<- traceserver_e2_car6$size*8
taxabps1segserver_e2_car6<-aggregate(list(size = traceserver_e2_car6$size), list(segundos = cut(traceserver_e2_car6$time, "1 sec")), sum)
taxabps1segserverts_e2_car6<-ts(traceserver_e2_car6$size, frequency = 1)

#Compute Car sent Server E2

tracecar0_e2<-read.table(file = 'car0tf_5004.txt', sep=' ')
names(tracecar0_e2)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar0_e2$time <- as.POSIXlt(tracecar0_e2$time, origin = "1987-10-05 11:00:00")
tracecar0_e2$size<- tracecar0_e2$size*8
taxabps1segcar0_e2<-aggregate(list(size = tracecar0_e2$size), list(segundos = cut(tracecar0_e2$time, "1 sec")), sum)
taxabps1segcar0_e2ts<-ts(tracecar0_e2$size, frequency = 1)

tracecar1_e2<-read.table(file = 'car1tf_5004.txt', sep=' ')
names(tracecar1_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar1_e2$time <- as.POSIXlt(tracecar1_e2$time, origin = "1987-10-05 11:00:00")
tracecar1_e2$size<- tracecar1_e2$size*8
taxabps1segcar1_e2<-aggregate(list(size = tracecar1_e2$size), list(segundos = cut(tracecar1_e2$time, "1 sec")), sum)
taxabps1segcar1_e2ts<-ts(tracecar1_e2$size, frequency = 1)

tracecar2_e2<-read.table(file = 'car2tf_5004.txt', sep=' ')
names(tracecar2_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar2_e2$time <- as.POSIXlt(tracecar2_e2$time, origin = "1987-10-05 11:00:00")
tracecar2_e2$size<- tracecar2_e2$size*8
taxabps1segcar2_e2<-aggregate(list(size = tracecar2_e2$size), list(segundos = cut(tracecar2_e2$time, "1 sec")), sum)
taxabps1segcar2_e2ts<-ts(tracecar2_e2$size, frequency = 1)

tracecar3_e2<-read.table(file = 'car3tf_5004.txt', sep=' ')
names(tracecar3_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar3_e2$time <- as.POSIXlt(tracecar3_e2$time, origin = "1987-10-05 11:00:00")
tracecar3_e2$size<- tracecar3_e2$size*8
taxabps1segcar3_e2<-aggregate(list(size = tracecar3_e2$size), list(segundos = cut(tracecar3_e2$time, "1 sec")), sum)
taxabps1segcar3_e2ts<-ts(tracecar3_e2$size, frequency = 1)

tracecar4_e2<-read.table(file = 'car4tf_5004.txt', sep=' ')
names(tracecar4_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar4_e2$time <- as.POSIXlt(tracecar4_e2$time, origin = "1987-10-05 11:00:00")
tracecar4_e2$size<- tracecar4_e2$size*8
taxabps1segcar4_e2<-aggregate(list(size = tracecar4_e2$size), list(segundos = cut(tracecar4_e2$time, "1 sec")), sum)
taxabps1segcar4_e2ts<-ts(tracecar4_e2$size, frequency = 1)

tracecar5_e2<-read.table(file = 'car5tf_5004.txt', sep=' ')
names(tracecar5_e2)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar5_e2$time <- as.POSIXlt(tracecar5_e2$time, origin = "1987-10-05 11:00:00")
tracecar5_e2$size<- tracecar5_e2$size*8
taxabps1segcar5_e2<-aggregate(list(size = tracecar5_e2$size), list(segundos = cut(tracecar5_e2$time, "1 sec")), sum)
taxabps1segcar5_e2ts<-ts(tracecar5_e2$size, frequency = 1)

tracecar6_e2<-read.table(file = 'car6tf_5004.txt', sep=' ')
names(tracecar6_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar6_e2$time <- as.POSIXlt(tracecar6_e2$time, origin = "1987-10-05 11:00:00")
tracecar6_e2$size<- tracecar6_e2$size*8
taxabps1segcar6_e2<-aggregate(list(size = tracecar6_e2$size), list(segundos = cut(tracecar6_e2$time, "1 sec")), sum)
taxabps1segcar6_e2ts<-ts(tracecar6_e2$size, frequency = 1)

#Compute Delay Server E2

tracedelay_e20<-read.table(file = 'delay0_e2.txt')
delay_e20<-append(list(delay = tracedelay_e20$V1), list(time = c(1:length(tracedelay_e20$V1))))

tracedelay_e21<-read.table(file = 'delay1_e2.txt')
delay_e21<-append(list(delay = tracedelay_e21$V1), list(time = c(1:length(tracedelay_e21$V1))))

tracedelay_e22<-read.table(file = 'delay2_e2.txt')
delay_e22<-append(list(delay = tracedelay_e22$V1), list(time = c(1:length(tracedelay_e22$V1))))

tracedelay_e23<-read.table(file = 'delay3_e2.txt')
delay_e23<-append(list(delay = tracedelay_e23$V1), list(time = c(1:length(tracedelay_e23$V1))))

tracedelay_e24<-read.table(file = 'delay4_e2.txt')
delay_e24<-append(list(delay = tracedelay_e24$V1), list(time = c(1:length(tracedelay_e24$V1))))

tracedelay_e25<-read.table(file = 'delay5_e2.txt')
delay_e25<-append(list(delay = tracedelay_e25$V1), list(time = c(1:length(tracedelay_e25$V1))))

tracedelay_e26<-read.table(file = 'delay6_e2.txt')
delay_e26<-append(list(delay = tracedelay_e26$V1), list(time = c(1:length(tracedelay_e26$V1))))


#Plot Graphs Server E2

ctime_e2<-c(0:299)
#tt<-c(taxabps1segcar0_e2$size[1:195], taxabps1segcar1_e2$size[1:195], taxabps1segcar2_e2$size[1:195], taxabps1segcar3_e2$size[1:195], taxabps1segcar4_e2$size[1:195], taxabps1segcar5_e2$size[1:195], taxabps1segcar6_e2$size[1:195], taxabps1segcar7_e2$size[1:195], taxabps1segcar8_e2$size[1:195], taxabps1segcar9_e2$size[1:195], taxabps1segcar10_e2$size[1:195], taxabps1segcar11_e2$size[1:195], taxabps1segcar12_e2$size[1:195], taxabps1segcar13_e2$size[1:195], taxabps1segcar14_e2$size[1:195], taxabps1segcar15_e2$size[1:195], taxabps1segcar16_e2$size[1:195], taxabps1segcar17_e2$size[1:195], taxabps1segcar18_e2$size[1:195], taxabps1segcar19_e2$size[1:195])
cartotal_e2<-c(taxabps1segcar0_e2$size[1:300], taxabps1segcar1_e2$size[1:300], taxabps1segcar2_e2$size[1:300], taxabps1segcar3_e2$size[1:300], taxabps1segcar4_e2$size[1:300], taxabps1segcar5_e2$size[1:300], taxabps1segcar6_e2$size[1:300])
carmean_e2<-c(taxabps1segcar0_e2$size[1:300] + taxabps1segcar1_e2$size[1:300] + taxabps1segcar2_e2$size[1:300] + taxabps1segcar3_e2$size[1:300] + taxabps1segcar4_e2$size[1:300] + taxabps1segcar5_e2$size[1:300] + taxabps1segcar6_e2$size[1:300])/7
fctime_e2<-c(ctime, ctime, ctime, ctime, ctime, ctime, ctime)

stime_e2<-c(0:299)
#tt<-c(taxabps1segserver_e2_car0$size[1:195], taxabps1segserver_e2_car1$size[1:195], taxabps1segserver_e2_car2$size[1:195], taxabps1segserver_e2_car3$size[1:195], taxabps1segserver_e2_car4$size[1:195], taxabps1segserver_e2_car5$size[1:195], taxabps1segserver_e2_car6$size[1:195], taxabps1segserver_e2_car7$size[1:195], taxabps1segserver_e2_car8$size[1:195], taxabps1segserver_e2_car9$size[1:195], taxabps1segserver_e2_car10$size[1:195], taxabps1segserver_e2_car11$size[1:195], taxabps1segserver_e2_car12$size[1:195], taxabps1segserver_e2_car13$size[1:195], taxabps1segserver_e2_car14$size[1:195], taxabps1segserver_e2_car15$size[1:195], taxabps1segserver_e2_car16$size[1:195], taxabps1segserver_e2_car17$size[1:195], taxabps1segserver_e2_car18$size[1:195], taxabps1segserver_e2_car19$size[1:195])
servertotal_e2<-c(taxabps1segserver_e2_car0$size[1:300], taxabps1segserver_e2_car1$size[1:300], taxabps1segserver_e2_car2$size[1:300], taxabps1segserver_e2_car3$size[1:300], taxabps1segserver_e2_car4$size[1:300], taxabps1segserver_e2_car5$size[1:300], taxabps1segserver_e2_car6$size[1:300])
servermean_e2<-c(taxabps1segserver_e2_car0$size[1:300] + taxabps1segserver_e2_car1$size[1:300] + taxabps1segserver_e2_car2$size[1:300] + taxabps1segserver_e2_car3$size[1:300] + taxabps1segserver_e2_car4$size[1:300] + taxabps1segserver_e2_car5$size[1:300] + taxabps1segserver_e2_car6$size[1:300])/7
fstime_e2<-c(stime_e2, stime_e2, stime_e2, stime_e2, stime_e2, stime_e2, stime_e2)

dtime_e2<-c(0:299)
delaytotal_e2<-c(delay_e20$delay[1:300], delay_e21$delay[1:300], delay_e22$delay[1:300], delay_e23$delay[1:300], delay_e24$delay[1:300], delay_e25$delay[1:300], delay_e26$delay[1:300])
delaymean_e2<-c(delay_e20$delay[1:300] + delay_e21$delay[1:300] + delay_e22$delay[1:300] + delay_e23$delay[1:300] + delay_e24$delay[1:300] + delay_e25$delay[1:300] + delay_e26$delay[1:300])/7
fdtime_e2<-c(dtime_e2, dtime_e2, dtime_e2, dtime_e2, dtime_e2, dtime_e2, dtime_e2)

ptime_e2<-c(0:299)
PDRtotal_e2<- c(taxabps1segserver_e2_car0$size[1:300]/taxabps1segcar0_e2$size[1:300], taxabps1segserver_e2_car1$size[1:300]/taxabps1segcar1_e2$size[1:300], taxabps1segserver_e2_car2$size[1:300]/taxabps1segcar2_e2$size[1:300], taxabps1segserver_e2_car3$size[1:300]/taxabps1segcar3_e2$size[1:300], taxabps1segserver_e2_car4$size[1:300]/taxabps1segcar4_e2$size[1:300], taxabps1segserver_e2_car5$size[1:300]/taxabps1segcar5_e2$size[1:300], taxabps1segserver_e2_car6$size[1:300]/taxabps1segcar6_e2$size[1:300])
PDRmean_e2<-c(taxabps1segserver_e2_car0$size[1:300]/taxabps1segcar0_e2$size[1:300] + taxabps1segserver_e2_car1$size[1:300]/taxabps1segcar1_e2$size[1:300] + taxabps1segserver_e2_car2$size[1:300]/taxabps1segcar2_e2$size[1:300] + taxabps1segserver_e2_car3$size[1:300]/taxabps1segcar3_e2$size[1:300] + taxabps1segserver_e2_car4$size[1:300]/taxabps1segcar4_e2$size[1:300] + taxabps1segserver_e2_car5$size[1:300]/taxabps1segcar5_e2$size[1:300] + taxabps1segserver_e2_car6$size[1:300]/taxabps1segcar6_e2$size[1:300])/7
fptime_e2<-c(ptime_e2, ptime_e2, ptime_e2, ptime_e2, ptime_e2, ptime_e2, ptime_e2) 

require(Rmisc)
x1<- cbind(fctime_e2,cartotal_e2)
x1<-data.frame(x1)
y1<-group.CI(cartotal_e2~fctime_e2,x1,ci = 0.95)

x2<- cbind(fstime_e2,servertotal_e2)
x2<-data.frame(x2)
y2<-group.CI(servertotal_e2~fstime_e2,x2,ci = 0.95)

x3<- cbind(fdtime_e2,delaytotal_e2)
x3<-data.frame(x3)
y3<-group.CI(delaytotal_e2~fdtime_e2,x3,ci = 0.95)

x4<- cbind(fptime_e2,PDRtotal_e2)
x4<-data.frame(x4)
y4<-group.CI(PDRtotal_e2~fptime_e2,x4,ci = 0.95)

require(plotrix)

par(mar = c(5,5,2,5))

plotCI(ctime_e2, carmean_e2, ui=y1$cartotal_e2.upper, li=y1$cartotal_e2.lower, col="red", main="Server E2", ylab = "Throughput (bps)", xlab = "time(s)", ylim = range(0:1.5e+06) )
lines(ctime_e2,carmean_e2, type = "l", col="black", lwd="2")

par(new=T)
plotCI(stime_e2, servermean_e2, ui=y2$servertotal_e2.upper, li=y2$servertotal_e2.lower, col="blue", axes=F, xlab=NA, ylab=NA, ylim = range(0:1.5e+06) )
lines(stime_e2,servermean_e2, type = "l", col="black", lwd="2")

par(new = T)
plotCI(dtime_e2[2:300], delaymean_e2[2:300], ui=y3$delaytotal_e2.upper[2:300], li=y3$delaytotal_e2.lower[2:300], col="orange", axes=F, xlab=NA, ylab=NA, ylim = range(0:1000))
lines(dtime_e2[2:300],delaymean_e2[2:300], type = "l", col="black", lwd="2")
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft",
       legend=c("Server received", "Car Sent", "Delay"),
       lty=c(1,1,1), col=c("blue", "red", "orange"))

plotCI(ptime_e2, PDRmean_e2, ui=y4$PDRtotal_e2.upper, li=y4$PDRtotal_e2.lower, col="red", main="PDR E2", ylab = "PDR mean (%)", xlab = "time(s)")
lines(ptime_e2,PDRmean_e2, type = "l", col="black", lwd="2")


####Server S

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

ptime_s<-c(0:299)
PDRtotal_s<- c(taxabps1segserver_s_car0$size[1:300]/taxabps1segcar0_s$size[1:300], taxabps1segserver_s_car1$size[1:300]/taxabps1segcar1_s$size[1:300], taxabps1segserver_s_car2$size[1:300]/taxabps1segcar2_s$size[1:300], taxabps1segserver_s_car3$size[1:300]/taxabps1segcar3_s$size[1:300], taxabps1segserver_s_car4$size[1:300]/taxabps1segcar4_s$size[1:300], taxabps1segserver_s_car5$size[1:300]/taxabps1segcar5_s$size[1:300], taxabps1segserver_s_car6$size[1:300]/taxabps1segcar6_s$size[1:300])
PDRmean_s<-c(taxabps1segserver_s_car0$size[1:300]/taxabps1segcar0_s$size[1:300] + taxabps1segserver_s_car1$size[1:300]/taxabps1segcar1_s$size[1:300] + taxabps1segserver_s_car2$size[1:300]/taxabps1segcar2_s$size[1:300] + taxabps1segserver_s_car3$size[1:300]/taxabps1segcar3_s$size[1:300] + taxabps1segserver_s_car4$size[1:300]/taxabps1segcar4_s$size[1:300] + taxabps1segserver_s_car5$size[1:300]/taxabps1segcar5_s$size[1:300] + taxabps1segserver_s_car6$size[1:300]/taxabps1segcar6_s$size[1:300])/7
fptime_s<-c(ptime_s, ptime_s, ptime_s, ptime_s, ptime_s, ptime_s, ptime_s) 

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

x4<- cbind(fptime_s,PDRtotal_s)
x4<-data.frame(x4)
y4<-group.CI(PDRtotal_s~fptime_s,x4,ci = 0.95)

require(plotrix)

par(mar = c(5,5,2,5))

plotCI(ctime_s, carmean_s, ui=y1$cartotal_s.upper, li=y1$cartotal_s.lower, col="red", main="Server S", ylab = "Throughput (bps)", xlab = "time(s)", ylim = range(0:1e+06) )
lines(ctime_s,carmean_s, type = "l", col="black", lwd="2")

par(new=T)
plotCI(stime_s, servermean_s, ui=y2$servertotal_s.upper, li=y2$servertotal_s.lower, col="blue", axes=F, xlab=NA, ylab=NA, ylim = range(0:1e+06) )
lines(stime_s,servermean_s, type = "l", col="black", lwd="2")

par(new = T)
plotCI(dtime_s[2:300], delaymean_s[2:300], ui=y3$delaytotal_s.upper[2:300], li=y3$delaytotal_s.lower[2:300], col="orange", axes=F, xlab=NA, ylab=NA, ylim = range(0:1000))
lines(dtime_s[2:300],delaymean_s[2:300], type = "l", col="black", lwd="2")
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft",
       legend=c("Server received", "Car Sent", "Delay"),
       lty=c(1,1,1), col=c("blue", "red", "orange"))

plotCI(ptime_s, PDRmean_s, ui=y4$PDRtotal_s.upper, li=y4$PDRtotal_s.lower, col="red", main="PDR S", ylab = "PDR mean (%)", xlab = "time(s)")
lines(ptime_s,PDRmean_s, type = "l", col="black", lwd="2")
