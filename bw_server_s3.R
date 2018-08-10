traceserver_s3_car0<-read.table(file = 'server_s3tf_car0.txt', sep=' ')
names(traceserver_s3_car0)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_s3_car0$time <- as.POSIXlt(traceserver_s3_car0$time, origin = "1987-10-05 11:00:00")
traceserver_s3_car0$size<- traceserver_s3_car0$size*8
taxabps1segserver_s3_car0<-aggregate(list(size = traceserver_s3_car0$size), list(segundos = cut(traceserver_s3_car0$time, "1 sec")), sum)
taxabps1segserverts_s3_car0<-ts(traceserver_s3_car0$size, frequency = 1)

traceserver_s3_car1<-read.table(file = 'server_s3tf_car1.txt', sep=' ')
names(traceserver_s3_car1)<-c("time", "id", "size", "ori", "dest" )
traceserver_s3_car1$time <- as.POSIXlt(traceserver_s3_car1$time, origin = "1987-10-05 11:00:00")
traceserver_s3_car1$size<- traceserver_s3_car1$size*8
taxabps1segserver_s3_car1<-aggregate(list(size = traceserver_s3_car1$size), list(segundos = cut(traceserver_s3_car1$time, "1 sec")), sum)
taxabps1segserverts_s3_car1<-ts(traceserver_s3_car1$size, frequency = 1)

traceserver_s3_car2<-read.table(file = 'server_s3tf_car2.txt', sep=' ')
names(traceserver_s3_car2)<-c("time", "id", "size", "ori", "dest" )
traceserver_s3_car2$time <- as.POSIXlt(traceserver_s3_car2$time, origin = "1987-10-05 11:00:00")
traceserver_s3_car2$size<- traceserver_s3_car2$size*8
taxabps1segserver_s3_car2<-aggregate(list(size = traceserver_s3_car2$size), list(segundos = cut(traceserver_s3_car2$time, "1 sec")), sum)
taxabps1segserverts_s3_car2<-ts(traceserver_s3_car2$size, frequency = 1)

traceserver_s3_car3<-read.table(file = 'server_s3tf_car3.txt', sep=' ')
names(traceserver_s3_car3)<-c("time", "id", "size", "ori", "dest" )
traceserver_s3_car3$time <- as.POSIXlt(traceserver_s3_car3$time, origin = "1987-10-05 11:00:00")
traceserver_s3_car3$size<- traceserver_s3_car3$size*8
taxabps1segserver_s3_car3<-aggregate(list(size = traceserver_s3_car3$size), list(segundos = cut(traceserver_s3_car3$time, "1 sec")), sum)
taxabps1segserverts_s3_car3<-ts(traceserver_s3_car3$size, frequency = 1)
# 
# traceserver_s3_car4<-read.table(file = 'server_s3tf_car4.txt', sep=' ')
# names(traceserver_s3_car4)<-c("time", "id", "size", "ori", "dest" )
# traceserver_s3_car4$time <- as.POSIXlt(traceserver_s3_car4$time, origin = "1987-10-05 11:00:00")
# traceserver_s3_car4$size<- traceserver_s3_car4$size*8
# taxabps1segserver_s3_car4<-aggregate(list(size = traceserver_s3_car4$size), list(segundos = cut(traceserver_s3_car4$time, "1 sec")), sum)
# taxabps1segserverts_s3_car4<-ts(traceserver_s3_car4$size, frequency = 1)
# 
# traceserver_s3_car5<-read.table(file = 'server_s3tf_car5.txt', sep=' ')
# names(traceserver_s3_car5)<-c("time", "id", "size", "ori", "dest" )
# traceserver_s3_car5$time <- as.POSIXlt(traceserver_s3_car5$time, origin = "1987-10-05 11:00:00")
# traceserver_s3_car5$size<- traceserver_s3_car5$size*8
# taxabps1segserver_s3_car5<-aggregate(list(size = traceserver_s3_car5$size), list(segundos = cut(traceserver_s3_car5$time, "1 sec")), sum)
# taxabps1segserverts_s3_car5<-ts(traceserver_s3_car5$size, frequency = 1)

# traceserver_s3_car6<-read.table(file = 'server_s3tf_car6.txt', sep=' ')
# names(traceserver_s3_car6)<-c("time", "id", "size", "ori", "dest" )
# traceserver_s3_car6$time <- as.POSIXlt(traceserver_s3_car6$time, origin = "1987-10-05 11:00:00")
# traceserver_s3_car6$size<- traceserver_s3_car6$size*8
# taxabps1segserver_s3_car6<-aggregate(list(size = traceserver_s3_car6$size), list(segundos = cut(traceserver_s3_car6$time, "1 sec")), sum)
# taxabps1segserverts_s3_car6<-ts(traceserver_s3_car6$size, frequency = 1)

