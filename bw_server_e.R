traceserver_e_car0<-read.table(file = 'server_etf_car0.txt', sep=' ')
names(traceserver_e_car0)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_e_car0$time <- as.POSIXlt(traceserver_e_car0$time, origin = "1987-10-05 11:00:00")
traceserver_e_car0$size<- traceserver_e_car0$size*8
taxabps1segserver_e_car0<-aggregate(list(size = traceserver_e_car0$size), list(segundos = cut(traceserver_e_car0$time, "1 sec")), sum)
taxabps1segserverts_e_car0<-ts(traceserver_e_car0$size, frequency = 1)

traceserver_e_car1<-read.table(file = 'server_etf_car1.txt', sep=' ')
names(traceserver_e_car1)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car1$time <- as.POSIXlt(traceserver_e_car1$time, origin = "1987-10-05 11:00:00")
traceserver_e_car1$size<- traceserver_e_car1$size*8
taxabps1segserver_e_car1<-aggregate(list(size = traceserver_e_car1$size), list(segundos = cut(traceserver_e_car1$time, "1 sec")), sum)
taxabps1segserverts_e_car1<-ts(traceserver_e_car1$size, frequency = 1)

traceserver_e_car2<-read.table(file = 'server_etf_car2.txt', sep=' ')
names(traceserver_e_car2)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car2$time <- as.POSIXlt(traceserver_e_car2$time, origin = "1987-10-05 11:00:00")
traceserver_e_car2$size<- traceserver_e_car2$size*8
taxabps1segserver_e_car2<-aggregate(list(size = traceserver_e_car2$size), list(segundos = cut(traceserver_e_car2$time, "1 sec")), sum)
taxabps1segserverts_e_car2<-ts(traceserver_e_car2$size, frequency = 1)

traceserver_e_car3<-read.table(file = 'server_etf_car3.txt', sep=' ')
names(traceserver_e_car3)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car3$time <- as.POSIXlt(traceserver_e_car3$time, origin = "1987-10-05 11:00:00")
traceserver_e_car3$size<- traceserver_e_car3$size*8
taxabps1segserver_e_car3<-aggregate(list(size = traceserver_e_car3$size), list(segundos = cut(traceserver_e_car3$time, "1 sec")), sum)
taxabps1segserverts_e_car3<-ts(traceserver_e_car3$size, frequency = 1)

traceserver_e_car4<-read.table(file = 'server_etf_car4.txt', sep=' ')
names(traceserver_e_car4)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car4$time <- as.POSIXlt(traceserver_e_car4$time, origin = "1987-10-05 11:00:00")
traceserver_e_car4$size<- traceserver_e_car4$size*8
taxabps1segserver_e_car4<-aggregate(list(size = traceserver_e_car4$size), list(segundos = cut(traceserver_e_car4$time, "1 sec")), sum)
taxabps1segserverts_e_car4<-ts(traceserver_e_car4$size, frequency = 1)

traceserver_e_car5<-read.table(file = 'server_etf_car5.txt', sep=' ')
names(traceserver_e_car5)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car5$time <- as.POSIXlt(traceserver_e_car5$time, origin = "1987-10-05 11:00:00")
traceserver_e_car5$size<- traceserver_e_car5$size*8
taxabps1segserver_e_car5<-aggregate(list(size = traceserver_e_car5$size), list(segundos = cut(traceserver_e_car5$time, "1 sec")), sum)
taxabps1segserverts_e_car5<-ts(traceserver_e_car5$size, frequency = 1)

traceserver_e_car6<-read.table(file = 'server_etf_car6.txt', sep=' ')
names(traceserver_e_car6)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_car6$time <- as.POSIXlt(traceserver_e_car6$time, origin = "1987-10-05 11:00:00")
traceserver_e_car6$size<- traceserver_e_car6$size*8
taxabps1segserver_e_car6<-aggregate(list(size = traceserver_e_car6$size), list(segundos = cut(traceserver_e_car6$time, "1 sec")), sum)
taxabps1segserverts_e_car6<-ts(traceserver_e_car6$size, frequency = 1)

