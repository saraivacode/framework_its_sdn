traceserver_g_car0<-read.table(file = 'server_gtf_car0.txt', sep=' ')
names(traceserver_g_car0)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
traceserver_g_car0$time <- as.POSIXlt(traceserver_g_car0$time, origin = "1987-10-05 11:00:00")
traceserver_g_car0$size<- traceserver_g_car0$size*8
taxabps1segserver_g_car0<-aggregate(list(size = traceserver_g_car0$size), list(segundos = cut(traceserver_g_car0$time, "1 sec")), sum)
taxabps1segserverts_g_car0<-ts(traceserver_g_car0$size, frequency = 1)

traceserver_g_car1<-read.table(file = 'server_gtf_car1.txt', sep=' ')
names(traceserver_g_car1)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car1$time <- as.POSIXlt(traceserver_g_car1$time, origin = "1987-10-05 11:00:00")
traceserver_g_car1$size<- traceserver_g_car1$size*8
taxabps1segserver_g_car1<-aggregate(list(size = traceserver_g_car1$size), list(segundos = cut(traceserver_g_car1$time, "1 sec")), sum)
taxabps1segserverts_g_car1<-ts(traceserver_g_car1$size, frequency = 1)

traceserver_g_car2<-read.table(file = 'server_gtf_car2.txt', sep=' ')
names(traceserver_g_car2)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car2$time <- as.POSIXlt(traceserver_g_car2$time, origin = "1987-10-05 11:00:00")
traceserver_g_car2$size<- traceserver_g_car2$size*8
taxabps1segserver_g_car2<-aggregate(list(size = traceserver_g_car2$size), list(segundos = cut(traceserver_g_car2$time, "1 sec")), sum)
taxabps1segserverts_g_car2<-ts(traceserver_g_car2$size, frequency = 1)

traceserver_g_car3<-read.table(file = 'server_gtf_car3.txt', sep=' ')
names(traceserver_g_car3)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car3$time <- as.POSIXlt(traceserver_g_car3$time, origin = "1987-10-05 11:00:00")
traceserver_g_car3$size<- traceserver_g_car3$size*8
taxabps1segserver_g_car3<-aggregate(list(size = traceserver_g_car3$size), list(segundos = cut(traceserver_g_car3$time, "1 sec")), sum)
taxabps1segserverts_g_car3<-ts(traceserver_g_car3$size, frequency = 1)

traceserver_g_car4<-read.table(file = 'server_gtf_car4.txt', sep=' ')
names(traceserver_g_car4)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car4$time <- as.POSIXlt(traceserver_g_car4$time, origin = "1987-10-05 11:00:00")
traceserver_g_car4$size<- traceserver_g_car4$size*8
taxabps1segserver_g_car4<-aggregate(list(size = traceserver_g_car4$size), list(segundos = cut(traceserver_g_car4$time, "1 sec")), sum)
taxabps1segserverts_g_car4<-ts(traceserver_g_car4$size, frequency = 1)

traceserver_g_car5<-read.table(file = 'server_gtf_car5.txt', sep=' ')
names(traceserver_g_car5)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car5$time <- as.POSIXlt(traceserver_g_car5$time, origin = "1987-10-05 11:00:00")
traceserver_g_car5$size<- traceserver_g_car5$size*8
taxabps1segserver_g_car5<-aggregate(list(size = traceserver_g_car5$size), list(segundos = cut(traceserver_g_car5$time, "1 sec")), sum)
taxabps1segserverts_g_car5<-ts(traceserver_g_car5$size, frequency = 1)

traceserver_g_car6<-read.table(file = 'server_gtf_car6.txt', sep=' ')
names(traceserver_g_car6)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_car6$time <- as.POSIXlt(traceserver_g_car6$time, origin = "1987-10-05 11:00:00")
traceserver_g_car6$size<- traceserver_g_car6$size*8
taxabps1segserver_g_car6<-aggregate(list(size = traceserver_g_car6$size), list(segundos = cut(traceserver_g_car6$time, "1 sec")), sum)
taxabps1segserverts_g_car6<-ts(traceserver_g_car6$size, frequency = 1)