# plot(c(1:length(taxabps1segserver_s3_car0$size)), taxabps1segserver_s3_car0$size, main="Server S3", ylab='bits/s', xlab='time(s)', type = "l", col="blue")
# lines(c(1:length(taxabps1segserver_s3_car1$size)), taxabps1segserver_s3_car1$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s3_car2$segundos, taxabps1segserver_s3_car2$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s3_car3$segundos, taxabps1segserver_s3_car3$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s3_car4$segundos, taxabps1segserver_s3_car4$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s3_car5$segundos, taxabps1segserver_s3_car5$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_s3_car6$segundos, taxabps1segserver_s3_car6$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# legend(240, 2e+06, legend=c("Car transmission", "Server reception"), col=c("blue", "red"), lty=1:2, cex=0.8)

#trafego dos veiculos para server_s3

tracecar0_s3<-read.table(file = 'car0tf_5005.txt', sep=' ')
names(tracecar0_s3)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar0_s3$time <- as.POSIXlt(tracecar0_s3$time, origin = "1987-10-05 11:00:00")
tracecar0_s3$size<- tracecar0_s3$size*8
taxabps1segcar0_s3<-aggregate(list(size = tracecar0_s3$size), list(segundos = cut(tracecar0_s3$time, "1 sec")), sum)
taxabps1segcar0_s3ts<-ts(tracecar0_s3$size, frequency = 1)

tracecar1_s3<-read.table(file = 'car1tf_5005.txt', sep=' ')
names(tracecar1_s3)<-c("time", "id", "size", "ori", "dest" )
tracecar1_s3$time <- as.POSIXlt(tracecar1_s3$time, origin = "1987-10-05 11:00:00")
tracecar1_s3$size<- tracecar1_s3$size*8
taxabps1segcar1_s3<-aggregate(list(size = tracecar1_s3$size), list(segundos = cut(tracecar1_s3$time, "1 sec")), sum)
taxabps1segcar1_s3ts<-ts(tracecar1_s3$size, frequency = 1)

tracecar2_s3<-read.table(file = 'car2tf_5005.txt', sep=' ')
names(tracecar2_s3)<-c("time", "id", "size", "ori", "dest" )
tracecar2_s3$time <- as.POSIXlt(tracecar2_s3$time, origin = "1987-10-05 11:00:00")
tracecar2_s3$size<- tracecar2_s3$size*8
taxabps1segcar2_s3<-aggregate(list(size = tracecar2_s3$size), list(segundos = cut(tracecar2_s3$time, "1 sec")), sum)
taxabps1segcar2_s3ts<-ts(tracecar2_s3$size, frequency = 1)

tracecar3_s3<-read.table(file = 'car3tf_5005.txt', sep=' ')
names(tracecar3_s3)<-c("time", "id", "size", "ori", "dest" )
tracecar3_s3$time <- as.POSIXlt(tracecar3_s3$time, origin = "1987-10-05 11:00:00")
tracecar3_s3$size<- tracecar3_s3$size*8
taxabps1segcar3_s3<-aggregate(list(size = tracecar3_s3$size), list(segundos = cut(tracecar3_s3$time, "1 sec")), sum)
taxabps1segcar3_s3ts<-ts(tracecar3_s3$size, frequency = 1)
# 
# tracecar4_s3<-read.table(file = 'car4tf_5005.txt', sep=' ')
# names(tracecar4_s3)<-c("time", "id", "size", "ori", "dest" )
# tracecar4_s3$time <- as.POSIXlt(tracecar4_s3$time, origin = "1987-10-05 11:00:00")
# tracecar4_s3$size<- tracecar4_s3$size*8
# taxabps1segcar4_s3<-aggregate(list(size = tracecar4_s3$size), list(segundos = cut(tracecar4_s3$time, "1 sec")), sum)
# taxabps1segcar4_s3ts<-ts(tracecar4_s3$size, frequency = 1)
# 
# tracecar5_s3<-read.table(file = 'car5tf_5005.txt', sep=' ')
# names(tracecar5_s3)<-c("time", "id", "size", "ori", "dest" )
# options(digits.secs = 6)
# tracecar5_s3$time <- as.POSIXlt(tracecar5_s3$time, origin = "1987-10-05 11:00:00")
# tracecar5_s3$size<- tracecar5_s3$size*8
# taxabps1segcar5_s3<-aggregate(list(size = tracecar5_s3$size), list(segundos = cut(tracecar5_s3$time, "1 sec")), sum)
# taxabps1segcar5_s3ts<-ts(tracecar5_s3$size, frequency = 1)

