tracedelayse0<-read.table(file = 'delay0_se.txt')
delayse0<-append(list(delay = tracedelayse0$V1), list(time = c(1:length(tracedelayse0$V1))))

tracedelayse1<-read.table(file = 'delay1_se.txt')
delayse1<-append(list(delay = tracedelayse1$V1), list(time = c(1:length(tracedelayse1$V1))))

tracedelayse2<-read.table(file = 'delay2_se.txt')
delayse2<-append(list(delay = tracedelayse2$V1), list(time = c(1:length(tracedelayse2$V1))))

tracedelayse3<-read.table(file = 'delay3_se.txt')
delayse3<-append(list(delay = tracedelayse3$V1), list(time = c(1:length(tracedelayse3$V1))))

tracedelayse4<-read.table(file = 'delay4_se.txt')
delayse4<-append(list(delay = tracedelayse4$V1), list(time = c(1:length(tracedelayse4$V1))))

tracedelayse5<-read.table(file = 'delay5_se.txt')
delayse5<-append(list(delay = tracedelayse5$V1), list(time = c(1:length(tracedelayse5$V1))))

tracedelayse6<-read.table(file = 'delay6_se.txt')
delayse6<-append(list(delay = tracedelayse6$V1), list(time = c(1:length(tracedelayse6$V1))))

with(d, plot(x, logp, type="l", col="red3", 
             ylab=expression(-log[10](italic(p))),
             ylim=c(0,3)))


ttime<-c(0:200)
tt<-c(delayse0$delay[1:201], delayse1$delay[1:201], delayse2$delay[1:201], delayse3$delay[1:201], delayse4$delay[1:201], delayse5$delay[1:201], delayse6$delay[1:201])
ttm<-c(delayse0$delay[1:201] + delayse1$delay[1:201] + delayse2$delay[1:201] + delayse3$delay[1:201] + delayse4$delay[1:201] + delayse5$delay[1:201] + delayse6$delay[1:201])/7
tttime<-c(ttime, ttime, ttime, ttime, ttime, ttime, ttime)

length(ttm)

length(ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="blue", main="Server S", ylab = "Taxa de entrega de pacotes - PDR", xlab = "tempo (s)", ylim = range(0:60) )
lines(ttime[2:201],ttm[2:201], type = "l", col="black", lwd="2")


















plot(delayse0$time, delayse0$delay, type = "l", main="Delay per second", ylab='ms', xlab='time(s)', col="blue")
#lines(delay$time[1:100], delay$delay[1:100], type = "l", main="Delay per second", ylab='ms', xlab='time(s)', col="red")