# traceserver_g_car7<-read.table(file = 'server_gtf_car7.txt', sep=' ')
# names(traceserver_g_car7)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car7$time <- as.POSIXlt(traceserver_g_car7$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car7$size<- traceserver_g_car7$size*8
# taxabps1segserver_g_car7<-aggregate(list(size = traceserver_g_car7$size), list(segundos = cut(traceserver_g_car7$time, "1 sec")), sum)
# taxabps1segserverts_g_car7<-ts(traceserver_g_car7$size, frequency = 1)
# 
# traceserver_g_car8<-read.table(file = 'server_gtf_car8.txt', sep=' ')
# names(traceserver_g_car8)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car8$time <- as.POSIXlt(traceserver_g_car8$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car8$size<- traceserver_g_car8$size*8
# taxabps1segserver_g_car8<-aggregate(list(size = traceserver_g_car8$size), list(segundos = cut(traceserver_g_car8$time, "1 sec")), sum)
# taxabps1segserverts_g_car8<-ts(traceserver_g_car8$size, frequency = 1)
# 
# traceserver_g_car9<-read.table(file = 'server_gtf_car9.txt', sep=' ')
# names(traceserver_g_car9)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car9$time <- as.POSIXlt(traceserver_g_car9$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car9$size<- traceserver_g_car9$size*8
# taxabps1segserver_g_car9<-aggregate(list(size = traceserver_g_car9$size), list(segundos = cut(traceserver_g_car9$time, "1 sec")), sum)
# taxabps1segserverts_g_car9<-ts(traceserver_g_car9$size, frequency = 1)
# 
# traceserver_g_car10<-read.table(file = 'server_gtf_car10.txt', sep=' ')
# names(traceserver_g_car10)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car10$time <- as.POSIXlt(traceserver_g_car10$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car10$size<- traceserver_g_car10$size*8
# taxabps1segserver_g_car10<-aggregate(list(size = traceserver_g_car10$size), list(segundos = cut(traceserver_g_car10$time, "1 sec")), sum)
# taxabps1segserverts_g_car10<-ts(traceserver_g_car10$size, frequency = 1)
# 
# traceserver_g_car11<-read.table(file = 'server_gtf_car11.txt', sep=' ')
# names(traceserver_g_car11)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car11$time <- as.POSIXlt(traceserver_g_car11$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car11$size<- traceserver_g_car11$size*8
# taxabps1segserver_g_car11<-aggregate(list(size = traceserver_g_car11$size), list(segundos = cut(traceserver_g_car11$time, "1 sec")), sum)
# taxabps1segserverts_g_car11<-ts(traceserver_g_car11$size, frequency = 1)

