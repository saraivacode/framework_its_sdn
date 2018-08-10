traceserver_s1_car13<-read.table(file = 'server_s1tf_car13.txt', sep=' ')
names(traceserver_s1_car13)<-c("time", "id", "size", "ori", "dest" )
traceserver_s1_car13$time <- as.POSIXlt(traceserver_s1_car13$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car13$size<- traceserver_s1_car13$size*8
taxabps1segserver_s1_car13<-aggregate(list(size = traceserver_s1_car13$size), list(segundos = cut(traceserver_s1_car13$time, "1 sec")), sum)
taxabps1segserverts_s1_car13<-ts(traceserver_s1_car13$size, frequency = 1)

traceserver_s1_car14<-read.table(file = 'server_s1tf_car14.txt', sep=' ')
names(traceserver_s1_car14)<-c("time", "id", "size", "ori", "dest" )
traceserver_s1_car14$time <- as.POSIXlt(traceserver_s1_car14$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car14$size<- traceserver_s1_car14$size*8
taxabps1segserver_s1_car14<-aggregate(list(size = traceserver_s1_car14$size), list(segundos = cut(traceserver_s1_car14$time, "1 sec")), sum)
taxabps1segserverts_s1_car14<-ts(traceserver_s1_car14$size, frequency = 1)

traceserver_s1_car15<-read.table(file = 'server_s1tf_car15.txt', sep=' ')
names(traceserver_s1_car15)<-c("time", "id", "size", "ori", "dest" )
traceserver_s1_car15$time <- as.POSIXlt(traceserver_s1_car15$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car15$size<- traceserver_s1_car15$size*8
taxabps1segserver_s1_car15<-aggregate(list(size = traceserver_s1_car15$size), list(segundos = cut(traceserver_s1_car15$time, "1 sec")), sum)
taxabps1segserverts_s1_car15<-ts(traceserver_s1_car15$size, frequency = 1)

traceserver_s1_car16<-read.table(file = 'server_s1tf_car16.txt', sep=' ')
names(traceserver_s1_car16)<-c("time", "id", "size", "ori", "dest" )
traceserver_s1_car16$time <- as.POSIXlt(traceserver_s1_car16$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car16$size<- traceserver_s1_car16$size*8
taxabps1segserver_s1_car16<-aggregate(list(size = traceserver_s1_car16$size), list(segundos = cut(traceserver_s1_car16$time, "1 sec")), sum)
taxabps1segserverts_s1_car16<-ts(traceserver_s1_car16$size, frequency = 1)

traceserver_s1_car17<-read.table(file = 'server_s1tf_car17.txt', sep=' ')
names(traceserver_s1_car17)<-c("time", "id", "size", "ori", "dest" )
traceserver_s1_car17$time <- as.POSIXlt(traceserver_s1_car17$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car17$size<- traceserver_s1_car17$size*8
taxabps1segserver_s1_car17<-aggregate(list(size = traceserver_s1_car17$size), list(segundos = cut(traceserver_s1_car17$time, "1 sec")), sum)
taxabps1segserverts_s1_car17<-ts(traceserver_s1_car17$size, frequency = 1)

traceserver_s1_car18<-read.table(file = 'server_s1tf_car18.txt', sep=' ')
names(traceserver_s1_car18)<-c("time", "id", "size", "ori", "dest" )
traceserver_s1_car18$time <- as.POSIXlt(traceserver_s1_car18$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car18$size<- traceserver_s1_car18$size*8
taxabps1segserver_s1_car18<-aggregate(list(size = traceserver_s1_car18$size), list(segundos = cut(traceserver_s1_car18$time, "1 sec")), sum)
taxabps1segserverts_s1_car18<-ts(traceserver_s1_car18$size, frequency = 1)

traceserver_s1_car19<-read.table(file = 'server_s1tf_car19.txt', sep=' ')
names(traceserver_s1_car19)<-c("time", "id", "size", "ori", "dest" )
traceserver_s1_car19$time <- as.POSIXlt(traceserver_s1_car19$time, origin = "1987-10-05 11:00:00")
traceserver_s1_car19$size<- traceserver_s1_car19$size*8
taxabps1segserver_s1_car19<-aggregate(list(size = traceserver_s1_car19$size), list(segundos = cut(traceserver_s1_car19$time, "1 sec")), sum)
taxabps1segserverts_s1_car19<-ts(traceserver_s1_car19$size, frequency = 1)

# plot(c(1:length(taxabps1segserver_s1_car13$size)), taxabps1segserver_s1_car13$size, main="Server S1", ylab='bits/s', xlab='time(s)', type = "l", col="blue")
# lines(taxabps1segserver_s1_car14$segundos, taxabps1segserver_s1_car14$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s1_car15$segundos, taxabps1segserver_s1_car15$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s1_car16$segundos, taxabps1segserver_s1_car16$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s1_car17$segundos, taxabps1segserver_s1_car17$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s1_car18$segundos, taxabps1segserver_s1_car18$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s1_car19$segundos, taxabps1segserver_s1_car19$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# legend(240, 2e+06, legend=c("Car transmission", "Server reception"), col=c("blue", "red"), lty=1:2, cex=0.8)


#trafego dos veiculos para server_s1

tracecar13_s1<-read.table(file = 'car13tf_5002.txt', sep=' ')
names(tracecar13_s1)<-c("time", "id", "size", "ori", "dest" )
tracecar13_s1$time <- as.POSIXlt(tracecar13_s1$time, origin = "1987-10-05 11:00:00")
tracecar13_s1$size<- tracecar13_s1$size*8
taxabps1segcar13_s1<-aggregate(list(size = tracecar13_s1$size), list(segundos = cut(tracecar13_s1$time, "1 sec")), sum)
taxabps1segcar13_s1ts<-ts(tracecar13_s1$size, frequency = 1)

tracecar14_s1<-read.table(file = 'car14tf_5002.txt', sep=' ')
names(tracecar14_s1)<-c("time", "id", "size", "ori", "dest" )
tracecar14_s1$time <- as.POSIXlt(tracecar14_s1$time, origin = "1987-10-05 11:00:00")
tracecar14_s1$size<- tracecar14_s1$size*8
taxabps1segcar14_s1<-aggregate(list(size = tracecar14_s1$size), list(segundos = cut(tracecar14_s1$time, "1 sec")), sum)
taxabps1segcar14_s1ts<-ts(tracecar14_s1$size, frequency = 1)

tracecar15_s1<-read.table(file = 'car15tf_5002.txt', sep=' ')
names(tracecar15_s1)<-c("time", "id", "size", "ori", "dest" )
tracecar15_s1$time <- as.POSIXlt(tracecar15_s1$time, origin = "1987-10-05 11:00:00")
tracecar15_s1$size<- tracecar15_s1$size*8
taxabps1segcar15_s1<-aggregate(list(size = tracecar15_s1$size), list(segundos = cut(tracecar15_s1$time, "1 sec")), sum)
taxabps1segcar15_s1ts<-ts(tracecar15_s1$size, frequency = 1)

tracecar16_s1<-read.table(file = 'car16tf_5002.txt', sep=' ')
names(tracecar16_s1)<-c("time", "id", "size", "ori", "dest" )
tracecar16_s1$time <- as.POSIXlt(tracecar16_s1$time, origin = "1987-10-05 11:00:00")
tracecar16_s1$size<- tracecar16_s1$size*8
taxabps1segcar16_s1<-aggregate(list(size = tracecar16_s1$size), list(segundos = cut(tracecar16_s1$time, "1 sec")), sum)
taxabps1segcar16_s1ts<-ts(tracecar16_s1$size, frequency = 1)

tracecar17_s1<-read.table(file = 'car17tf_5002.txt', sep=' ')
names(tracecar17_s1)<-c("time", "id", "size", "ori", "dest" )
tracecar17_s1$time <- as.POSIXlt(tracecar17_s1$time, origin = "1987-10-05 11:00:00")
tracecar17_s1$size<- tracecar17_s1$size*8
taxabps1segcar17_s1<-aggregate(list(size = tracecar17_s1$size), list(segundos = cut(tracecar17_s1$time, "1 sec")), sum)
taxabps1segcar17_s1ts<-ts(tracecar17_s1$size, frequency = 1)

tracecar18_s1<-read.table(file = 'car18tf_5002.txt', sep=' ')
names(tracecar18_s1)<-c("time", "id", "size", "ori", "dest" )
tracecar18_s1$time <- as.POSIXlt(tracecar18_s1$time, origin = "1987-10-05 11:00:00")
tracecar18_s1$size<- tracecar18_s1$size*8
taxabps1segcar18_s1<-aggregate(list(size = tracecar18_s1$size), list(segundos = cut(tracecar18_s1$time, "1 sec")), sum)
taxabps1segcar18_s1ts<-ts(tracecar18_s1$size, frequency = 1)

tracecar19_s1<-read.table(file = 'car19tf_5002.txt', sep=' ')
names(tracecar19_s1)<-c("time", "id", "size", "ori", "dest" )
tracecar19_s1$time <- as.POSIXlt(tracecar19_s1$time, origin = "1987-10-05 11:00:00")
tracecar19_s1$size<- tracecar19_s1$size*8
taxabps1segcar19_s1<-aggregate(list(size = tracecar19_s1$size), list(segundos = cut(tracecar19_s1$time, "1 sec")), sum)
taxabps1segcar19_s1ts<-ts(tracecar19_s1$size, frequency = 1)


ttime<-c(0:139)
#tt<-c(taxabps1segcar0_s1$size[1:140], taxabps1segcar1_s1$size[1:140], taxabps1segcar2_s1$size[1:140], taxabps1segcar3_s1$size[1:140], taxabps1segcar4_s1$size[1:140], taxabps1segcar5_s1$size[1:140], taxabps1segcar6_s1$size[1:140], taxabps1segcar7_s1$size[1:140], taxabps1segcar8_s1$size[1:140], taxabps1segcar9_s1$size[1:140], taxabps1segcar10_s1$size[1:140], taxabps1segcar11_s1$size[1:140], taxabps1segcar12_s1$size[1:140], taxabps1segcar13_s1$size[1:140], taxabps1segcar14_s1$size[1:140], taxabps1segcar15_s1$size[1:140], taxabps1segcar16_s1$size[1:140], taxabps1segcar17_s1$size[1:140], taxabps1segcar18_s1$size[1:140], taxabps1segcar19_s1$size[1:140])
tt<-c(taxabps1segcar13_s1$size[1:140], taxabps1segcar14_s1$size[1:140], taxabps1segcar15_s1$size[1:140], taxabps1segcar16_s1$size[1:140], taxabps1segcar17_s1$size[1:140], taxabps1segcar18_s1$size[1:140], taxabps1segcar19_s1$size[1:140])
ttm<-c(taxabps1segcar13_s1$size[1:140] + taxabps1segcar14_s1$size[1:140] + taxabps1segcar15_s1$size[1:140] + taxabps1segcar16_s1$size[1:140] + taxabps1segcar17_s1$size[1:140] + taxabps1segcar18_s1$size[1:140] + taxabps1segcar19_s1$size[1:140])/7
tttime<-c(ttime, ttime, ttime, ttime, ttime, ttime, ttime)

length(ttm)

length(ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="red", main="Server S1", ylab = "Taxa de entrega de pacotes - PDR", xlab = "tempo (s)")
lines(ttime,ttm, type = "l", col="black", lwd="2")

par(new=T)

ttime<-c(0:139)
#tt<-c(taxabps1segserver_s1_car0$size[1:140], taxabps1segserver_s1_car1$size[1:140], taxabps1segserver_s1_car2$size[1:140], taxabps1segserver_s1_car3$size[1:140], taxabps1segserver_s1_car4$size[1:140], taxabps1segserver_s1_car5$size[1:140], taxabps1segserver_s1_car6$size[1:140], taxabps1segserver_s1_car7$size[1:140], taxabps1segserver_s1_car8$size[1:140], taxabps1segserver_s1_car9$size[1:140], taxabps1segserver_s1_car10$size[1:140], taxabps1segserver_s1_car11$size[1:140], taxabps1segserver_s1_car12$size[1:140], taxabps1segserver_s1_car13$size[1:140], taxabps1segserver_s1_car14$size[1:140], taxabps1segserver_s1_car15$size[1:140], taxabps1segserver_s1_car16$size[1:140], taxabps1segserver_s1_car17$size[1:140], taxabps1segserver_s1_car18$size[1:140], taxabps1segserver_s1_car19$size[1:140])
tt<-c(taxabps1segserver_s1_car13$size[1:140], taxabps1segserver_s1_car14$size[1:140], taxabps1segserver_s1_car15$size[1:140], taxabps1segserver_s1_car16$size[1:140], taxabps1segserver_s1_car17$size[1:140], taxabps1segserver_s1_car18$size[1:140], taxabps1segserver_s1_car19$size[1:140])
ttm<-c(taxabps1segserver_s1_car13$size[1:140] + taxabps1segserver_s1_car14$size[1:140] + taxabps1segserver_s1_car15$size[1:140] + taxabps1segserver_s1_car16$size[1:140] + taxabps1segserver_s1_car17$size[1:140] + taxabps1segserver_s1_car18$size[1:140] + taxabps1segserver_s1_car19$size[1:140])/7
tttime<-c(ttime, ttime, ttime, ttime, ttime, ttime, ttime)

length(ttm)

length(ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="blue", main="Server S1", axes = FALSE)
lines(ttime,ttm, type = "l", col="black", lwd="2")