# traceserver_e_car7<-read.table(file = 'server_etf_car7.txt', sep=' ')
# names(traceserver_e_car7)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car7$time <- as.POSIXlt(traceserver_e_car7$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car7$size<- traceserver_e_car7$size*8
# taxabps1segserver_e_car7<-aggregate(list(size = traceserver_e_car7$size), list(segundos = cut(traceserver_e_car7$time, "1 sec")), sum)
# taxabps1segserverts_e_car7<-ts(traceserver_e_car7$size, frequency = 1)
# 
# traceserver_e_car8<-read.table(file = 'server_etf_car8.txt', sep=' ')
# names(traceserver_e_car8)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car8$time <- as.POSIXlt(traceserver_e_car8$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car8$size<- traceserver_e_car8$size*8
# taxabps1segserver_e_car8<-aggregate(list(size = traceserver_e_car8$size), list(segundos = cut(traceserver_e_car8$time, "1 sec")), sum)
# taxabps1segserverts_e_car8<-ts(traceserver_e_car8$size, frequency = 1)
# 
# traceserver_e_car9<-read.table(file = 'server_etf_car9.txt', sep=' ')
# names(traceserver_e_car9)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car9$time <- as.POSIXlt(traceserver_e_car9$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car9$size<- traceserver_e_car9$size*8
# taxabps1segserver_e_car9<-aggregate(list(size = traceserver_e_car9$size), list(segundos = cut(traceserver_e_car9$time, "1 sec")), sum)
# taxabps1segserverts_e_car9<-ts(traceserver_e_car9$size, frequency = 1)
# 
# traceserver_e_car10<-read.table(file = 'server_etf_car10.txt', sep=' ')
# names(traceserver_e_car10)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car10$time <- as.POSIXlt(traceserver_e_car10$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car10$size<- traceserver_e_car10$size*8
# taxabps1segserver_e_car10<-aggregate(list(size = traceserver_e_car10$size), list(segundos = cut(traceserver_e_car10$time, "1 sec")), sum)
# taxabps1segserverts_e_car10<-ts(traceserver_e_car10$size, frequency = 1)
# 
# traceserver_e_car11<-read.table(file = 'server_etf_car11.txt', sep=' ')
# names(traceserver_e_car11)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car11$time <- as.POSIXlt(traceserver_e_car11$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car11$size<- traceserver_e_car11$size*8
# taxabps1segserver_e_car11<-aggregate(list(size = traceserver_e_car11$size), list(segundos = cut(traceserver_e_car11$time, "1 sec")), sum)
# taxabps1segserverts_e_car11<-ts(traceserver_e_car11$size, frequency = 1)