# traceserver_g_car12<-read.table(file = 'server_gtf_car12.txt', sep=' ')
# names(traceserver_g_car12)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car12$time <- as.POSIXlt(traceserver_g_car12$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car12$size<- traceserver_g_car12$size*8
# taxabps1segserver_g_car12<-aggregate(list(size = traceserver_g_car12$size), list(segundos = cut(traceserver_g_car12$time, "1 sec")), sum)
# taxabps1segserverts_g_car12<-ts(traceserver_g_car12$size, frequency = 1)
# 
# traceserver_g_car13<-read.table(file = 'server_gtf_car13.txt', sep=' ')
# names(traceserver_g_car13)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car13$time <- as.POSIXlt(traceserver_g_car13$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car13$size<- traceserver_g_car13$size*8
# taxabps1segserver_g_car13<-aggregate(list(size = traceserver_g_car13$size), list(segundos = cut(traceserver_g_car13$time, "1 sec")), sum)
# taxabps1segserverts_g_car13<-ts(traceserver_g_car13$size, frequency = 1)
# 
# traceserver_g_car14<-read.table(file = 'server_gtf_car14.txt', sep=' ')
# names(traceserver_g_car14)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car14$time <- as.POSIXlt(traceserver_g_car14$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car14$size<- traceserver_g_car14$size*8
# taxabps1segserver_g_car14<-aggregate(list(size = traceserver_g_car14$size), list(segundos = cut(traceserver_g_car14$time, "1 sec")), sum)
# taxabps1segserverts_g_car14<-ts(traceserver_g_car14$size, frequency = 1)
# 
# traceserver_g_car15<-read.table(file = 'server_gtf_car15.txt', sep=' ')
# names(traceserver_g_car15)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car15$time <- as.POSIXlt(traceserver_g_car15$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car15$size<- traceserver_g_car15$size*8
# taxabps1segserver_g_car15<-aggregate(list(size = traceserver_g_car15$size), list(segundos = cut(traceserver_g_car15$time, "1 sec")), sum)
# taxabps1segserverts_g_car15<-ts(traceserver_g_car15$size, frequency = 1)
# 
# traceserver_g_car16<-read.table(file = 'server_gtf_car16.txt', sep=' ')
# names(traceserver_g_car16)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car16$time <- as.POSIXlt(traceserver_g_car16$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car16$size<- traceserver_g_car16$size*8
# taxabps1segserver_g_car16<-aggregate(list(size = traceserver_g_car16$size), list(segundos = cut(traceserver_g_car16$time, "1 sec")), sum)
# taxabps1segserverts_g_car16<-ts(traceserver_g_car16$size, frequency = 1)
# 
# traceserver_g_car17<-read.table(file = 'server_gtf_car17.txt', sep=' ')
# names(traceserver_g_car17)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car17$time <- as.POSIXlt(traceserver_g_car17$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car17$size<- traceserver_g_car17$size*8
# taxabps1segserver_g_car17<-aggregate(list(size = traceserver_g_car17$size), list(segundos = cut(traceserver_g_car17$time, "1 sec")), sum)
# taxabps1segserverts_g_car17<-ts(traceserver_g_car17$size, frequency = 1)
# 
# traceserver_g_car18<-read.table(file = 'server_gtf_car18.txt', sep=' ')
# names(traceserver_g_car18)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car18$time <- as.POSIXlt(traceserver_g_car18$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car18$size<- traceserver_g_car18$size*8
# taxabps1segserver_g_car18<-aggregate(list(size = traceserver_g_car18$size), list(segundos = cut(traceserver_g_car18$time, "1 sec")), sum)
# taxabps1segserverts_g_car18<-ts(traceserver_g_car18$size, frequency = 1)
# 
# traceserver_g_car19<-read.table(file = 'server_gtf_car19.txt', sep=' ')
# names(traceserver_g_car19)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car19$time <- as.POSIXlt(traceserver_g_car19$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car19$size<- traceserver_g_car19$size*8
# taxabps1segserver_g_car19<-aggregate(list(size = traceserver_g_car19$size), list(segundos = cut(traceserver_g_car19$time, "1 sec")), sum)
# taxabps1segserverts_g_car19<-ts(traceserver_g_car19$size, frequency = 1)
# 
# traceserver_g_car20<-read.table(file = 'server_gtf_car20.txt', sep=' ')
# names(traceserver_g_car20)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car20$time <- as.POSIXlt(traceserver_g_car20$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car20$size<- traceserver_g_car20$size*8
# taxabps1segserver_g_car20<-aggregate(list(size = traceserver_g_car20$size), list(segundos = cut(traceserver_g_car20$time, "1 sec")), sum)
# taxabps1segserverts_g_car20<-ts(traceserver_g_car20$size, frequency = 1)
# 
# traceserver_g_car21<-read.table(file = 'server_gtf_car21.txt', sep=' ')
# names(traceserver_g_car21)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car21$time <- as.POSIXlt(traceserver_g_car21$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car21$size<- traceserver_g_car21$size*8
# taxabps1segserver_g_car21<-aggregate(list(size = traceserver_g_car21$size), list(segundos = cut(traceserver_g_car21$time, "1 sec")), sum)
# taxabps1segserverts_g_car21<-ts(traceserver_g_car21$size, frequency = 1)
# 
# traceserver_g_car22<-read.table(file = 'server_gtf_car22.txt', sep=' ')
# names(traceserver_g_car22)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car22$time <- as.POSIXlt(traceserver_g_car22$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car22$size<- traceserver_g_car22$size*8
# taxabps1segserver_g_car22<-aggregate(list(size = traceserver_g_car22$size), list(segundos = cut(traceserver_g_car22$time, "1 sec")), sum)
# taxabps1segserverts_g_car22<-ts(traceserver_g_car22$size, frequency = 1)
# 
# traceserver_g_car23-read.table(file = 'server_gtf_car23.txt', sep=' ')
# names(traceserver_g_car23)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car23$time <- as.POSIXlt(traceserver_g_car23$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car23$size<- traceserver_g_car23$size*8
# taxabps1segserver_g_car23<-aggregate(list(size = traceserver_g_car23$size), list(segundos = cut(traceserver_g_car23$time, "1 sec")), sum)
# taxabps1segserverts_g_car23<-ts(traceserver_g_car23$size, frequency = 1)
# 
# traceserver_g_car24<-read.table(file = 'server_gtf_car24.txt', sep=' ')
# names(traceserver_g_car24)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car24$time <- as.POSIXlt(traceserver_g_car24$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car24$size<- traceserver_g_car24$size*8
# taxabps1segserver_g_car24<-aggregate(list(size = traceserver_g_car24$size), list(segundos = cut(traceserver_g_car24$time, "1 sec")), sum)
# taxabps1segserverts_g_car24<-ts(traceserver_g_car24$size, frequency = 1)
# 
# traceserver_g_car25<-read.table(file = 'server_gtf_car25.txt', sep=' ')
# names(traceserver_g_car25)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car25$time <- as.POSIXlt(traceserver_g_car25$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car25$size<- traceserver_g_car25$size*8
# taxabps1segserver_g_car25<-aggregate(list(size = traceserver_g_car25$size), list(segundos = cut(traceserver_g_car25$time, "1 sec")), sum)
# taxabps1segserverts_g_car25<-ts(traceserver_g_car25$size, frequency = 1)
# 
# traceserver_g_car26<-read.table(file = 'server_gtf_car26.txt', sep=' ')
# names(traceserver_g_car26)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car26$time <- as.POSIXlt(traceserver_g_car26$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car26$size<- traceserver_g_car26$size*8
# taxabps1segserver_g_car26<-aggregate(list(size = traceserver_g_car26$size), list(segundos = cut(traceserver_g_car26$time, "1 sec")), sum)
# taxabps1segserverts_g_car26<-ts(traceserver_g_car26$size, frequency = 1)
# 
# traceserver_g_car27<-read.table(file = 'server_gtf_car27.txt', sep=' ')
# names(traceserver_g_car27)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car27$time <- as.POSIXlt(traceserver_g_car27$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car27$size<- traceserver_g_car27$size*8
# taxabps1segserver_g_car27<-aggregate(list(size = traceserver_g_car27$size), list(segundos = cut(traceserver_g_car27$time, "1 sec")), sum)
# taxabps1segserverts_g_car27<-ts(traceserver_g_car27$size, frequency = 1)
# 
# traceserver_g_car28<-read.table(file = 'server_gtf_car28.txt', sep=' ')
# names(traceserver_g_car28)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car28$time <- as.POSIXlt(traceserver_g_car28$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car28$size<- traceserver_g_car28$size*8
# taxabps1segserver_g_car28<-aggregate(list(size = traceserver_g_car28$size), list(segundos = cut(traceserver_g_car28$time, "1 sec")), sum)
# taxabps1segserverts_g_car28<-ts(traceserver_g_car28$size, frequency = 1)
# 
# traceserver_g_car29<-read.table(file = 'server_gtf_car29.txt', sep=' ')
# names(traceserver_g_car29)<-c("time", "id", "size", "ori", "dest" )
# traceserver_g_car29$time <- as.POSIXlt(traceserver_g_car29$time, origin = "1987-10-05 11:00:00")
# traceserver_g_car29$size<- traceserver_g_car29$size*8
# taxabps1segserver_g_car29<-aggregate(list(size = traceserver_g_car29$size), list(segundos = cut(traceserver_g_car29$time, "1 sec")), sum)
# taxabps1segserverts_g_car19<-ts(traceserver_g_car19$size, frequency = 1)
# 
# plot(c(1:length(taxabps1segserver_g_car0$size)), taxabps1segserver_g_car0$size, main="Server E", ylab='bits/s', xlab='time(s)', type = "l", col="blue")
# lines(c(1:length(taxabps1segserver_g_car1$size)), taxabps1segserver_g_car1$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car2$segundos, taxabps1segserver_g_car2$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car3$segundos, taxabps1segserver_g_car3$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car4$segundos, taxabps1segserver_g_car4$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car5$segundos, taxabps1segserver_g_car5$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_g_car6$segundos, taxabps1segserver_g_car6$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car7$segundos, taxabps1segserver_g_car7$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car8$segundos, taxabps1segserver_g_car8$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car9$segundos, taxabps1segserver_g_car9$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car10$segundos, taxabps1segserver_g_car10$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car11$segundos, taxabps1segserver_g_car11$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_g_car12$segudos, taxabps1segserver_g_car12$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car13$segundos, taxabps1segserver_g_car13$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car14$segundos, taxabps1segserver_g_car14$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car15$segundos, taxabps1segserver_g_car15$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car16$segundos, taxabps1segserver_g_car16$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car17$segundos, taxabps1segserver_g_car17$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car18$segundos, taxabps1segserver_g_car18$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_g_car19$segundos, taxabps1segserver_g_car19$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# legend(240, 2e+06, legend=c("Car transmission", "Server reception"), col=c("blue", "red"), lty=1:2, cex=0.8)



