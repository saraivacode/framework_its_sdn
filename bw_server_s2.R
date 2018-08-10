traceserver_s2_car7<-read.table(file = 'server_s2tf_car7.txt', sep=' ')
names(traceserver_s2_car7)<-c("time", "id", "size", "ori", "dest" )
traceserver_s2_car7$time <- as.POSIXlt(traceserver_s2_car7$time, origin = "1987-10-05 11:00:00")
traceserver_s2_car7$size<- traceserver_s2_car7$size*8
taxabps1segserver_s2_car7<-aggregate(list(size = traceserver_s2_car7$size), list(segundos = cut(traceserver_s2_car7$time, "1 sec")), sum)
taxabps1segserverts_s2_car7<-ts(traceserver_s2_car7$size, frequency = 1)

traceserver_s2_car8<-read.table(file = 'server_s2tf_car8.txt', sep=' ')
names(traceserver_s2_car8)<-c("time", "id", "size", "ori", "dest" )
traceserver_s2_car8$time <- as.POSIXlt(traceserver_s2_car8$time, origin = "1987-10-05 11:00:00")
traceserver_s2_car8$size<- traceserver_s2_car8$size*8
taxabps1segserver_s2_car8<-aggregate(list(size = traceserver_s2_car8$size), list(segundos = cut(traceserver_s2_car8$time, "1 sec")), sum)
taxabps1segserverts_s2_car8<-ts(traceserver_s2_car8$size, frequency = 1)

traceserver_s2_car9<-read.table(file = 'server_s2tf_car9.txt', sep=' ')
names(traceserver_s2_car9)<-c("time", "id", "size", "ori", "dest" )
traceserver_s2_car9$time <- as.POSIXlt(traceserver_s2_car9$time, origin = "1987-10-05 11:00:00")
traceserver_s2_car9$size<- traceserver_s2_car9$size*8
taxabps1segserver_s2_car9<-aggregate(list(size = traceserver_s2_car9$size), list(segundos = cut(traceserver_s2_car9$time, "1 sec")), sum)
taxabps1segserverts_s2_car9<-ts(traceserver_s2_car9$size, frequency = 1)

traceserver_s2_car10<-read.table(file = 'server_s2tf_car10.txt', sep=' ')
names(traceserver_s2_car10)<-c("time", "id", "size", "ori", "dest" )
traceserver_s2_car10$time <- as.POSIXlt(traceserver_s2_car10$time, origin = "1987-10-05 11:00:00")
traceserver_s2_car10$size<- traceserver_s2_car10$size*8
taxabps1segserver_s2_car10<-aggregate(list(size = traceserver_s2_car10$size), list(segundos = cut(traceserver_s2_car10$time, "1 sec")), sum)
taxabps1segserverts_s2_car10<-ts(traceserver_s2_car10$size, frequency = 1)

traceserver_s2_car11<-read.table(file = 'server_s2tf_car11.txt', sep=' ')
names(traceserver_s2_car11)<-c("time", "id", "size", "ori", "dest" )
traceserver_s2_car11$time <- as.POSIXlt(traceserver_s2_car11$time, origin = "1987-10-05 11:00:00")
traceserver_s2_car11$size<- traceserver_s2_car11$size*8
taxabps1segserver_s2_car11<-aggregate(list(size = traceserver_s2_car11$size), list(segundos = cut(traceserver_s2_car11$time, "1 sec")), sum)
taxabps1segserverts_s2_car11<-ts(traceserver_s2_car11$size, frequency = 1)

# traceserver_s2_car12<-read.table(file = 'server_s2tf_car12.txt', sep=' ')
# names(traceserver_s2_car12)<-c("time", "id", "size", "ori", "dest" )
# traceserver_s2_car12$time <- as.POSIXlt(traceserver_s2_car12$time, origin = "1987-10-05 11:00:00")
# traceserver_s2_car12$size<- traceserver_s2_car12$size*8
# taxabps1segserver_s2_car12<-aggregate(list(size = traceserver_s2_car12$size), list(segundos = cut(traceserver_s2_car12$time, "1 sec")), sum)
# taxabps1segserverts_s2_car12<-ts(traceserver_s2_car12$size, frequency = 1)