# traceserver_e_car12<-read.table(file = 'server_etf_car12.txt', sep=' ')
# names(traceserver_e_car12)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car12$time <- as.POSIXlt(traceserver_e_car12$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car12$size<- traceserver_e_car12$size*8
# taxabps1segserver_e_car12<-aggregate(list(size = traceserver_e_car12$size), list(segundos = cut(traceserver_e_car12$time, "1 sec")), sum)
# taxabps1segserverts_e_car12<-ts(traceserver_e_car12$size, frequency = 1)
# 
# traceserver_e_car13<-read.table(file = 'server_etf_car13.txt', sep=' ')
# names(traceserver_e_car13)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car13$time <- as.POSIXlt(traceserver_e_car13$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car13$size<- traceserver_e_car13$size*8
# taxabps1segserver_e_car13<-aggregate(list(size = traceserver_e_car13$size), list(segundos = cut(traceserver_e_car13$time, "1 sec")), sum)
# taxabps1segserverts_e_car13<-ts(traceserver_e_car13$size, frequency = 1)
# 
# traceserver_e_car14<-read.table(file = 'server_etf_car14.txt', sep=' ')
# names(traceserver_e_car14)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car14$time <- as.POSIXlt(traceserver_e_car14$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car14$size<- traceserver_e_car14$size*8
# taxabps1segserver_e_car14<-aggregate(list(size = traceserver_e_car14$size), list(segundos = cut(traceserver_e_car14$time, "1 sec")), sum)
# taxabps1segserverts_e_car14<-ts(traceserver_e_car14$size, frequency = 1)
# 
# traceserver_e_car15<-read.table(file = 'server_etf_car15.txt', sep=' ')
# names(traceserver_e_car15)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car15$time <- as.POSIXlt(traceserver_e_car15$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car15$size<- traceserver_e_car15$size*8
# taxabps1segserver_e_car15<-aggregate(list(size = traceserver_e_car15$size), list(segundos = cut(traceserver_e_car15$time, "1 sec")), sum)
# taxabps1segserverts_e_car15<-ts(traceserver_e_car15$size, frequency = 1)
# 
# traceserver_e_car16<-read.table(file = 'server_etf_car16.txt', sep=' ')
# names(traceserver_e_car16)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car16$time <- as.POSIXlt(traceserver_e_car16$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car16$size<- traceserver_e_car16$size*8
# taxabps1segserver_e_car16<-aggregate(list(size = traceserver_e_car16$size), list(segundos = cut(traceserver_e_car16$time, "1 sec")), sum)
# taxabps1segserverts_e_car16<-ts(traceserver_e_car16$size, frequency = 1)
# 
# traceserver_e_car17<-read.table(file = 'server_etf_car17.txt', sep=' ')
# names(traceserver_e_car17)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car17$time <- as.POSIXlt(traceserver_e_car17$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car17$size<- traceserver_e_car17$size*8
# taxabps1segserver_e_car17<-aggregate(list(size = traceserver_e_car17$size), list(segundos = cut(traceserver_e_car17$time, "1 sec")), sum)
# taxabps1segserverts_e_car17<-ts(traceserver_e_car17$size, frequency = 1)
# 
# traceserver_e_car18<-read.table(file = 'server_etf_car18.txt', sep=' ')
# names(traceserver_e_car18)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car18$time <- as.POSIXlt(traceserver_e_car18$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car18$size<- traceserver_e_car18$size*8
# taxabps1segserver_e_car18<-aggregate(list(size = traceserver_e_car18$size), list(segundos = cut(traceserver_e_car18$time, "1 sec")), sum)
# taxabps1segserverts_e_car18<-ts(traceserver_e_car18$size, frequency = 1)
# 
# traceserver_e_car19<-read.table(file = 'server_etf_car19.txt', sep=' ')
# names(traceserver_e_car19)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car19$time <- as.POSIXlt(traceserver_e_car19$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car19$size<- traceserver_e_car19$size*8
# taxabps1segserver_e_car19<-aggregate(list(size = traceserver_e_car19$size), list(segundos = cut(traceserver_e_car19$time, "1 sec")), sum)
# taxabps1segserverts_e_car19<-ts(traceserver_e_car19$size, frequency = 1)
# 
# traceserver_e_car20<-read.table(file = 'server_etf_car20.txt', sep=' ')
# names(traceserver_e_car20)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car20$time <- as.POSIXlt(traceserver_e_car20$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car20$size<- traceserver_e_car20$size*8
# taxabps1segserver_e_car20<-aggregate(list(size = traceserver_e_car20$size), list(segundos = cut(traceserver_e_car20$time, "1 sec")), sum)
# taxabps1segserverts_e_car20<-ts(traceserver_e_car20$size, frequency = 1)
# 
# traceserver_e_car21<-read.table(file = 'server_etf_car21.txt', sep=' ')
# names(traceserver_e_car21)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car21$time <- as.POSIXlt(traceserver_e_car21$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car21$size<- traceserver_e_car21$size*8
# taxabps1segserver_e_car21<-aggregate(list(size = traceserver_e_car21$size), list(segundos = cut(traceserver_e_car21$time, "1 sec")), sum)
# taxabps1segserverts_e_car21<-ts(traceserver_e_car21$size, frequency = 1)
# 
# traceserver_e_car22<-read.table(file = 'server_etf_car22.txt', sep=' ')
# names(traceserver_e_car22)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car22$time <- as.POSIXlt(traceserver_e_car22$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car22$size<- traceserver_e_car22$size*8
# taxabps1segserver_e_car22<-aggregate(list(size = traceserver_e_car22$size), list(segundos = cut(traceserver_e_car22$time, "1 sec")), sum)
# taxabps1segserverts_e_car22<-ts(traceserver_e_car22$size, frequency = 1)
# 
# traceserver_e_car23-read.table(file = 'server_etf_car23.txt', sep=' ')
# names(traceserver_e_car23)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car23$time <- as.POSIXlt(traceserver_e_car23$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car23$size<- traceserver_e_car23$size*8
# taxabps1segserver_e_car23<-aggregate(list(size = traceserver_e_car23$size), list(segundos = cut(traceserver_e_car23$time, "1 sec")), sum)
# taxabps1segserverts_e_car23<-ts(traceserver_e_car23$size, frequency = 1)
# 
# traceserver_e_car24<-read.table(file = 'server_etf_car24.txt', sep=' ')
# names(traceserver_e_car24)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car24$time <- as.POSIXlt(traceserver_e_car24$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car24$size<- traceserver_e_car24$size*8
# taxabps1segserver_e_car24<-aggregate(list(size = traceserver_e_car24$size), list(segundos = cut(traceserver_e_car24$time, "1 sec")), sum)
# taxabps1segserverts_e_car24<-ts(traceserver_e_car24$size, frequency = 1)
# 
# traceserver_e_car25<-read.table(file = 'server_etf_car25.txt', sep=' ')
# names(traceserver_e_car25)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car25$time <- as.POSIXlt(traceserver_e_car25$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car25$size<- traceserver_e_car25$size*8
# taxabps1segserver_e_car25<-aggregate(list(size = traceserver_e_car25$size), list(segundos = cut(traceserver_e_car25$time, "1 sec")), sum)
# taxabps1segserverts_e_car25<-ts(traceserver_e_car25$size, frequency = 1)
# 
# traceserver_e_car26<-read.table(file = 'server_etf_car26.txt', sep=' ')
# names(traceserver_e_car26)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car26$time <- as.POSIXlt(traceserver_e_car26$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car26$size<- traceserver_e_car26$size*8
# taxabps1segserver_e_car26<-aggregate(list(size = traceserver_e_car26$size), list(segundos = cut(traceserver_e_car26$time, "1 sec")), sum)
# taxabps1segserverts_e_car26<-ts(traceserver_e_car26$size, frequency = 1)
# 
# traceserver_e_car27<-read.table(file = 'server_etf_car27.txt', sep=' ')
# names(traceserver_e_car27)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car27$time <- as.POSIXlt(traceserver_e_car27$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car27$size<- traceserver_e_car27$size*8
# taxabps1segserver_e_car27<-aggregate(list(size = traceserver_e_car27$size), list(segundos = cut(traceserver_e_car27$time, "1 sec")), sum)
# taxabps1segserverts_e_car27<-ts(traceserver_e_car27$size, frequency = 1)
# 
# traceserver_e_car28<-read.table(file = 'server_etf_car28.txt', sep=' ')
# names(traceserver_e_car28)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car28$time <- as.POSIXlt(traceserver_e_car28$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car28$size<- traceserver_e_car28$size*8
# taxabps1segserver_e_car28<-aggregate(list(size = traceserver_e_car28$size), list(segundos = cut(traceserver_e_car28$time, "1 sec")), sum)
# taxabps1segserverts_e_car28<-ts(traceserver_e_car28$size, frequency = 1)
# 
# traceserver_e_car29<-read.table(file = 'server_etf_car29.txt', sep=' ')
# names(traceserver_e_car29)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e_car29$time <- as.POSIXlt(traceserver_e_car29$time, origin = "1987-10-05 11:00:00")
# traceserver_e_car29$size<- traceserver_e_car29$size*8
# taxabps1segserver_e_car29<-aggregate(list(size = traceserver_e_car29$size), list(segundos = cut(traceserver_e_car29$time, "1 sec")), sum)
# taxabps1segserverts_e_car19<-ts(traceserver_e_car19$size, frequency = 1)
# 
# plot(c(1:length(taxabps1segserver_e_car0$size)), taxabps1segserver_e_car0$size, main="Server E", ylab='bits/s', xlab='time(s)', type = "l", col="blue")
# lines(c(1:length(taxabps1segserver_e_car1$size)), taxabps1segserver_e_car1$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car2$segundos, taxabps1segserver_e_car2$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car3$segundos, taxabps1segserver_e_car3$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car4$segundos, taxabps1segserver_e_car4$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car5$segundos, taxabps1segserver_e_car5$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_e_car6$segundos, taxabps1segserver_e_car6$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car7$segundos, taxabps1segserver_e_car7$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car8$segundos, taxabps1segserver_e_car8$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car9$segundos, taxabps1segserver_e_car9$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car10$segundos, taxabps1segserver_e_car10$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car11$segundos, taxabps1segserver_e_car11$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_e_car12$segudos, taxabps1segserver_e_car12$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car13$segundos, taxabps1segserver_e_car13$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car14$segundos, taxabps1segserver_e_car14$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car15$segundos, taxabps1segserver_e_car15$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car16$segundos, taxabps1segserver_e_car16$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car17$segundos, taxabps1segserver_e_car17$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car18$segundos, taxabps1segserver_e_car18$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e_car19$segundos, taxabps1segserver_e_car19$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# legend(240, 2e+06, legend=c("Car transmission", "Server reception"), col=c("blue", "red"), lty=1:2, cex=0.8)