#trafego dos veiculos para server_g


tracecar0_g<-read.table(file = 'car0tf_5005.txt', sep=' ')
names(tracecar0_g)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar0_g$time <- as.POSIXlt(tracecar0_g$time, origin = "1987-10-05 11:00:00")
tracecar0_g$size<- tracecar0_g$size*8
taxabps1segcar0_g<-aggregate(list(size = tracecar0_g$size), list(segundos = cut(tracecar0_g$time, "1 sec")), sum)
taxabps1segcar0_gts<-ts(tracecar0_g$size, frequency = 1)

tracecar1_g<-read.table(file = 'car1tf_5005.txt', sep=' ')
names(tracecar1_g)<-c("time", "id", "size", "ori", "dest" )
tracecar1_g$time <- as.POSIXlt(tracecar1_g$time, origin = "1987-10-05 11:00:00")
tracecar1_g$size<- tracecar1_g$size*8
taxabps1segcar1_g<-aggregate(list(size = tracecar1_g$size), list(segundos = cut(tracecar1_g$time, "1 sec")), sum)
taxabps1segcar1_gts<-ts(tracecar1_g$size, frequency = 1)

tracecar2_g<-read.table(file = 'car2tf_5005.txt', sep=' ')
names(tracecar2_g)<-c("time", "id", "size", "ori", "dest" )
tracecar2_g$time <- as.POSIXlt(tracecar2_g$time, origin = "1987-10-05 11:00:00")
tracecar2_g$size<- tracecar2_g$size*8
taxabps1segcar2_g<-aggregate(list(size = tracecar2_g$size), list(segundos = cut(tracecar2_g$time, "1 sec")), sum)
taxabps1segcar2_gts<-ts(tracecar2_g$size, frequency = 1)

tracecar3_g<-read.table(file = 'car3tf_5005.txt', sep=' ')
names(tracecar3_g)<-c("time", "id", "size", "ori", "dest" )
tracecar3_g$time <- as.POSIXlt(tracecar3_g$time, origin = "1987-10-05 11:00:00")
tracecar3_g$size<- tracecar3_g$size*8
taxabps1segcar3_g<-aggregate(list(size = tracecar3_g$size), list(segundos = cut(tracecar3_g$time, "1 sec")), sum)
taxabps1segcar3_gts<-ts(tracecar3_g$size, frequency = 1)

tracecar4_g<-read.table(file = 'car4tf_5005.txt', sep=' ')
names(tracecar4_g)<-c("time", "id", "size", "ori", "dest" )
tracecar4_g$time <- as.POSIXlt(tracecar4_g$time, origin = "1987-10-05 11:00:00")
tracecar4_g$size<- tracecar4_g$size*8
taxabps1segcar4_g<-aggregate(list(size = tracecar4_g$size), list(segundos = cut(tracecar4_g$time, "1 sec")), sum)
taxabps1segcar4_gts<-ts(tracecar4_g$size, frequency = 1)

tracecar5_g<-read.table(file = 'car5tf_5005.txt', sep=' ')
names(tracecar5_g)<-c("time", "id", "size", "ori", "dest" )
options(digits.secs = 6)
tracecar5_g$time <- as.POSIXlt(tracecar5_g$time, origin = "1987-10-05 11:00:00")
tracecar5_g$size<- tracecar5_g$size*8
taxabps1segcar5_g<-aggregate(list(size = tracecar5_g$size), list(segundos = cut(tracecar5_g$time, "1 sec")), sum)
taxabps1segcar5_gts<-ts(tracecar5_g$size, frequency = 1)