# tracecar6_s3<-read.table(file = 'car6tf_5005.txt', sep=' ')
# names(tracecar6_s3)<-c("time", "id", "size", "ori", "dest" )
# tracecar6_s3$time <- as.POSIXlt(tracecar6_s3$time, origin = "1987-10-05 11:00:00")
# tracecar6_s3$size<- tracecar6_s3$size*8
# taxabps1segcar6_s3<-aggregate(list(size = tracecar6_s3$size), list(segundos = cut(tracecar6_s3$time, "1 sec")), sum)
# taxabps1segcar6_s3ts<-ts(tracecar6_s3$size, frequency = 1)

ttime<-c(0:194)
#tt<-c(taxabps1segcar0_s3$size[1:195], taxabps1segcar1_s3$size[1:195], taxabps1segcar2_s3$size[1:195], taxabps1segcar3_s3$size[1:195], taxabps1segcar4_s3$size[1:195], taxabps1segcar5_s3$size[1:195], taxabps1segcar6_s3$size[1:195], taxabps1segcar7_s3$size[1:195], taxabps1segcar8_s3$size[1:195], taxabps1segcar9_s3$size[1:195], taxabps1segcar10_s3$size[1:195], taxabps1segcar11_s3$size[1:195], taxabps1segcar12_s3$size[1:195], taxabps1segcar13_s3$size[1:195], taxabps1segcar14_s3$size[1:195], taxabps1segcar15_s3$size[1:195], taxabps1segcar16_s3$size[1:195], taxabps1segcar17_s3$size[1:195], taxabps1segcar18_s3$size[1:195], taxabps1segcar19_s3$size[1:195])
tt<-c(taxabps1segcar0_s3$size[1:195], taxabps1segcar1_s3$size[1:195], taxabps1segcar2_s3$size[1:195], taxabps1segcar3_s3$size[1:195])
ttm<-c(taxabps1segcar0_s3$size[1:195] + taxabps1segcar1_s3$size[1:195] + taxabps1segcar2_s3$size[1:195] + taxabps1segcar3_s3$size[1:195])/4
tttime<-c(ttime, ttime, ttime, ttime)

length(ttm)

length(ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="red", main="Server S3", ylab = "Taxa de entrega de pacotes - PDR", xlab = "tempo (s)")
lines(ttime,ttm, type = "l", col="black", lwd="2")

par(new=T)

ttime<-c(0:194)
#tt<-c(taxabps1segserver_s3_car0$size[1:195], taxabps1segserver_s3_car1$size[1:195], taxabps1segserver_s3_car2$size[1:195], taxabps1segserver_s3_car3$size[1:195], taxabps1segserver_s3_car4$size[1:195], taxabps1segserver_s3_car5$size[1:195], taxabps1segserver_s3_car6$size[1:195], taxabps1segserver_s3_car7$size[1:195], taxabps1segserver_s3_car8$size[1:195], taxabps1segserver_s3_car9$size[1:195], taxabps1segserver_s3_car10$size[1:195], taxabps1segserver_s3_car11$size[1:195], taxabps1segserver_s3_car12$size[1:195], taxabps1segserver_s3_car13$size[1:195], taxabps1segserver_s3_car14$size[1:195], taxabps1segserver_s3_car15$size[1:195], taxabps1segserver_s3_car16$size[1:195], taxabps1segserver_s3_car17$size[1:195], taxabps1segserver_s3_car18$size[1:195], taxabps1segserver_s3_car19$size[1:195])
tt<-c(taxabps1segserver_s3_car0$size[1:195], taxabps1segserver_s3_car1$size[1:195], taxabps1segserver_s3_car2$size[1:195], taxabps1segserver_s3_car3$size[1:195])
ttm<-c(taxabps1segserver_s3_car0$size[1:195] + taxabps1segserver_s3_car1$size[1:195] + taxabps1segserver_s3_car2$size[1:195] + taxabps1segserver_s3_car3$size[1:195])/4
tttime<-c(ttime, ttime, ttime, ttime)

length(ttm)

length(ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="blue", main="Server S3", axes = FALSE)
lines(ttime,ttm, type = "l", col="black", lwd="2")
