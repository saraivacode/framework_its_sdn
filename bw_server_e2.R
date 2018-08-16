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

traceserver_e2_car7<-read.table(file = 'server_e2tf_car7.txt', sep=' ')
names(traceserver_e2_car7)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car7$time <- as.POSIXlt(traceserver_e2_car7$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car7$size<- traceserver_e2_car7$size*8
taxabps1segserver_e2_car7<-aggregate(list(size = traceserver_e2_car7$size), list(segundos = cut(traceserver_e2_car7$time, "1 sec")), sum)
taxabps1segserverts_e2_car7<-ts(traceserver_e2_car7$size, frequency = 1)

traceserver_e2_car8<-read.table(file = 'server_e2tf_car8.txt', sep=' ')
names(traceserver_e2_car8)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car8$time <- as.POSIXlt(traceserver_e2_car8$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car8$size<- traceserver_e2_car8$size*8
taxabps1segserver_e2_car8<-aggregate(list(size = traceserver_e2_car8$size), list(segundos = cut(traceserver_e2_car8$time, "1 sec")), sum)
taxabps1segserverts_e2_car8<-ts(traceserver_e2_car8$size, frequency = 1)

traceserver_e2_car9<-read.table(file = 'server_e2tf_car9.txt', sep=' ')
names(traceserver_e2_car9)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car9$time <- as.POSIXlt(traceserver_e2_car9$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car9$size<- traceserver_e2_car9$size*8
taxabps1segserver_e2_car9<-aggregate(list(size = traceserver_e2_car9$size), list(segundos = cut(traceserver_e2_car9$time, "1 sec")), sum)
taxabps1segserverts_e2_car9<-ts(traceserver_e2_car9$size, frequency = 1)

traceserver_e2_car10<-read.table(file = 'server_e2tf_car10.txt', sep=' ')
names(traceserver_e2_car10)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car10$time <- as.POSIXlt(traceserver_e2_car10$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car10$size<- traceserver_e2_car10$size*8
taxabps1segserver_e2_car10<-aggregate(list(size = traceserver_e2_car10$size), list(segundos = cut(traceserver_e2_car10$time, "1 sec")), sum)
taxabps1segserverts_e2_car10<-ts(traceserver_e2_car10$size, frequency = 1)

traceserver_e2_car11<-read.table(file = 'server_e2tf_car11.txt', sep=' ')
names(traceserver_e2_car11)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_car11$time <- as.POSIXlt(traceserver_e2_car11$time, origin = "1987-10-05 11:00:00")
traceserver_e2_car11$size<- traceserver_e2_car11$size*8
taxabps1segserver_e2_car11<-aggregate(list(size = traceserver_e2_car11$size), list(segundos = cut(traceserver_e2_car11$time, "1 sec")), sum)
taxabps1segserverts_e2_car11<-ts(traceserver_e2_car11$size, frequency = 1)

# traceserver_e2_car12<-read.table(file = 'server_e2tf_car12.txt', sep=' ')
# names(traceserver_e2_car12)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car12$time <- as.POSIXlt(traceserver_e2_car12$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car12$size<- traceserver_e2_car12$size*8
# taxabps1segserver_e2_car12<-aggregate(list(size = traceserver_e2_car12$size), list(segundos = cut(traceserver_e2_car12$time, "1 sec")), sum)
# taxabps1segserverts_e2_car12<-ts(traceserver_e2_car12$size, frequency = 1)
# 
# traceserver_e2_car13<-read.table(file = 'server_e2tf_car13.txt', sep=' ')
# names(traceserver_e2_car13)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car13$time <- as.POSIXlt(traceserver_e2_car13$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car13$size<- traceserver_e2_car13$size*8
# taxabps1segserver_e2_car13<-aggregate(list(size = traceserver_e2_car13$size), list(segundos = cut(traceserver_e2_car13$time, "1 sec")), sum)
# taxabps1segserverts_e2_car13<-ts(traceserver_e2_car13$size, frequency = 1)
# 
# traceserver_e2_car14<-read.table(file = 'server_e2tf_car14.txt', sep=' ')
# names(traceserver_e2_car14)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car14$time <- as.POSIXlt(traceserver_e2_car14$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car14$size<- traceserver_e2_car14$size*8
# taxabps1segserver_e2_car14<-aggregate(list(size = traceserver_e2_car14$size), list(segundos = cut(traceserver_e2_car14$time, "1 sec")), sum)
# taxabps1segserverts_e2_car14<-ts(traceserver_e2_car14$size, frequency = 1)
# 
# traceserver_e2_car15<-read.table(file = 'server_e2tf_car15.txt', sep=' ')
# names(traceserver_e2_car15)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car15$time <- as.POSIXlt(traceserver_e2_car15$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car15$size<- traceserver_e2_car15$size*8
# taxabps1segserver_e2_car15<-aggregate(list(size = traceserver_e2_car15$size), list(segundos = cut(traceserver_e2_car15$time, "1 sec")), sum)
# taxabps1segserverts_e2_car15<-ts(traceserver_e2_car15$size, frequency = 1)
# 
# traceserver_e2_car16<-read.table(file = 'server_e2tf_car16.txt', sep=' ')
# names(traceserver_e2_car16)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car16$time <- as.POSIXlt(traceserver_e2_car16$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car16$size<- traceserver_e2_car16$size*8
# taxabps1segserver_e2_car16<-aggregate(list(size = traceserver_e2_car16$size), list(segundos = cut(traceserver_e2_car16$time, "1 sec")), sum)
# taxabps1segserverts_e2_car16<-ts(traceserver_e2_car16$size, frequency = 1)
# 
# traceserver_e2_car17<-read.table(file = 'server_e2tf_car17.txt', sep=' ')
# names(traceserver_e2_car17)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car17$time <- as.POSIXlt(traceserver_e2_car17$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car17$size<- traceserver_e2_car17$size*8
# taxabps1segserver_e2_car17<-aggregate(list(size = traceserver_e2_car17$size), list(segundos = cut(traceserver_e2_car17$time, "1 sec")), sum)
# taxabps1segserverts_e2_car17<-ts(traceserver_e2_car17$size, frequency = 1)
# 
# traceserver_e2_car18<-read.table(file = 'server_e2tf_car18.txt', sep=' ')
# names(traceserver_e2_car18)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car18$time <- as.POSIXlt(traceserver_e2_car18$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car18$size<- traceserver_e2_car18$size*8
# taxabps1segserver_e2_car18<-aggregate(list(size = traceserver_e2_car18$size), list(segundos = cut(traceserver_e2_car18$time, "1 sec")), sum)
# taxabps1segserverts_e2_car18<-ts(traceserver_e2_car18$size, frequency = 1)
# 
# traceserver_e2_car19<-read.table(file = 'server_e2tf_car19.txt', sep=' ')
# names(traceserver_e2_car19)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car19$time <- as.POSIXlt(traceserver_e2_car19$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car19$size<- traceserver_e2_car19$size*8
# taxabps1segserver_e2_car19<-aggregate(list(size = traceserver_e2_car19$size), list(segundos = cut(traceserver_e2_car19$time, "1 sec")), sum)
# taxabps1segserverts_e2_car19<-ts(traceserver_e2_car19$size, frequency = 1)
# 
# traceserver_e2_car20<-read.table(file = 'server_e2tf_car20.txt', sep=' ')
# names(traceserver_e2_car20)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car20$time <- as.POSIXlt(traceserver_e2_car20$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car20$size<- traceserver_e2_car20$size*8
# taxabps1segserver_e2_car20<-aggregate(list(size = traceserver_e2_car20$size), list(segundos = cut(traceserver_e2_car20$time, "1 sec")), sum)
# taxabps1segserverts_e2_car20<-ts(traceserver_e2_car20$size, frequency = 1)
# 
# traceserver_e2_car21<-read.table(file = 'server_e2tf_car21.txt', sep=' ')
# names(traceserver_e2_car21)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car21$time <- as.POSIXlt(traceserver_e2_car21$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car21$size<- traceserver_e2_car21$size*8
# taxabps1segserver_e2_car21<-aggregate(list(size = traceserver_e2_car21$size), list(segundos = cut(traceserver_e2_car21$time, "1 sec")), sum)
# taxabps1segserverts_e2_car21<-ts(traceserver_e2_car21$size, frequency = 1)
# 
# traceserver_e2_car22<-read.table(file = 'server_e2tf_car22.txt', sep=' ')
# names(traceserver_e2_car22)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car22$time <- as.POSIXlt(traceserver_e2_car22$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car22$size<- traceserver_e2_car22$size*8
# taxabps1segserver_e2_car22<-aggregate(list(size = traceserver_e2_car22$size), list(segundos = cut(traceserver_e2_car22$time, "1 sec")), sum)
# taxabps1segserverts_e2_car22<-ts(traceserver_e2_car22$size, frequency = 1)
# 
# traceserver_e2_car23-read.table(file = 'server_e2tf_car23.txt', sep=' ')
# names(traceserver_e2_car23)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car23$time <- as.POSIXlt(traceserver_e2_car23$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car23$size<- traceserver_e2_car23$size*8
# taxabps1segserver_e2_car23<-aggregate(list(size = traceserver_e2_car23$size), list(segundos = cut(traceserver_e2_car23$time, "1 sec")), sum)
# taxabps1segserverts_e2_car23<-ts(traceserver_e2_car23$size, frequency = 1)
# 
# traceserver_e2_car24<-read.table(file = 'server_e2tf_car24.txt', sep=' ')
# names(traceserver_e2_car24)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car24$time <- as.POSIXlt(traceserver_e2_car24$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car24$size<- traceserver_e2_car24$size*8
# taxabps1segserver_e2_car24<-aggregate(list(size = traceserver_e2_car24$size), list(segundos = cut(traceserver_e2_car24$time, "1 sec")), sum)
# taxabps1segserverts_e2_car24<-ts(traceserver_e2_car24$size, frequency = 1)
# 
# traceserver_e2_car25<-read.table(file = 'server_e2tf_car25.txt', sep=' ')
# names(traceserver_e2_car25)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car25$time <- as.POSIXlt(traceserver_e2_car25$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car25$size<- traceserver_e2_car25$size*8
# taxabps1segserver_e2_car25<-aggregate(list(size = traceserver_e2_car25$size), list(segundos = cut(traceserver_e2_car25$time, "1 sec")), sum)
# taxabps1segserverts_e2_car25<-ts(traceserver_e2_car25$size, frequency = 1)
# 
# traceserver_e2_car26<-read.table(file = 'server_e2tf_car26.txt', sep=' ')
# names(traceserver_e2_car26)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car26$time <- as.POSIXlt(traceserver_e2_car26$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car26$size<- traceserver_e2_car26$size*8
# taxabps1segserver_e2_car26<-aggregate(list(size = traceserver_e2_car26$size), list(segundos = cut(traceserver_e2_car26$time, "1 sec")), sum)
# taxabps1segserverts_e2_car26<-ts(traceserver_e2_car26$size, frequency = 1)
# 
# traceserver_e2_car27<-read.table(file = 'server_e2tf_car27.txt', sep=' ')
# names(traceserver_e2_car27)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car27$time <- as.POSIXlt(traceserver_e2_car27$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car27$size<- traceserver_e2_car27$size*8
# taxabps1segserver_e2_car27<-aggregate(list(size = traceserver_e2_car27$size), list(segundos = cut(traceserver_e2_car27$time, "1 sec")), sum)
# taxabps1segserverts_e2_car27<-ts(traceserver_e2_car27$size, frequency = 1)
# 
# traceserver_e2_car28<-read.table(file = 'server_e2tf_car28.txt', sep=' ')
# names(traceserver_e2_car28)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car28$time <- as.POSIXlt(traceserver_e2_car28$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car28$size<- traceserver_e2_car28$size*8
# taxabps1segserver_e2_car28<-aggregate(list(size = traceserver_e2_car28$size), list(segundos = cut(traceserver_e2_car28$time, "1 sec")), sum)
# taxabps1segserverts_e2_car28<-ts(traceserver_e2_car28$size, frequency = 1)
# 
# traceserver_e2_car29<-read.table(file = 'server_e2tf_car29.txt', sep=' ')
# names(traceserver_e2_car29)<-c("time", "id", "size", "ori", "dest" )
# traceserver_e2_car29$time <- as.POSIXlt(traceserver_e2_car29$time, origin = "1987-10-05 11:00:00")
# traceserver_e2_car29$size<- traceserver_e2_car29$size*8
# taxabps1segserver_e2_car29<-aggregate(list(size = traceserver_e2_car29$size), list(segundos = cut(traceserver_e2_car29$time, "1 sec")), sum)
# taxabps1segserverts_e2_car19<-ts(traceserver_e2_car19$size, frequency = 1)
# 
# plot(c(1:length(taxabps1segserver_e2_car0$size)), taxabps1segserver_e2_car0$size, main="Server E", ylab='bits/s', xlab='time(s)', type = "l", col="blue")
# lines(c(1:length(taxabps1segserver_e2_car1$size)), taxabps1segserver_e2_car1$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car2$segundos, taxabps1segserver_e2_car2$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car3$segundos, taxabps1segserver_e2_car3$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car4$segundos, taxabps1segserver_e2_car4$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car5$segundos, taxabps1segserver_e2_car5$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_e2_car6$segundos, taxabps1segserver_e2_car6$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car7$segundos, taxabps1segserver_e2_car7$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car8$segundos, taxabps1segserver_e2_car8$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car9$segundos, taxabps1segserver_e2_car9$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car10$segundos, taxabps1segserver_e2_car10$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car11$segundos, taxabps1segserver_e2_car11$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# # lines(taxabps1segserver_e2_car12$segudos, taxabps1segserver_e2_car12$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car13$segundos, taxabps1segserver_e2_car13$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car14$segundos, taxabps1segserver_e2_car14$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car15$segundos, taxabps1segserver_e2_car15$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car16$segundos, taxabps1segserver_e2_car16$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car17$segundos, taxabps1segserver_e2_car17$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car18$segundos, taxabps1segserver_e2_car18$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# lines(taxabps1segserver_e2_car19$segundos, taxabps1segserver_e2_car19$size, main="Server reception (bits/s)", ylab='bits/s', xlab='time(s)', col="red")
# legend(240, 2e+06, legend=c("Car transmission", "Server reception"), col=c("blue", "red"), lty=1:2, cex=0.8)



#trafego dos veiculos para server_e2


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

tracecar7_e2<-read.table(file = 'car7tf_5004.txt', sep=' ')
names(tracecar7_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar7_e2$time <- as.POSIXlt(tracecar7_e2$time, origin = "1987-10-05 11:00:00")
tracecar7_e2$size<- tracecar7_e2$size*8
taxabps1segcar7_e2<-aggregate(list(size = tracecar7_e2$size), list(segundos = cut(tracecar7_e2$time, "1 sec")), sum)
taxabps1segcar7_e2ts<-ts(tracecar7_e2$size, frequency = 1)

tracecar8_e2<-read.table(file = 'car8tf_5004.txt', sep=' ')
names(tracecar8_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar8_e2$time <- as.POSIXlt(tracecar8_e2$time, origin = "1987-10-05 11:00:00")
tracecar8_e2$size<- tracecar8_e2$size*8
taxabps1segcar8_e2<-aggregate(list(size = tracecar8_e2$size), list(segundos = cut(tracecar8_e2$time, "1 sec")), sum)
taxabps1segcar8_e2ts<-ts(tracecar8_e2$size, frequency = 1)

tracecar9_e2<-read.table(file = 'car9tf_5004.txt', sep=' ')
names(tracecar9_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar9_e2$time <- as.POSIXlt(tracecar9_e2$time, origin = "1987-10-05 11:00:00")
tracecar9_e2$size<- tracecar9_e2$size*8
taxabps1segcar9_e2<-aggregate(list(size = tracecar9_e2$size), list(segundos = cut(tracecar9_e2$time, "1 sec")), sum)
taxabps1segcar9_e2ts<-ts(tracecar9_e2$size, frequency = 1)

tracecar10_e2<-read.table(file = 'car10tf_5004.txt', sep=' ')
names(tracecar10_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar10_e2$time <- as.POSIXlt(tracecar10_e2$time, origin = "1987-10-05 11:00:00")
tracecar10_e2$size<- tracecar10_e2$size*8
taxabps1segcar10_e2<-aggregate(list(size = tracecar10_e2$size), list(segundos = cut(tracecar10_e2$time, "1 sec")), sum)
taxabps1segcar10_e2ts<-ts(tracecar10_e2$size, frequency = 1)

tracecar11_e2<-read.table(file = 'car11tf_5004.txt', sep=' ')
names(tracecar11_e2)<-c("time", "id", "size", "ori", "dest" )
tracecar11_e2$time <- as.POSIXlt(tracecar11_e2$time, origin = "1987-10-05 11:00:00")
tracecar11_e2$size<- tracecar11_e2$size*8
taxabps1segcar11_e2<-aggregate(list(size = tracecar11_e2$size), list(segundos = cut(tracecar11_e2$time, "1 sec")), sum)
taxabps1segcar11_e2ts<-ts(tracecar11_e2$size, frequency = 1)

# tracecar12_e2<-read.table(file = 'car12tf_5004.txt', sep=' ')
# names(tracecar12_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar12_e2$time <- as.POSIXlt(tracecar12_e2$time, origin = "1987-10-05 11:00:00")
# tracecar12_e2$size<- tracecar12_e2$size*8
# taxabps1segcar12_e2<-aggregate(list(size = tracecar12_e2$size), list(segundos = cut(tracecar12_e2$time, "1 sec")), sum)
# taxabps1segcar12_e2ts<-ts(tracecar12_e2$size, frequency = 1)
# 
# tracecar13_e2<-read.table(file = 'car13tf_5004.txt', sep=' ')
# names(tracecar13_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar13_e2$time <- as.POSIXlt(tracecar13_e2$time, origin = "1987-10-05 11:00:00")
# tracecar13_e2$size<- tracecar13_e2$size*8
# taxabps1segcar13_e2<-aggregate(list(size = tracecar13_e2$size), list(segundos = cut(tracecar13_e2$time, "1 sec")), sum)
# taxabps1segcar13_e2ts<-ts(tracecar13_e2$size, frequency = 1)
# 
# tracecar14_e2<-read.table(file = 'car14tf_5004.txt', sep=' ')
# names(tracecar14_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar14_e2$time <- as.POSIXlt(tracecar14_e2$time, origin = "1987-10-05 11:00:00")
# tracecar14_e2$size<- tracecar14_e2$size*8
# taxabps1segcar14_e2<-aggregate(list(size = tracecar14_e2$size), list(segundos = cut(tracecar14_e2$time, "1 sec")), sum)
# taxabps1segcar14_e2ts<-ts(tracecar14_e2$size, frequency = 1)
# 
# tracecar15_e2<-read.table(file = 'car15tf_5004.txt', sep=' ')
# names(tracecar15_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar15_e2$time <- as.POSIXlt(tracecar15_e2$time, origin = "1987-10-05 11:00:00")
# tracecar15_e2$size<- tracecar15_e2$size*8
# taxabps1segcar15_e2<-aggregate(list(size = tracecar15_e2$size), list(segundos = cut(tracecar15_e2$time, "1 sec")), sum)
# taxabps1segcar15_e2ts<-ts(tracecar15_e2$size, frequency = 1)
# 
# tracecar16_e2<-read.table(file = 'car16tf_5004.txt', sep=' ')
# names(tracecar16_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar16_e2$time <- as.POSIXlt(tracecar16_e2$time, origin = "1987-10-05 11:00:00")
# tracecar16_e2$size<- tracecar16_e2$size*8
# taxabps1segcar16_e2<-aggregate(list(size = tracecar16_e2$size), list(segundos = cut(tracecar16_e2$time, "1 sec")), sum)
# taxabps1segcar16_e2ts<-ts(tracecar16_e2$size, frequency = 1)
# 
# tracecar17_e2<-read.table(file = 'car17tf_5004.txt', sep=' ')
# names(tracecar17_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar17_e2$time <- as.POSIXlt(tracecar17_e2$time, origin = "1987-10-05 11:00:00")
# tracecar17_e2$size<- tracecar17_e2$size*8
# taxabps1segcar17_e2<-aggregate(list(size = tracecar17_e2$size), list(segundos = cut(tracecar17_e2$time, "1 sec")), sum)
# taxabps1segcar17_e2ts<-ts(tracecar17_e2$size, frequency = 1)
# 
# tracecar18_e2<-read.table(file = 'car18tf_5004.txt', sep=' ')
# names(tracecar18_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar18_e2$time <- as.POSIXlt(tracecar18_e2$time, origin = "1987-10-05 11:00:00")
# tracecar18_e2$size<- tracecar18_e2$size*8
# taxabps1segcar18_e2<-aggregate(list(size = tracecar18_e2$size), list(segundos = cut(tracecar18_e2$time, "1 sec")), sum)
# taxabps1segcar18_e2ts<-ts(tracecar18_e2$size, frequency = 1)
# 
# tracecar19_e2<-read.table(file = 'car19tf_5004.txt', sep=' ')
# names(tracecar19_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar19_e2$time <- as.POSIXlt(tracecar19_e2$time, origin = "1987-10-05 11:00:00")
# tracecar19_e2$size<- tracecar19_e2$size*8
# taxabps1segcar19_e2<-aggregate(list(size = tracecar19_e2$size), list(segundos = cut(tracecar19_e2$time, "1 sec")), sum)
# taxabps1segcar19_e2ts<-ts(tracecar19_e2$size, frequency = 1)
# 
# tracecar20_e2<-read.table(file = 'car20tf_5004.txt', sep=' ')
# names(tracecar20_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar20_e2$time <- as.POSIXlt(tracecar20_e2$time, origin = "1987-10-05 11:00:00")
# tracecar20_e2$size<- tracecar20_e2$size*8
# taxabps1segcar20_e2<-aggregate(list(size = tracecar20_e2$size), list(segundos = cut(tracecar20_e2$time, "1 sec")), sum)
# taxabps1segcar20_e2ts<-ts(tracecar20_e2$size, frequency = 1)
# 
# tracecar21_e2<-read.table(file = 'car21tf_5004.txt', sep=' ')
# names(tracecar21_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar21_e2$time <- as.POSIXlt(tracecar21_e2$time, origin = "1987-10-05 11:00:00")
# tracecar21_e2$size<- tracecar21_e2$size*8
# taxabps1segcar21_e2<-aggregate(list(size = tracecar21_e2$size), list(segundos = cut(tracecar21_e2$time, "1 sec")), sum)
# taxabps1segcar21_e2ts<-ts(tracecar21_e2$size, frequency = 1)
# 
# tracecar22_e2<-read.table(file = 'car22tf_5004.txt', sep=' ')
# names(tracecar22_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar22_e2$time <- as.POSIXlt(tracecar22_e2$time, origin = "1987-10-05 11:00:00")
# tracecar22_e2$size<- tracecar22_e2$size*8
# taxabps1segcar22_e2<-aggregate(list(size = tracecar22_e2$size), list(segundos = cut(tracecar22_e2$time, "1 sec")), sum)
# taxabps1segcar22_e2ts<-ts(tracecar22_e2$size, frequency = 1)
# 
# tracecar23_e2<-read.table(file = 'car23tf_5004.txt', sep=' ')
# names(tracecar23_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar23_e2$time <- as.POSIXlt(tracecar23_e2$time, origin = "1987-10-05 11:00:00")
# tracecar23_e2$size<- tracecar23_e2$size*8
# taxabps1segcar23_e2<-aggregate(list(size = tracecar23_e2$size), list(segundos = cut(tracecar23_e2$time, "1 sec")), sum)
# taxabps1segcar23_e2ts<-ts(tracecar23_e2$size, frequency = 1)
# 
# tracecar24_e2<-read.table(file = 'car24tf_5004.txt', sep=' ')
# names(tracecar24_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar24_e2$time <- as.POSIXlt(tracecar24_e2$time, origin = "1987-10-05 11:00:00")
# tracecar24_e2$size<- tracecar24_e2$size*8
# taxabps1segcar24_e2<-aggregate(list(size = tracecar24_e2$size), list(segundos = cut(tracecar24_e2$time, "1 sec")), sum)
# taxabps1segcar24_e2ts<-ts(tracecar24_e2$size, frequency = 1)
# 
# tracecar25_e2<-read.table(file = 'car25tf_5004.txt', sep=' ')
# names(tracecar25_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar25_e2$time <- as.POSIXlt(tracecar25_e2$time, origin = "1987-10-05 11:00:00")
# tracecar25_e2$size<- tracecar25_e2$size*8
# taxabps1segcar25_e2<-aggregate(list(size = tracecar25_e2$size), list(segundos = cut(tracecar25_e2$time, "1 sec")), sum)
# taxabps1segcar25_e2ts<-ts(tracecar25_e2$size, frequency = 1)
# 
# tracecar26_e2<-read.table(file = 'car26tf_5004.txt', sep=' ')
# names(tracecar26_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar26_e2$time <- as.POSIXlt(tracecar26_e2$time, origin = "1987-10-05 11:00:00")
# tracecar26_e2$size<- tracecar26_e2$size*8
# taxabps1segcar26_e2<-aggregate(list(size = tracecar26_e2$size), list(segundos = cut(tracecar26_e2$time, "1 sec")), sum)
# taxabps1segcar26_e2ts<-ts(tracecar26_e2$size, frequency = 1)
# 
# tracecar27_e2<-read.table(file = 'car27tf_5004.txt', sep=' ')
# names(tracecar27_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar27_e2$time <- as.POSIXlt(tracecar27_e2$time, origin = "1987-10-05 11:00:00")
# tracecar27_e2$size<- tracecar27_e2$size*8
# taxabps1segcar27_e2<-aggregate(list(size = tracecar27_e2$size), list(segundos = cut(tracecar27_e2$time, "1 sec")), sum)
# taxabps1segcar27_e2ts<-ts(tracecar27_e2$size, frequency = 1)
# 
# tracecar28_e2<-read.table(file = 'car28tf_5004.txt', sep=' ')
# names(tracecar28_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar28_e2$time <- as.POSIXlt(tracecar28_e2$time, origin = "1987-10-05 11:00:00")
# tracecar28_e2$size<- tracecar28_e2$size*8
# taxabps1segcar28_e2<-aggregate(list(size = tracecar28_e2$size), list(segundos = cut(tracecar28_e2$time, "1 sec")), sum)
# taxabps1segcar28_e2ts<-ts(tracecar28_e2$size, frequency = 1)
# 
# tracecar29_e2<-read.table(file = 'car29tf_5004.txt', sep=' ')
# names(tracecar29_e2)<-c("time", "id", "size", "ori", "dest" )
# tracecar29_e2$time <- as.POSIXlt(tracecar29_e2$time, origin = "1987-10-05 11:00:00")
# tracecar29_e2$size<- tracecar29_e2$size*8
# taxabps1segcar29_e2<-aggregate(list(size = tracecar29_e2$size), list(segundos = cut(tracecar29_e2$time, "1 sec")), sum)
# taxabps1segcar29_e2ts<-ts(tracecar29_e2$size, frequency = 1)

ttime<-c(0:299)
#tt<-c(taxabps1segcar0_e2$size[1:195], taxabps1segcar1_e2$size[1:195], taxabps1segcar2_e2$size[1:195], taxabps1segcar3_e2$size[1:195], taxabps1segcar4_e2$size[1:195], taxabps1segcar5_e2$size[1:195], taxabps1segcar6_e2$size[1:195], taxabps1segcar7_e2$size[1:195], taxabps1segcar8_e2$size[1:195], taxabps1segcar9_e2$size[1:195], taxabps1segcar10_e2$size[1:195], taxabps1segcar11_e2$size[1:195], taxabps1segcar12_e2$size[1:195], taxabps1segcar13_e2$size[1:195], taxabps1segcar14_e2$size[1:195], taxabps1segcar15_e2$size[1:195], taxabps1segcar16_e2$size[1:195], taxabps1segcar17_e2$size[1:195], taxabps1segcar18_e2$size[1:195], taxabps1segcar19_e2$size[1:195])
tt<-c(taxabps1segcar0_e2$size[1:300], taxabps1segcar1_e2$size[1:300], taxabps1segcar2_e2$size[1:300], taxabps1segcar3_e2$size[1:300], taxabps1segcar4_e2$size[1:300], taxabps1segcar5_e2$size[1:300], taxabps1segcar6_e2$size[1:300], taxabps1segcar7_e2$size[1:300], taxabps1segcar8_e2$size[1:300], taxabps1segcar9_e2$size[1:300], taxabps1segcar10_e2$size[1:300], taxabps1segcar11_e2$size[1:300])
ttm<-c(taxabps1segcar0_e2$size[1:300] + taxabps1segcar1_e2$size[1:300] + taxabps1segcar2_e2$size[1:300] + taxabps1segcar3_e2$size[1:300] + taxabps1segcar4_e2$size[1:300] + taxabps1segcar5_e2$size[1:300] + taxabps1segcar6_e2$size[1:300] + taxabps1segcar7_e2$size[1:300] + taxabps1segcar8_e2$size[1:300] + taxabps1segcar9_e2$size[1:300] + taxabps1segcar10_e2$size[1:300] + taxabps1segcar11_e2$size[1:300])/12
tttime<-c(ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime)

length(ttm)

length(ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="red", main="Server E", ylab = "Taxa de entrega de pacotes - PDR", xlab = "tempo (s)", ylim = range(0:3e+06), xlim = range(0:230) )
lines(ttime,ttm, type = "l", col="black", lwd="2")

par(new=T)


ttime<-c(0:299)
#tt<-c(taxabps1segserver_e2_car0$size[1:195], taxabps1segserver_e2_car1$size[1:195], taxabps1segserver_e2_car2$size[1:195], taxabps1segserver_e2_car3$size[1:195], taxabps1segserver_e2_car4$size[1:195], taxabps1segserver_e2_car5$size[1:195], taxabps1segserver_e2_car6$size[1:195], taxabps1segserver_e2_car7$size[1:195], taxabps1segserver_e2_car8$size[1:195], taxabps1segserver_e2_car9$size[1:195], taxabps1segserver_e2_car10$size[1:195], taxabps1segserver_e2_car11$size[1:195], taxabps1segserver_e2_car12$size[1:195], taxabps1segserver_e2_car13$size[1:195], taxabps1segserver_e2_car14$size[1:195], taxabps1segserver_e2_car15$size[1:195], taxabps1segserver_e2_car16$size[1:195], taxabps1segserver_e2_car17$size[1:195], taxabps1segserver_e2_car18$size[1:195], taxabps1segserver_e2_car19$size[1:195])
tt<-c(taxabps1segserver_e2_car0$size[1:300], taxabps1segserver_e2_car1$size[1:300], taxabps1segserver_e2_car2$size[1:300], taxabps1segserver_e2_car3$size[1:300], taxabps1segserver_e2_car4$size[1:300], taxabps1segserver_e2_car5$size[1:300], taxabps1segserver_e2_car6$size[1:300], taxabps1segserver_e2_car7$size[1:300], taxabps1segserver_e2_car8$size[1:300], taxabps1segserver_e2_car9$size[1:300], taxabps1segserver_e2_car10$size[1:300], taxabps1segserver_e2_car11$size[1:300])
ttm<-c(taxabps1segserver_e2_car0$size[1:300] + taxabps1segserver_e2_car1$size[1:300] + taxabps1segserver_e2_car2$size[1:300] + taxabps1segserver_e2_car3$size[1:300] + taxabps1segserver_e2_car4$size[1:300] + taxabps1segserver_e2_car5$size[1:300] + taxabps1segserver_e2_car6$size[1:300] + taxabps1segserver_e2_car7$size[1:300] + taxabps1segserver_e2_car8$size[1:300] + taxabps1segserver_e2_car9$size[1:300] + taxabps1segserver_e2_car10$size[1:300] + taxabps1segserver_e2_car11$size[1:300])/12
tttime<-c(ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime, ttime)

require(Rmisc)
x<- cbind(tttime,tt)
x<-data.frame(x)
y<-group.CI(tt~tttime,x,ci = 0.95)
require(plotrix)
plotCI(ttime, ttm, ui=y$tt.upper, li=y$tt.lower, col="blue", main="Server E", axes = FALSE)
lines(ttime,ttm, type = "l", col="black", lwd="2")