tracecar6_g<-read.table(file = 'car6tf_5005.txt', sep=' ')
names(tracecar6_g)<-c("time", "id", "size", "ori", "dest" )
tracecar6_g$time <- as.POSIXlt(tracecar6_g$time, origin = "1987-10-05 11:00:00")
tracecar6_g$size<- tracecar6_g$size*8
taxabps1segcar6_g<-aggregate(list(size = tracecar6_g$size), list(segundos = cut(tracecar6_g$time, "1 sec")), sum)
taxabps1segcar6_gts<-ts(tracecar6_g$size, frequency = 1)

# tracecar7_g<-read.table(file = 'car7tf_5005.txt', sep=' ')
# names(tracecar7_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar7_g$time <- as.POSIXlt(tracecar7_g$time, origin = "1987-10-05 11:00:00")
# tracecar7_g$size<- tracecar7_g$size*8
# taxabps1segcar7_g<-aggregate(list(size = tracecar7_g$size), list(segundos = cut(tracecar7_g$time, "1 sec")), sum)
# taxabps1segcar7_gts<-ts(tracecar7_g$size, frequency = 1)
# 
# tracecar8_g<-read.table(file = 'car8tf_5005.txt', sep=' ')
# names(tracecar8_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar8_g$time <- as.POSIXlt(tracecar8_g$time, origin = "1987-10-05 11:00:00")
# tracecar8_g$size<- tracecar8_g$size*8
# taxabps1segcar8_g<-aggregate(list(size = tracecar8_g$size), list(segundos = cut(tracecar8_g$time, "1 sec")), sum)
# taxabps1segcar8_gts<-ts(tracecar8_g$size, frequency = 1)
# 
# tracecar9_g<-read.table(file = 'car9tf_5005.txt', sep=' ')
# names(tracecar9_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar9_g$time <- as.POSIXlt(tracecar9_g$time, origin = "1987-10-05 11:00:00")
# tracecar9_g$size<- tracecar9_g$size*8
# taxabps1segcar9_g<-aggregate(list(size = tracecar9_g$size), list(segundos = cut(tracecar9_g$time, "1 sec")), sum)
# taxabps1segcar9_gts<-ts(tracecar9_g$size, frequency = 1)
# 
# tracecar10_g<-read.table(file = 'car10tf_5005.txt', sep=' ')
# names(tracecar10_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar10_g$time <- as.POSIXlt(tracecar10_g$time, origin = "1987-10-05 11:00:00")
# tracecar10_g$size<- tracecar10_g$size*8
# taxabps1segcar10_g<-aggregate(list(size = tracecar10_g$size), list(segundos = cut(tracecar10_g$time, "1 sec")), sum)
# taxabps1segcar10_gts<-ts(tracecar10_g$size, frequency = 1)
# 
# tracecar11_g<-read.table(file = 'car11tf_5005.txt', sep=' ')
# names(tracecar11_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar11_g$time <- as.POSIXlt(tracecar11_g$time, origin = "1987-10-05 11:00:00")
# tracecar11_g$size<- tracecar11_g$size*8
# taxabps1segcar11_g<-aggregate(list(size = tracecar11_g$size), list(segundos = cut(tracecar11_g$time, "1 sec")), sum)
# taxabps1segcar11_gts<-ts(tracecar11_g$size, frequency = 1)