# plot(c(1:length(taxabps1segserver_s2_car7$size)), taxabps1segserver_s2_car7$size, main="Server S2", ylab='bits/s', xlab='time(s)', type = "l", col="blue")
# lines(taxabps1segserver_s2_car8$segundos, taxabps1segserver_s2_car8$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s2_car9$segundos, taxabps1segserver_s2_car9$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s2_car10$segundos, taxabps1segserver_s2_car10$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_s2_car11$segundos, taxabps1segserver_s2_car11$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_s2_car12$segudos, taxabps1segserver_s2_car12$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# legend(240, 2e+06, legend=c("Car transmission", "Server reception"), col=c("blue", "red"), lty=1:2, cex=0.8)

#trafego dos veiculos para server_s2

tracecar7_s2<-read.table(file = 'car7tf_5002.txt', sep=' ')
names(tracecar7_s2)<-c("time", "id", "size", "ori", "dest" )
tracecar7_s2$time <- as.POSIXlt(tracecar7_s2$time, origin = "1987-10-05 11:00:00")
tracecar7_s2$size<- tracecar7_s2$size*8
taxabps1segcar7_s2<-aggregate(list(size = tracecar7_s2$size), list(segundos = cut(tracecar7_s2$time, "1 sec")), sum)
taxabps1segcar7_s2ts<-ts(tracecar7_s2$size, frequency = 1)

tracecar8_s2<-read.table(file = 'car8tf_5002.txt', sep=' ')
names(tracecar8_s2)<-c("time", "id", "size", "ori", "dest" )
tracecar8_s2$time <- as.POSIXlt(tracecar8_s2$time, origin = "1987-10-05 11:00:00")
tracecar8_s2$size<- tracecar8_s2$size*8
taxabps1segcar8_s2<-aggregate(list(size = tracecar8_s2$size), list(segundos = cut(tracecar8_s2$time, "1 sec")), sum)
taxabps1segcar8_s2ts<-ts(tracecar8_s2$size, frequency = 1)

tracecar9_s2<-read.table(file = 'car9tf_5002.txt', sep=' ')
names(tracecar9_s2)<-c("time", "id", "size", "ori", "dest" )
tracecar9_s2$time <- as.POSIXlt(tracecar9_s2$time, origin = "1987-10-05 11:00:00")
tracecar9_s2$size<- tracecar9_s2$size*8
taxabps1segcar9_s2<-aggregate(list(size = tracecar9_s2$size), list(segundos = cut(tracecar9_s2$time, "1 sec")), sum)
taxabps1segcar9_s2ts<-ts(tracecar9_s2$size, frequency = 1)

tracecar10_s2<-read.table(file = 'car10tf_5002.txt', sep=' ')
names(tracecar10_s2)<-c("time", "id", "size", "ori", "dest" )
tracecar10_s2$time <- as.POSIXlt(tracecar10_s2$time, origin = "1987-10-05 11:00:00")
tracecar10_s2$size<- tracecar10_s2$size*8
taxabps1segcar10_s2<-aggregate(list(size = tracecar10_s2$size), list(segundos = cut(tracecar10_s2$time, "1 sec")), sum)
taxabps1segcar10_s2ts<-ts(tracecar10_s2$size, frequency = 1)

tracecar11_s2<-read.table(file = 'car11tf_5002.txt', sep=' ')
names(tracecar11_s2)<-c("time", "id", "size", "ori", "dest" )
tracecar11_s2$time <- as.POSIXlt(tracecar11_s2$time, origin = "1987-10-05 11:00:00")
tracecar11_s2$size<- tracecar11_s2$size*8
taxabps1segcar11_s2<-aggregate(list(size = tracecar11_s2$size), list(segundos = cut(tracecar11_s2$time, "1 sec")), sum)
taxabps1segcar11_s2ts<-ts(tracecar11_s2$size, frequency = 1)