#trafego dos veiculos para server_e


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

# tracecar7_e<-read.table(file = 'car7tf_5003.txt', sep=' ')
# names(tracecar7_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar7_e$time <- as.POSIXlt(tracecar7_e$time, origin = "1987-10-05 11:00:00")
# tracecar7_e$size<- tracecar7_e$size*8
# taxabps1segcar7_e<-aggregate(list(size = tracecar7_e$size), list(segundos = cut(tracecar7_e$time, "1 sec")), sum)
# taxabps1segcar7_ets<-ts(tracecar7_e$size, frequency = 1)
# 
# tracecar8_e<-read.table(file = 'car8tf_5003.txt', sep=' ')
# names(tracecar8_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar8_e$time <- as.POSIXlt(tracecar8_e$time, origin = "1987-10-05 11:00:00")
# tracecar8_e$size<- tracecar8_e$size*8
# taxabps1segcar8_e<-aggregate(list(size = tracecar8_e$size), list(segundos = cut(tracecar8_e$time, "1 sec")), sum)
# taxabps1segcar8_ets<-ts(tracecar8_e$size, frequency = 1)
# 
# tracecar9_e<-read.table(file = 'car9tf_5003.txt', sep=' ')
# names(tracecar9_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar9_e$time <- as.POSIXlt(tracecar9_e$time, origin = "1987-10-05 11:00:00")
# tracecar9_e$size<- tracecar9_e$size*8
# taxabps1segcar9_e<-aggregate(list(size = tracecar9_e$size), list(segundos = cut(tracecar9_e$time, "1 sec")), sum)
# taxabps1segcar9_ets<-ts(tracecar9_e$size, frequency = 1)
# 
# tracecar10_e<-read.table(file = 'car10tf_5003.txt', sep=' ')
# names(tracecar10_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar10_e$time <- as.POSIXlt(tracecar10_e$time, origin = "1987-10-05 11:00:00")
# tracecar10_e$size<- tracecar10_e$size*8
# taxabps1segcar10_e<-aggregate(list(size = tracecar10_e$size), list(segundos = cut(tracecar10_e$time, "1 sec")), sum)
# taxabps1segcar10_ets<-ts(tracecar10_e$size, frequency = 1)
# 
# tracecar11_e<-read.table(file = 'car11tf_5003.txt', sep=' ')
# names(tracecar11_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar11_e$time <- as.POSIXlt(tracecar11_e$time, origin = "1987-10-05 11:00:00")
# tracecar11_e$size<- tracecar11_e$size*8
# taxabps1segcar11_e<-aggregate(list(size = tracecar11_e$size), list(segundos = cut(tracecar11_e$time, "1 sec")), sum)
# taxabps1segcar11_ets<-ts(tracecar11_e$size, frequency = 1)