# tracecar12_g<-read.table(file = 'car12tf_5005.txt', sep=' ')
# names(tracecar12_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar12_g$time <- as.POSIXlt(tracecar12_g$time, origin = "1987-10-05 11:00:00")
# tracecar12_g$size<- tracecar12_g$size*8
# taxabps1segcar12_g<-aggregate(list(size = tracecar12_g$size), list(segundos = cut(tracecar12_g$time, "1 sec")), sum)
# taxabps1segcar12_gts<-ts(tracecar12_g$size, frequency = 1)
# 
# tracecar13_g<-read.table(file = 'car13tf_5005.txt', sep=' ')
# names(tracecar13_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar13_g$time <- as.POSIXlt(tracecar13_g$time, origin = "1987-10-05 11:00:00")
# tracecar13_g$size<- tracecar13_g$size*8
# taxabps1segcar13_g<-aggregate(list(size = tracecar13_g$size), list(segundos = cut(tracecar13_g$time, "1 sec")), sum)
# taxabps1segcar13_gts<-ts(tracecar13_g$size, frequency = 1)
# 
# tracecar14_g<-read.table(file = 'car14tf_5005.txt', sep=' ')
# names(tracecar14_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar14_g$time <- as.POSIXlt(tracecar14_g$time, origin = "1987-10-05 11:00:00")
# tracecar14_g$size<- tracecar14_g$size*8
# taxabps1segcar14_g<-aggregate(list(size = tracecar14_g$size), list(segundos = cut(tracecar14_g$time, "1 sec")), sum)
# taxabps1segcar14_gts<-ts(tracecar14_g$size, frequency = 1)
# 
# tracecar15_g<-read.table(file = 'car15tf_5005.txt', sep=' ')
# names(tracecar15_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar15_g$time <- as.POSIXlt(tracecar15_g$time, origin = "1987-10-05 11:00:00")
# tracecar15_g$size<- tracecar15_g$size*8
# taxabps1segcar15_g<-aggregate(list(size = tracecar15_g$size), list(segundos = cut(tracecar15_g$time, "1 sec")), sum)
# taxabps1segcar15_gts<-ts(tracecar15_g$size, frequency = 1)
# 
# tracecar16_g<-read.table(file = 'car16tf_5005.txt', sep=' ')
# names(tracecar16_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar16_g$time <- as.POSIXlt(tracecar16_g$time, origin = "1987-10-05 11:00:00")
# tracecar16_g$size<- tracecar16_g$size*8
# taxabps1segcar16_g<-aggregate(list(size = tracecar16_g$size), list(segundos = cut(tracecar16_g$time, "1 sec")), sum)
# taxabps1segcar16_gts<-ts(tracecar16_g$size, frequency = 1)
# 
# tracecar17_g<-read.table(file = 'car17tf_5005.txt', sep=' ')
# names(tracecar17_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar17_g$time <- as.POSIXlt(tracecar17_g$time, origin = "1987-10-05 11:00:00")
# tracecar17_g$size<- tracecar17_g$size*8
# taxabps1segcar17_g<-aggregate(list(size = tracecar17_g$size), list(segundos = cut(tracecar17_g$time, "1 sec")), sum)
# taxabps1segcar17_gts<-ts(tracecar17_g$size, frequency = 1)
# 
# tracecar18_g<-read.table(file = 'car18tf_5005.txt', sep=' ')
# names(tracecar18_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar18_g$time <- as.POSIXlt(tracecar18_g$time, origin = "1987-10-05 11:00:00")
# tracecar18_g$size<- tracecar18_g$size*8
# taxabps1segcar18_g<-aggregate(list(size = tracecar18_g$size), list(segundos = cut(tracecar18_g$time, "1 sec")), sum)
# taxabps1segcar18_gts<-ts(tracecar18_g$size, frequency = 1)
# 
# tracecar19_g<-read.table(file = 'car19tf_5005.txt', sep=' ')
# names(tracecar19_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar19_g$time <- as.POSIXlt(tracecar19_g$time, origin = "1987-10-05 11:00:00")
# tracecar19_g$size<- tracecar19_g$size*8
# taxabps1segcar19_g<-aggregate(list(size = tracecar19_g$size), list(segundos = cut(tracecar19_g$time, "1 sec")), sum)
# taxabps1segcar19_gts<-ts(tracecar19_g$size, frequency = 1)
# 
# tracecar20_g<-read.table(file = 'car20tf_5005.txt', sep=' ')
# names(tracecar20_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar20_g$time <- as.POSIXlt(tracecar20_g$time, origin = "1987-10-05 11:00:00")
# tracecar20_g$size<- tracecar20_g$size*8
# taxabps1segcar20_g<-aggregate(list(size = tracecar20_g$size), list(segundos = cut(tracecar20_g$time, "1 sec")), sum)
# taxabps1segcar20_gts<-ts(tracecar20_g$size, frequency = 1)
# 
# tracecar21_g<-read.table(file = 'car21tf_5005.txt', sep=' ')
# names(tracecar21_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar21_g$time <- as.POSIXlt(tracecar21_g$time, origin = "1987-10-05 11:00:00")
# tracecar21_g$size<- tracecar21_g$size*8
# taxabps1segcar21_g<-aggregate(list(size = tracecar21_g$size), list(segundos = cut(tracecar21_g$time, "1 sec")), sum)
# taxabps1segcar21_gts<-ts(tracecar21_g$size, frequency = 1)
# 
# tracecar22_g<-read.table(file = 'car22tf_5005.txt', sep=' ')
# names(tracecar22_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar22_g$time <- as.POSIXlt(tracecar22_g$time, origin = "1987-10-05 11:00:00")
# tracecar22_g$size<- tracecar22_g$size*8
# taxabps1segcar22_g<-aggregate(list(size = tracecar22_g$size), list(segundos = cut(tracecar22_g$time, "1 sec")), sum)
# taxabps1segcar22_gts<-ts(tracecar22_g$size, frequency = 1)
# 
# tracecar23_g<-read.table(file = 'car23tf_5005.txt', sep=' ')
# names(tracecar23_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar23_g$time <- as.POSIXlt(tracecar23_g$time, origin = "1987-10-05 11:00:00")
# tracecar23_g$size<- tracecar23_g$size*8
# taxabps1segcar23_g<-aggregate(list(size = tracecar23_g$size), list(segundos = cut(tracecar23_g$time, "1 sec")), sum)
# taxabps1segcar23_gts<-ts(tracecar23_g$size, frequency = 1)
# 
# tracecar24_g<-read.table(file = 'car24tf_5005.txt', sep=' ')
# names(tracecar24_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar24_g$time <- as.POSIXlt(tracecar24_g$time, origin = "1987-10-05 11:00:00")
# tracecar24_g$size<- tracecar24_g$size*8
# taxabps1segcar24_g<-aggregate(list(size = tracecar24_g$size), list(segundos = cut(tracecar24_g$time, "1 sec")), sum)
# taxabps1segcar24_gts<-ts(tracecar24_g$size, frequency = 1)
# 
# tracecar25_g<-read.table(file = 'car25tf_5005.txt', sep=' ')
# names(tracecar25_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar25_g$time <- as.POSIXlt(tracecar25_g$time, origin = "1987-10-05 11:00:00")
# tracecar25_g$size<- tracecar25_g$size*8
# taxabps1segcar25_g<-aggregate(list(size = tracecar25_g$size), list(segundos = cut(tracecar25_g$time, "1 sec")), sum)
# taxabps1segcar25_gts<-ts(tracecar25_g$size, frequency = 1)
# 
# tracecar26_g<-read.table(file = 'car26tf_5005.txt', sep=' ')
# names(tracecar26_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar26_g$time <- as.POSIXlt(tracecar26_g$time, origin = "1987-10-05 11:00:00")
# tracecar26_g$size<- tracecar26_g$size*8
# taxabps1segcar26_g<-aggregate(list(size = tracecar26_g$size), list(segundos = cut(tracecar26_g$time, "1 sec")), sum)
# taxabps1segcar26_gts<-ts(tracecar26_g$size, frequency = 1)
# 
# tracecar27_g<-read.table(file = 'car27tf_5005.txt', sep=' ')
# names(tracecar27_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar27_g$time <- as.POSIXlt(tracecar27_g$time, origin = "1987-10-05 11:00:00")
# tracecar27_g$size<- tracecar27_g$size*8
# taxabps1segcar27_g<-aggregate(list(size = tracecar27_g$size), list(segundos = cut(tracecar27_g$time, "1 sec")), sum)
# taxabps1segcar27_gts<-ts(tracecar27_g$size, frequency = 1)
# 
# tracecar28_g<-read.table(file = 'car28tf_5005.txt', sep=' ')
# names(tracecar28_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar28_g$time <- as.POSIXlt(tracecar28_g$time, origin = "1987-10-05 11:00:00")
# tracecar28_g$size<- tracecar28_g$size*8
# taxabps1segcar28_g<-aggregate(list(size = tracecar28_g$size), list(segundos = cut(tracecar28_g$time, "1 sec")), sum)
# taxabps1segcar28_gts<-ts(tracecar28_g$size, frequency = 1)
# 
# tracecar29_g<-read.table(file = 'car29tf_5005.txt', sep=' ')
# names(tracecar29_g)<-c("time", "id", "size", "ori", "dest" )
# tracecar29_g$time <- as.POSIXlt(tracecar29_g$time, origin = "1987-10-05 11:00:00")
# tracecar29_g$size<- tracecar29_g$size*8
# taxabps1segcar29_g<-aggregate(list(size = tracecar29_g$size), list(segundos = cut(tracecar29_g$time, "1 sec")), sum)
# taxabps1segcar29_gts<-ts(tracecar29_g$size, frequency = 1)