# tracecar12_s2<-read.table(file = 'car12tf_5002.txt', sep=' ')
# names(tracecar12_s2)<-c("time", "id", "size", "ori", "dest" )
# tracecar12_s2$time <- as.POSIXlt(tracecar12_s2$time, origin = "1987-10-05 11:00:00")
# tracecar12_s2$size<- tracecar12_s2$size*8
# taxabps1segcar12_s2<-aggregate(list(size = tracecar12_s2$size), list(segundos = cut(tracecar12_s2$time, "1 sec")), sum)
# taxabps1segcar12_s2ts<-ts(tracecar12_s2$size, frequency = 1)

ttime<-c(0:139)
#tt<-c(taxabps1segcar0_s2$size[1:140], taxabps1segcar1_s2$size[1:140], taxabps1segcar2_s2$size[1:140], taxabps1segcar3_s2$size[1:140], taxabps1segcar4_s2$size[1:140], taxabps1segcar5_s2$size[1:140], taxabps1segcar6_s2$size[1:140], taxabps1segcar7_s2$size[1:140], taxabps1segcar8_s2$size[1:140], taxabps1segcar9_s2$size[1:140], taxabps1segcar10_s2$size[1:140], taxabps1segcar11_s2$size[1:140], taxabps1segcar12_s2$size[1:140], taxabps1segcar13_s2$size[1:140], taxabps1segcar14_s2$size[1:140], taxabps1segcar15_s2$size[1:140], taxabps1segcar16_s2$size[1:140], taxabps1segcar17_s2$size[1:140], taxabps1segcar18_s2$size[1:140], taxabps1segcar19_s2$size[1:140])
tt<-c(taxabps1segcar7_s2$size[1:140], taxabps1segcar8_s2$size[1:140], taxabps1segcar9_s2$size[1:140], taxabps1segcar10_s2$size[1:140], taxabps1segcar11_s2$size[1:140])
ttm<-c(taxabps1segcar7_s2$size[1:140] + taxabps1segcar8_s2$size[1:140] + taxabps1segcar9_s2$size[1:140] + taxabps1segcar10_s2$size[1:140] + taxabps1segcar11_s2$size[1:140])/5
tttime<-c(ttime, ttime, ttime, ttime, ttime)

length(ttm)

length(ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="red", main="Server S2", ylab = "Taxa de entrega de pacotes - PDR", xlab = "tempo (s)")
lines(ttime,ttm, type = "l", col="black", lwd="2")

par(new=T)

ttime<-c(0:139)
#tt<-c(taxabps1segserver_s2_car0$size[1:140], taxabps1segserver_s2_car1$size[1:140], taxabps1segserver_s2_car2$size[1:140], taxabps1segserver_s2_car3$size[1:140], taxabps1segserver_s2_car4$size[1:140], taxabps1segserver_s2_car5$size[1:140], taxabps1segserver_s2_car6$size[1:140], taxabps1segserver_s2_car7$size[1:140], taxabps1segserver_s2_car8$size[1:140], taxabps1segserver_s2_car9$size[1:140], taxabps1segserver_s2_car10$size[1:140], taxabps1segserver_s2_car11$size[1:140], taxabps1segserver_s2_car12$size[1:140], taxabps1segserver_s2_car13$size[1:140], taxabps1segserver_s2_car14$size[1:140], taxabps1segserver_s2_car15$size[1:140], taxabps1segserver_s2_car16$size[1:140], taxabps1segserver_s2_car17$size[1:140], taxabps1segserver_s2_car18$size[1:140], taxabps1segserver_s2_car19$size[1:140])
tt<-c(taxabps1segserver_s2_car7$size[1:140], taxabps1segserver_s2_car8$size[1:140], taxabps1segserver_s2_car9$size[1:140], taxabps1segserver_s2_car10$size[1:140], taxabps1segserver_s2_car11$size[1:140])
ttm<-c(taxabps1segserver_s2_car7$size[1:140] + taxabps1segserver_s2_car8$size[1:140] + taxabps1segserver_s2_car9$size[1:140] + taxabps1segserver_s2_car10$size[1:140] + taxabps1segserver_s2_car11$size[1:140])/5
tttime<-c(ttime, ttime, ttime, ttime, ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="blue", main="Server S2", axes = FALSE)
lines(ttime,ttm, type = "l", col="black", lwd="2")