# tracecar12_e<-read.table(file = 'car12tf_5003.txt', sep=' ')
# names(tracecar12_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar12_e$time <- as.POSIXlt(tracecar12_e$time, origin = "1987-10-05 11:00:00")
# tracecar12_e$size<- tracecar12_e$size*8
# taxabps1segcar12_e<-aggregate(list(size = tracecar12_e$size), list(segundos = cut(tracecar12_e$time, "1 sec")), sum)
# taxabps1segcar12_ets<-ts(tracecar12_e$size, frequency = 1)
# 
# tracecar13_e<-read.table(file = 'car13tf_5003.txt', sep=' ')
# names(tracecar13_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar13_e$time <- as.POSIXlt(tracecar13_e$time, origin = "1987-10-05 11:00:00")
# tracecar13_e$size<- tracecar13_e$size*8
# taxabps1segcar13_e<-aggregate(list(size = tracecar13_e$size), list(segundos = cut(tracecar13_e$time, "1 sec")), sum)
# taxabps1segcar13_ets<-ts(tracecar13_e$size, frequency = 1)
# 
# tracecar14_e<-read.table(file = 'car14tf_5003.txt', sep=' ')
# names(tracecar14_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar14_e$time <- as.POSIXlt(tracecar14_e$time, origin = "1987-10-05 11:00:00")
# tracecar14_e$size<- tracecar14_e$size*8
# taxabps1segcar14_e<-aggregate(list(size = tracecar14_e$size), list(segundos = cut(tracecar14_e$time, "1 sec")), sum)
# taxabps1segcar14_ets<-ts(tracecar14_e$size, frequency = 1)
# 
# tracecar15_e<-read.table(file = 'car15tf_5003.txt', sep=' ')
# names(tracecar15_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar15_e$time <- as.POSIXlt(tracecar15_e$time, origin = "1987-10-05 11:00:00")
# tracecar15_e$size<- tracecar15_e$size*8
# taxabps1segcar15_e<-aggregate(list(size = tracecar15_e$size), list(segundos = cut(tracecar15_e$time, "1 sec")), sum)
# taxabps1segcar15_ets<-ts(tracecar15_e$size, frequency = 1)
# 
# tracecar16_e<-read.table(file = 'car16tf_5003.txt', sep=' ')
# names(tracecar16_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar16_e$time <- as.POSIXlt(tracecar16_e$time, origin = "1987-10-05 11:00:00")
# tracecar16_e$size<- tracecar16_e$size*8
# taxabps1segcar16_e<-aggregate(list(size = tracecar16_e$size), list(segundos = cut(tracecar16_e$time, "1 sec")), sum)
# taxabps1segcar16_ets<-ts(tracecar16_e$size, frequency = 1)
# 
# tracecar17_e<-read.table(file = 'car17tf_5003.txt', sep=' ')
# names(tracecar17_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar17_e$time <- as.POSIXlt(tracecar17_e$time, origin = "1987-10-05 11:00:00")
# tracecar17_e$size<- tracecar17_e$size*8
# taxabps1segcar17_e<-aggregate(list(size = tracecar17_e$size), list(segundos = cut(tracecar17_e$time, "1 sec")), sum)
# taxabps1segcar17_ets<-ts(tracecar17_e$size, frequency = 1)
# 
# tracecar18_e<-read.table(file = 'car18tf_5003.txt', sep=' ')
# names(tracecar18_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar18_e$time <- as.POSIXlt(tracecar18_e$time, origin = "1987-10-05 11:00:00")
# tracecar18_e$size<- tracecar18_e$size*8
# taxabps1segcar18_e<-aggregate(list(size = tracecar18_e$size), list(segundos = cut(tracecar18_e$time, "1 sec")), sum)
# taxabps1segcar18_ets<-ts(tracecar18_e$size, frequency = 1)
# 
# tracecar19_e<-read.table(file = 'car19tf_5003.txt', sep=' ')
# names(tracecar19_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar19_e$time <- as.POSIXlt(tracecar19_e$time, origin = "1987-10-05 11:00:00")
# tracecar19_e$size<- tracecar19_e$size*8
# taxabps1segcar19_e<-aggregate(list(size = tracecar19_e$size), list(segundos = cut(tracecar19_e$time, "1 sec")), sum)
# taxabps1segcar19_ets<-ts(tracecar19_e$size, frequency = 1)
# 
# tracecar20_e<-read.table(file = 'car20tf_5003.txt', sep=' ')
# names(tracecar20_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar20_e$time <- as.POSIXlt(tracecar20_e$time, origin = "1987-10-05 11:00:00")
# tracecar20_e$size<- tracecar20_e$size*8
# taxabps1segcar20_e<-aggregate(list(size = tracecar20_e$size), list(segundos = cut(tracecar20_e$time, "1 sec")), sum)
# taxabps1segcar20_ets<-ts(tracecar20_e$size, frequency = 1)
# 
# tracecar21_e<-read.table(file = 'car21tf_5003.txt', sep=' ')
# names(tracecar21_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar21_e$time <- as.POSIXlt(tracecar21_e$time, origin = "1987-10-05 11:00:00")
# tracecar21_e$size<- tracecar21_e$size*8
# taxabps1segcar21_e<-aggregate(list(size = tracecar21_e$size), list(segundos = cut(tracecar21_e$time, "1 sec")), sum)
# taxabps1segcar21_ets<-ts(tracecar21_e$size, frequency = 1)
# 
# tracecar22_e<-read.table(file = 'car22tf_5003.txt', sep=' ')
# names(tracecar22_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar22_e$time <- as.POSIXlt(tracecar22_e$time, origin = "1987-10-05 11:00:00")
# tracecar22_e$size<- tracecar22_e$size*8
# taxabps1segcar22_e<-aggregate(list(size = tracecar22_e$size), list(segundos = cut(tracecar22_e$time, "1 sec")), sum)
# taxabps1segcar22_ets<-ts(tracecar22_e$size, frequency = 1)
# 
# tracecar23_e<-read.table(file = 'car23tf_5003.txt', sep=' ')
# names(tracecar23_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar23_e$time <- as.POSIXlt(tracecar23_e$time, origin = "1987-10-05 11:00:00")
# tracecar23_e$size<- tracecar23_e$size*8
# taxabps1segcar23_e<-aggregate(list(size = tracecar23_e$size), list(segundos = cut(tracecar23_e$time, "1 sec")), sum)
# taxabps1segcar23_ets<-ts(tracecar23_e$size, frequency = 1)
# 
# tracecar24_e<-read.table(file = 'car24tf_5003.txt', sep=' ')
# names(tracecar24_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar24_e$time <- as.POSIXlt(tracecar24_e$time, origin = "1987-10-05 11:00:00")
# tracecar24_e$size<- tracecar24_e$size*8
# taxabps1segcar24_e<-aggregate(list(size = tracecar24_e$size), list(segundos = cut(tracecar24_e$time, "1 sec")), sum)
# taxabps1segcar24_ets<-ts(tracecar24_e$size, frequency = 1)
# 
# tracecar25_e<-read.table(file = 'car25tf_5003.txt', sep=' ')
# names(tracecar25_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar25_e$time <- as.POSIXlt(tracecar25_e$time, origin = "1987-10-05 11:00:00")
# tracecar25_e$size<- tracecar25_e$size*8
# taxabps1segcar25_e<-aggregate(list(size = tracecar25_e$size), list(segundos = cut(tracecar25_e$time, "1 sec")), sum)
# taxabps1segcar25_ets<-ts(tracecar25_e$size, frequency = 1)
# 
# tracecar26_e<-read.table(file = 'car26tf_5003.txt', sep=' ')
# names(tracecar26_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar26_e$time <- as.POSIXlt(tracecar26_e$time, origin = "1987-10-05 11:00:00")
# tracecar26_e$size<- tracecar26_e$size*8
# taxabps1segcar26_e<-aggregate(list(size = tracecar26_e$size), list(segundos = cut(tracecar26_e$time, "1 sec")), sum)
# taxabps1segcar26_ets<-ts(tracecar26_e$size, frequency = 1)
# 
# tracecar27_e<-read.table(file = 'car27tf_5003.txt', sep=' ')
# names(tracecar27_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar27_e$time <- as.POSIXlt(tracecar27_e$time, origin = "1987-10-05 11:00:00")
# tracecar27_e$size<- tracecar27_e$size*8
# taxabps1segcar27_e<-aggregate(list(size = tracecar27_e$size), list(segundos = cut(tracecar27_e$time, "1 sec")), sum)
# taxabps1segcar27_ets<-ts(tracecar27_e$size, frequency = 1)
# 
# tracecar28_e<-read.table(file = 'car28tf_5003.txt', sep=' ')
# names(tracecar28_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar28_e$time <- as.POSIXlt(tracecar28_e$time, origin = "1987-10-05 11:00:00")
# tracecar28_e$size<- tracecar28_e$size*8
# taxabps1segcar28_e<-aggregate(list(size = tracecar28_e$size), list(segundos = cut(tracecar28_e$time, "1 sec")), sum)
# taxabps1segcar28_ets<-ts(tracecar28_e$size, frequency = 1)
# 
# tracecar29_e<-read.table(file = 'car29tf_5003.txt', sep=' ')
# names(tracecar29_e)<-c("time", "id", "size", "ori", "dest" )
# tracecar29_e$time <- as.POSIXlt(tracecar29_e$time, origin = "1987-10-05 11:00:00")
# tracecar29_e$size<- tracecar29_e$size*8
# taxabps1segcar29_e<-aggregate(list(size = tracecar29_e$size), list(segundos = cut(tracecar29_e$time, "1 sec")), sum)
# taxabps1segcar29_ets<-ts(tracecar29_e$size, frequency = 1)


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