tracedelay_g0<-read.table(file = 'delay0_g.txt')
delay_g0<-append(list(delay = tracedelay_g0$V1), list(time = c(1:length(tracedelay_g0$V1))))

tracedelay_g1<-read.table(file = 'delay1_g.txt')
delay_g1<-append(list(delay = tracedelay_g1$V1), list(time = c(1:length(tracedelay_g1$V1))))

tracedelay_g2<-read.table(file = 'delay2_g.txt')
delay_g2<-append(list(delay = tracedelay_g2$V1), list(time = c(1:length(tracedelay_g2$V1))))

tracedelay_g3<-read.table(file = 'delay3_g.txt')
delay_g3<-append(list(delay = tracedelay_g3$V1), list(time = c(1:length(tracedelay_g3$V1))))

tracedelay_g4<-read.table(file = 'delay4_g.txt')
delay_g4<-append(list(delay = tracedelay_g4$V1), list(time = c(1:length(tracedelay_g4$V1))))

tracedelay_g5<-read.table(file = 'delay5_g.txt')
delay_g5<-append(list(delay = tracedelay_g5$V1), list(time = c(1:length(tracedelay_g5$V1))))

tracedelay_g6<-read.table(file = 'delay6_g.txt')
delay_g6<-append(list(delay = tracedelay_g6$V1), list(time = c(1:length(tracedelay_g6$V1))))

ctime_g<-c(0:299)
#tt<-c(taxabps1segcar0_g$size[1:195], taxabps1segcar1_g$size[1:195], taxabps1segcar2_g$size[1:195], taxabps1segcar3_g$size[1:195], taxabps1segcar4_g$size[1:195], taxabps1segcar5_g$size[1:195], taxabps1segcar6_g$size[1:195], taxabps1segcar7_g$size[1:195], taxabps1segcar8_g$size[1:195], taxabps1segcar9_g$size[1:195], taxabps1segcar10_g$size[1:195], taxabps1segcar11_g$size[1:195], taxabps1segcar12_g$size[1:195], taxabps1segcar13_g$size[1:195], taxabps1segcar14_g$size[1:195], taxabps1segcar15_g$size[1:195], taxabps1segcar16_g$size[1:195], taxabps1segcar17_g$size[1:195], taxabps1segcar18_g$size[1:195], taxabps1segcar19_g$size[1:195])
cartotal_g<-c(taxabps1segcar0_g$size[1:300], taxabps1segcar1_g$size[1:300], taxabps1segcar2_g$size[1:300], taxabps1segcar3_g$size[1:300], taxabps1segcar4_g$size[1:300], taxabps1segcar5_g$size[1:300], taxabps1segcar6_g$size[1:300])
carmean_g<-c(taxabps1segcar0_g$size[1:300] + taxabps1segcar1_g$size[1:300] + taxabps1segcar2_g$size[1:300] + taxabps1segcar3_g$size[1:300] + taxabps1segcar4_g$size[1:300] + taxabps1segcar5_g$size[1:300] + taxabps1segcar6_g$size[1:300])/7
fctime_g<-c(ctime, ctime, ctime, ctime, ctime, ctime, ctime)