ctime_e<-c(0:299)
#tt<-c(taxabps1segcar0_e$size[1:195], taxabps1segcar1_e$size[1:195], taxabps1segcar2_e$size[1:195], taxabps1segcar3_e$size[1:195], taxabps1segcar4_e$size[1:195], taxabps1segcar5_e$size[1:195], taxabps1segcar6_e$size[1:195], taxabps1segcar7_e$size[1:195], taxabps1segcar8_e$size[1:195], taxabps1segcar9_e$size[1:195], taxabps1segcar10_e$size[1:195], taxabps1segcar11_e$size[1:195], taxabps1segcar12_e$size[1:195], taxabps1segcar13_e$size[1:195], taxabps1segcar14_e$size[1:195], taxabps1segcar15_e$size[1:195], taxabps1segcar16_e$size[1:195], taxabps1segcar17_e$size[1:195], taxabps1segcar18_e$size[1:195], taxabps1segcar19_e$size[1:195])
cartotal_e<-c(taxabps1segcar0_e$size[1:300], taxabps1segcar1_e$size[1:300], taxabps1segcar2_e$size[1:300], taxabps1segcar3_e$size[1:300], taxabps1segcar4_e$size[1:300], taxabps1segcar5_e$size[1:300], taxabps1segcar6_e$size[1:300])
carmean_e<-c(taxabps1segcar0_e$size[1:300] + taxabps1segcar1_e$size[1:300] + taxabps1segcar2_e$size[1:300] + taxabps1segcar3_e$size[1:300] + taxabps1segcar4_e$size[1:300] + taxabps1segcar5_e$size[1:300] + taxabps1segcar6_e$size[1:300])/7
fctime_e<-c(ctime, ctime, ctime, ctime, ctime, ctime, ctime)

require(Rmisc)
x<- cbind(fctime_e,cartotal_e)
x<-data.frame(x)
y<-group.CI(cartotal_e~fctime_e,x,ci = 0.95)
require(plotrix)
plotCI(ctime_e, carmean_e, ui=y$cartotal_e.upper, li=y$cartotal_e.lower, col="red", main="Server E", ylab = "Taxa de entrega de pacotes - PDR", xlab = "tempo (s)", ylim = range(0:1e+06) )
lines(ctime_e,carmean_e, type = "l", col="black", lwd="2")

par(new=T)

stime_e<-c(0:299)
#tt<-c(taxabps1segserver_e_car0$size[1:195], taxabps1segserver_e_car1$size[1:195], taxabps1segserver_e_car2$size[1:195], taxabps1segserver_e_car3$size[1:195], taxabps1segserver_e_car4$size[1:195], taxabps1segserver_e_car5$size[1:195], taxabps1segserver_e_car6$size[1:195], taxabps1segserver_e_car7$size[1:195], taxabps1segserver_e_car8$size[1:195], taxabps1segserver_e_car9$size[1:195], taxabps1segserver_e_car10$size[1:195], taxabps1segserver_e_car11$size[1:195], taxabps1segserver_e_car12$size[1:195], taxabps1segserver_e_car13$size[1:195], taxabps1segserver_e_car14$size[1:195], taxabps1segserver_e_car15$size[1:195], taxabps1segserver_e_car16$size[1:195], taxabps1segserver_e_car17$size[1:195], taxabps1segserver_e_car18$size[1:195], taxabps1segserver_e_car19$size[1:195])
servertotal_e<-c(taxabps1segserver_e_car0$size[1:300], taxabps1segserver_e_car1$size[1:300], taxabps1segserver_e_car2$size[1:300], taxabps1segserver_e_car3$size[1:300], taxabps1segserver_e_car4$size[1:300], taxabps1segserver_e_car5$size[1:300], taxabps1segserver_e_car6$size[1:300])
servermean_e<-c(taxabps1segserver_e_car0$size[1:300] + taxabps1segserver_e_car1$size[1:300] + taxabps1segserver_e_car2$size[1:300] + taxabps1segserver_e_car3$size[1:300] + taxabps1segserver_e_car4$size[1:300] + taxabps1segserver_e_car5$size[1:300] + taxabps1segserver_e_car6$size[1:300])/7
fstime_e<-c(stime_e, stime_e, stime_e, stime_e, stime_e, stime_e, stime_e)