stime_g<-c(0:299)
#tt<-c(taxabps1segserver_g_car0$size[1:195], taxabps1segserver_g_car1$size[1:195], taxabps1segserver_g_car2$size[1:195], taxabps1segserver_g_car3$size[1:195], taxabps1segserver_g_car4$size[1:195], taxabps1segserver_g_car5$size[1:195], taxabps1segserver_g_car6$size[1:195], taxabps1segserver_g_car7$size[1:195], taxabps1segserver_g_car8$size[1:195], taxabps1segserver_g_car9$size[1:195], taxabps1segserver_g_car10$size[1:195], taxabps1segserver_g_car11$size[1:195], taxabps1segserver_g_car12$size[1:195], taxabps1segserver_g_car13$size[1:195], taxabps1segserver_g_car14$size[1:195], taxabps1segserver_g_car15$size[1:195], taxabps1segserver_g_car16$size[1:195], taxabps1segserver_g_car17$size[1:195], taxabps1segserver_g_car18$size[1:195], taxabps1segserver_g_car19$size[1:195])
servertotal_g<-c(taxabps1segserver_g_car0$size[1:300], taxabps1segserver_g_car1$size[1:300], taxabps1segserver_g_car2$size[1:300], taxabps1segserver_g_car3$size[1:300], taxabps1segserver_g_car4$size[1:300], taxabps1segserver_g_car5$size[1:300], taxabps1segserver_g_car6$size[1:300])
servermean_g<-c(taxabps1segserver_g_car0$size[1:300] + taxabps1segserver_g_car1$size[1:300] + taxabps1segserver_g_car2$size[1:300] + taxabps1segserver_g_car3$size[1:300] + taxabps1segserver_g_car4$size[1:300] + taxabps1segserver_g_car5$size[1:300] + taxabps1segserver_g_car6$size[1:300])/7
fstime_g<-c(stime_g, stime_g, stime_g, stime_g, stime_g, stime_g, stime_g)

dtime_g<-c(0:299)
delaytotal_g<-c(delay_g0$delay[1:300], delay_g1$delay[1:300], delay_g2$delay[1:300], delay_g3$delay[1:300], delay_g4$delay[1:300], delay_g5$delay[1:300], delay_g6$delay[1:300])
delaymean_g<-c(delay_g0$delay[1:300] + delay_g1$delay[1:300] + delay_g2$delay[1:300] + delay_g3$delay[1:300] + delay_g4$delay[1:300] + delay_g5$delay[1:300] + delay_g6$delay[1:300])/7
fdtime_g<-c(dtime_g, dtime_g, dtime_g, dtime_g, dtime_g, dtime_g, dtime_g)

require(Rmisc)
x1<- cbind(fctime_g,cartotal_g)
x1<-data.frame(x1)
y1<-group.CI(cartotal_g~fctime_g,x1,ci = 0.95)

x2<- cbind(fstime_g,servertotal_g)
x2<-data.frame(x2)
y2<-group.CI(servertotal_g~fstime_g,x2,ci = 0.95)

x3<- cbind(fdtime_g,delaytotal_g)
x3<-data.frame(x3)
y3<-group.CI(delaytotal_g~fdtime_g,x3,ci = 0.95)


require(plotrix)

par(mar = c(5,5,2,5))

plotCI(ctime_g, carmean_g, ui=y1$cartotal_g.upper, li=y1$cartotal_g.lower, col="red", main="Server G", ylab = "Throughput (bps)", xlab = "time(s)", ylim = range(0:1e+06) )
lines(ctime_g,carmean_g, type = "l", col="black", lwd="2")

par(new=T)
plotCI(stime_g, servermean_g, ui=y2$servertotal_g.upper, li=y2$servertotal_g.lower, col="blue", axes=F, xlab=NA, ylab=NA, ylim = range(0:1e+06) )
lines(stime_g,servermean_g, type = "l", col="black", lwd="2")

par(new = T)
plotCI(dtime_g[2:300], delaymean_g[2:300], ui=y3$delaytotal_g.upper[2:300], li=y3$delaytotal_g.lower[2:300], col="orange", axes=F, xlab=NA, ylab=NA, ylim = range(0:50))
lines(dtime_g[2:300],delaymean_g[2:300], type = "l", col="black", lwd="2")
axis(side = 4)
mtext(side = 4, line = 3, 'Delay (ms)')
legend("topleft",
       legend=c("Server received", "Car Sent", "Delay"),
       lty=c(1,1,1), col=c("blue", "red", "orange"))