require(Rmisc)
x<- cbind(fstime_e,servertotal_e)
x<-data.frame(x)
y<-group.CI(servertotal_e~fstime_e,x,ci = 0.95)
require(plotrix)
plotCI(stime_e, servermean_e, ui=y$servertotal_e.upper, li=y$servertotal_e.lower, col="blue", main="Server E", ylab = "Taxa de entrega de pacotes - PDR", xlab = "tempo (s)", ylim = range(0:1e+06) )
lines(stime_e,servermean_e, type = "l", col="black", lwd="2")


par(new=T)


dtime_e<-c(0:300)
delaytotal_e<-c(delay_e0$delay[1:300], delay_e1$delay[1:300], delay_e2$delay[1:300], delay_e3$delay[1:300], delay_e4$delay[1:300], delay_e5$delay[1:300], delay_e6$delay[1:300])
delaymean_e<-c(delay_e0$delay[1:300] + delay_e1$delay[1:300] + delay_e2$delay[1:300] + delay_e3$delay[1:300] + delay_e4$delay[1:300] + delay_e5$delay[1:300] + delay_e6$delay[1:300])/7
fdtime_e<-c(dtime_e, dtime_e, dtime_e, dtime_e, dtime_e, dtime_e, dtime_e)

require(Rmisc)
x<- cbind(fdtime_e,delaytotal_e)
x<-data.frame(x)
y<-group.CI(delaytotal_e~fdtime_e,x,ci = 0.95)
require(plotrix)

par(new = T)
# with(d, plot(ttime, ttm, pch=16, axes=F, xlab=NA, ylab=NA, cex=1.2))
plotCI(ttime, delaymean_e, ui=y$delaytotal_e.upper, li=y$delaytotal_e.lower, col="orange", axes=F, xlab=NA, ylab=NA, cex=1.2)
lines(dtime_e[2:300],delaymean_e[2:300], type = "l", col="black", lwd="2")
axis(side = 4)
mtext(side = 4, line = 3, 'Number genes selected')
legend("topleft",
       legend=c(expression(-log[10](italic(p))), "N genes"),
       lty=c(1,0), pch=c(NA, 16), col=c("red3", "black"))
