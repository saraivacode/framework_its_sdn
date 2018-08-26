##################PDRs
###APP E

###FS
#Compute Server E received
traceserver_e_fs<-read.table(file = 'result/server_etf_car_fs_tt.txt', sep=' ')
names(traceserver_e_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fs$time <- as.POSIXlt(traceserver_e_fs$time, origin = "1987-10-05 11:00:00")
traceserver_e_fs$size<- traceserver_e_fs$size*8
sum1segserver_e_fs<-aggregate(list(size = traceserver_e_fs$size), list(segundos = cut(traceserver_e_fs$time, "1 sec")), sum)
mean1segserver_e_fs<-append(list(size = sum1segserver_e_fs$size), list(time = as.numeric(sum1segserver_e_fs$segundos)))

mean1segserver_e_fs$size[1:150]<- mean1segserver_e_fs$size[1:150]/7
mean1segserver_e_fs$size[151:225]<- mean1segserver_e_fs$size[151:225]/11
mean1segserver_e_fs$size[226:300]<- mean1segserver_e_fs$size[226:300]/15

pd_e_server<-traceserver_e_fs
pd_e_server$size<-pd_e_server$size/8/1498
sumpd75segserver_e_fs<-aggregate(list(size = pd_e_server$size), list(segundos = cut(pd_e_server$time, "75 sec")), sum)
meanpd75segserver_e_fs<-append(list(size = sumpd75segserver_e_fs$size), list(time = as.numeric(sumpd75segserver_e_fs$segundos)))

#Compute Car sent Server E
tracecar_e_fs<-read.table(file = 'result/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_e_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fs$time <- as.POSIXlt(tracecar_e_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e_fs$size<- tracecar_e_fs$size*8
sum1segcar_e_fs<-aggregate(list(size = tracecar_e_fs$size), list(segundos = cut(tracecar_e_fs$time, "1 sec")), sum)
mean1segcar_e_fs<-append(list(size = sum1segcar_e_fs$size), list(time =  as.numeric(sum1segcar_e_fs$segundos)))

mean1segcar_e_fs$size[1:150]<- mean1segcar_e_fs$size[1:150]/7
mean1segcar_e_fs$size[151:225]<- mean1segcar_e_fs$size[151:225]/11
mean1segcar_e_fs$size[226:300]<- mean1segcar_e_fs$size[226:300]/15

pd_e_car<-tracecar_e_fs
pd_e_car$size<-pd_e_car$size/8/1498
sumpd75segcar_e_fs<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "75 sec")), sum)
meanpd75segcar_e_fs<-append(list(size = sumpd75segcar_e_fs$size), list(time = as.numeric(sumpd75segcar_e_fs$segundos)))

#Compute PDR Server E
pdr75seg_e_fs<-meanpd75segserver_e_fs$size/meanpd75segcar_e_fs$size
pdr1seg_e_fs<-mean1segserver_e_fs$size[1:300]/mean1segcar_e_fs$size[1:300]

require(Rmisc)
w_e_fs<-CI(pdr1seg_e_fs[1:75], ci=0.95)
x_e_fs<-CI(pdr1seg_e_fs[76:150], ci=0.95)
y_e_fs<-CI(pdr1seg_e_fs[151:225], ci=0.95)
z_e_fs<-CI(pdr1seg_e_fs[225:300], ci=0.95)

up_e_fs<-c(w_e_fs[1], x_e_fs[1], y_e_fs[1], z_e_fs[1])
lo_e_fs<-c(w_e_fs[3], x_e_fs[3], y_e_fs[3], z_e_fs[3])


###FQ
#Compute Server E received
traceserver_e_fq<-read.table(file = 'result/server_etf_car_fq_tt.txt', sep=' ')
names(traceserver_e_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fq$time <- as.POSIXlt(traceserver_e_fq$time, origin = "1987-10-05 11:00:00")
traceserver_e_fq$size<- traceserver_e_fq$size*8
sum1segserver_e_fq<-aggregate(list(size = traceserver_e_fq$size), list(segundos = cut(traceserver_e_fq$time, "1 sec")), sum)
mean1segserver_e_fq<-append(list(size = sum1segserver_e_fq$size), list(time = as.numeric(sum1segserver_e_fq$segundos)))

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

mean1segcar_e_fq$size[1:150]<- mean1segcar_e_fq$size[1:150]/7
mean1segcar_e_fq$size[151:225]<- mean1segcar_e_fq$size[151:225]/11
mean1segcar_e_fq$size[226:300]<- mean1segcar_e_fq$size[226:300]/15

pd_e_car<-tracecar_e_fq
pd_e_car$size<-pd_e_car$size/8/1498
sumpd75segcar_e_fq<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "75 sec")), sum)
meanpd75segcar_e_fq<-append(list(size = sumpd75segcar_e_fq$size), list(time = as.numeric(sumpd75segcar_e_fq$segundos)))

#Compute PDR Server E
pdr75seg_e_fq<-meanpd75segserver_e_fq$size/meanpd75segcar_e_fq$size
pdr1seg_e_fq<-mean1segserver_e_fq$size[1:300]/mean1segcar_e_fq$size[1:300]

require(Rmisc)
w_e_fq<-CI(pdr1seg_e_fq[1:75], ci=0.95)
x_e_fq<-CI(pdr1seg_e_fq[76:150], ci=0.95)
y_e_fq<-CI(pdr1seg_e_fq[151:225], ci=0.95)
z_e_fq<-CI(pdr1seg_e_fq[225:300], ci=0.95)

up_e_fq<-c(w_e_fq[1], x_e_fq[1], y_e_fq[1], z_e_fq[1])
lo_e_fq<-c(w_e_fq[3], x_e_fq[3], y_e_fq[3], z_e_fq[3])


####FN
#Compute Server E received
traceserver_e_fn<-read.table(file = 'result/server_etf_car_fn_tt.txt', sep=' ')
names(traceserver_e_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e_fn$time <- as.POSIXlt(traceserver_e_fn$time, origin = "1987-10-05 11:00:00")
traceserver_e_fn$size<- traceserver_e_fn$size*8
sum1segserver_e_fn<-aggregate(list(size = traceserver_e_fn$size), list(segundos = cut(traceserver_e_fn$time, "1 sec")), sum)
mean1segserver_e_fn<-append(list(size = sum1segserver_e_fn$size), list(time = as.numeric(sum1segserver_e_fn$segundos)))

mean1segserver_e_fn$size[1:150]<- mean1segserver_e_fn$size[1:150]/7
mean1segserver_e_fn$size[151:225]<- mean1segserver_e_fn$size[151:225]/11
mean1segserver_e_fn$size[226:300]<- mean1segserver_e_fn$size[226:300]/15

pd_e_server<-traceserver_e_fn
pd_e_server$size<-pd_e_server$size/8/1498
sumpd75segserver_e_fn<-aggregate(list(size = pd_e_server$size), list(segundos = cut(pd_e_server$time, "75 sec")), sum)
meanpd75segserver_e_fn<-append(list(size = sumpd75segserver_e_fn$size), list(time = as.numeric(sumpd75segserver_e_fn$segundos)))

#Compute Car sent Server E
tracecar_e_fn<-read.table(file = 'result/cartf_fn_5003_tt.txt', sep=' ')
names(tracecar_e_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_e_fn$time <- as.POSIXlt(tracecar_e_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e_fn$size<- tracecar_e_fn$size*8
sum1segcar_e_fn<-aggregate(list(size = tracecar_e_fn$size), list(segundos = cut(tracecar_e_fn$time, "1 sec")), sum)
mean1segcar_e_fn<-append(list(size = sum1segcar_e_fn$size), list(time =  as.numeric(sum1segcar_e_fn$segundos)))

mean1segcar_e_fn$size[1:150]<- mean1segcar_e_fn$size[1:150]/7
mean1segcar_e_fn$size[151:225]<- mean1segcar_e_fn$size[151:225]/11
mean1segcar_e_fn$size[226:300]<- mean1segcar_e_fn$size[226:300]/15

pd_e_car<-tracecar_e_fn
pd_e_car$size<-pd_e_car$size/8/1498
sumpd75segcar_e_fn<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "75 sec")), sum)
meanpd75segcar_e_fn<-append(list(size = sumpd75segcar_e_fn$size), list(time = as.numeric(sumpd75segcar_e_fn$segundos)))

#Compute PDR Server E
pdr75seg_e_fn<-meanpd75segserver_e_fn$size/meanpd75segcar_e_fn$size
pdr1seg_e_fn<-mean1segserver_e_fn$size[1:300]/mean1segcar_e_fn$size[1:300]

require(Rmisc)
w_e_fn<-CI(pdr1seg_e_fn[1:75], ci=0.95)
x_e_fn<-CI(pdr1seg_e_fn[76:150], ci=0.95)
y_e_fn<-CI(pdr1seg_e_fn[151:225], ci=0.95)
z_e_fn<-CI(pdr1seg_e_fn[225:300], ci=0.95)

up_e_fn<-c(w_e_fn[1], x_e_fn[1], y_e_fn[1], z_e_fn[1])
lo_e_fn<-c(w_e_fn[3], x_e_fn[3], y_e_fn[3], z_e_fn[3])


require(plotrix)

plotCI(c(1:4), pdr75seg_e_fs[1:4], ui=up_e_fs, li=lo_e_fs, col="red", main="PDR Application E", ylab = "PDR", xlab = "time(s)", lwd="2", ylim=c(0.5,1))
lines(c(1:4),pdr75seg_e_fs[1:4], type = "l", col="red", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_e_fq[1:4], ui=up_e_fq, li=lo_e_fq, col="blue", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0.5,1))
lines(c(1:4),pdr75seg_e_fq[1:4], type = "l", col="blue", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_e_fn[1:4], ui=up_e_fn, li=lo_e_fn, col="orange", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0.5,1))
lines(c(1:4),pdr75seg_e_fn[1:4], type = "l", col="orange", lwd="2")
legend("topright", legend=c("FS", "FQ", "FN"), lty=c(1,1,1), col=c("red", "blue", "orange"))

#################
###APP E2

###FS
#Compute Server E2 received
traceserver_e2_fs<-read.table(file = 'result/server_e2tf_car_fs_tt.txt', sep=' ')
names(traceserver_e2_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e2_fs$time <- as.POSIXlt(traceserver_e2_fs$time, origin = "1987-10-05 11:00:00")
traceserver_e2_fs$size<- traceserver_e2_fs$size*8
sum1segserver_e2_fs<-aggregate(list(size = traceserver_e2_fs$size), list(segundos = cut(traceserver_e2_fs$time, "1 sec")), sum)
mean1segserver_e2_fs<-append(list(size = sum1segserver_e2_fs$size), list(time = as.numeric(sum1segserver_e2_fs$segundos)))

mean1segserver_e2_fs$size[1:150]<- mean1segserver_e2_fs$size[1:150]/7
mean1segserver_e2_fs$size[151:225]<- mean1segserver_e2_fs$size[151:225]/11
mean1segserver_e2_fs$size[226:300]<- mean1segserver_e2_fs$size[226:300]/15

pd_e2_server<-traceserver_e2_fs
pd_e2_server$size<-pd_e2_server$size/8/1498
sumpd75segserver_e2_fs<-aggregate(list(size = pd_e2_server$size), list(segundos = cut(pd_e2_server$time, "75 sec")), sum)
meanpd75segserver_e2_fs<-append(list(size = sumpd75segserver_e2_fs$size), list(time = as.numeric(sumpd75segserver_e2_fs$segundos)))

#Compute Car sent Server E2
tracecar_e2_fs<-read.table(file = 'result/cartf_fs_5004_tt.txt', sep=' ')
names(tracecar_e2_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fs$time <- as.POSIXlt(tracecar_e2_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fs$size<- tracecar_e2_fs$size*8
sum1segcar_e2_fs<-aggregate(list(size = tracecar_e2_fs$size), list(segundos = cut(tracecar_e2_fs$time, "1 sec")), sum)
mean1segcar_e2_fs<-append(list(size = sum1segcar_e2_fs$size), list(time =  as.numeric(sum1segcar_e2_fs$segundos)))

mean1segcar_e2_fs$size[1:150]<- mean1segcar_e2_fs$size[1:150]/7
mean1segcar_e2_fs$size[151:225]<- mean1segcar_e2_fs$size[151:225]/11
mean1segcar_e2_fs$size[226:300]<- mean1segcar_e2_fs$size[226:300]/15

pd_e2_car<-tracecar_e2_fs
pd_e2_car$size<-pd_e2_car$size/8/1498
sumpd75segcar_e2_fs<-aggregate(list(size = pd_e2_car$size), list(segundos = cut(pd_e2_car$time, "75 sec")), sum)
meanpd75segcar_e2_fs<-append(list(size = sumpd75segcar_e2_fs$size), list(time = as.numeric(sumpd75segcar_e2_fs$segundos)))

#Compute PDR Server E2
pdr75seg_e2_fs<-meanpd75segserver_e2_fs$size/meanpd75segcar_e2_fs$size
pdr1seg_e2_fs<-mean1segserver_e2_fs$size[1:300]/mean1segcar_e2_fs$size[1:300]

require(Rmisc)
w_e2_fs<-CI(pdr1seg_e2_fs[1:75], ci=0.95)
x_e2_fs<-CI(pdr1seg_e2_fs[76:150], ci=0.95)
y_e2_fs<-CI(pdr1seg_e2_fs[151:225], ci=0.95)
z_e2_fs<-CI(pdr1seg_e2_fs[225:300], ci=0.95)

up_e2_fs<-c(w_e2_fs[1], x_e2_fs[1], y_e2_fs[1], z_e2_fs[1])
lo_e2_fs<-c(w_e2_fs[3], x_e2_fs[3], y_e2_fs[3], z_e2_fs[3])


###FQ
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
tracecar_e2_fq<-read.table(file = 'result/cartf_fq_5004_tt.txt', sep=' ')
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

#Compute PDR Server E2
pdr75seg_e2_fq<-meanpd75segserver_e2_fq$size/meanpd75segcar_e2_fq$size
pdr1seg_e2_fq<-mean1segserver_e2_fq$size[1:300]/mean1segcar_e2_fq$size[1:300]

require(Rmisc)
w_e2_fq<-CI(pdr1seg_e2_fq[1:75], ci=0.95)
x_e2_fq<-CI(pdr1seg_e2_fq[76:150], ci=0.95)
y_e2_fq<-CI(pdr1seg_e2_fq[151:225], ci=0.95)
z_e2_fq<-CI(pdr1seg_e2_fq[225:300], ci=0.95)

up_e2_fq<-c(w_e2_fq[1], x_e2_fq[1], y_e2_fq[1], z_e2_fq[1])
lo_e2_fq<-c(w_e2_fq[3], x_e2_fq[3], y_e2_fq[3], z_e2_fq[3])


####FN
#Compute Server E2 received
traceserver_e2_fn<-read.table(file = 'result/server_e2tf_car_fn_tt.txt', sep=' ')
names(traceserver_e2_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_e2_fn$time <- as.POSIXlt(traceserver_e2_fn$time, origin = "1987-10-05 11:00:00")
traceserver_e2_fn$size<- traceserver_e2_fn$size*8
sum1segserver_e2_fn<-aggregate(list(size = traceserver_e2_fn$size), list(segundos = cut(traceserver_e2_fn$time, "1 sec")), sum)
mean1segserver_e2_fn<-append(list(size = sum1segserver_e2_fn$size), list(time = as.numeric(sum1segserver_e2_fn$segundos)))

mean1segserver_e2_fn$size[1:150]<- mean1segserver_e2_fn$size[1:150]/7
mean1segserver_e2_fn$size[151:225]<- mean1segserver_e2_fn$size[151:225]/11
mean1segserver_e2_fn$size[226:300]<- mean1segserver_e2_fn$size[226:300]/15

pd_e2_server<-traceserver_e2_fn
pd_e2_server$size<-pd_e2_server$size/8/1498
sumpd75segserver_e2_fn<-aggregate(list(size = pd_e2_server$size), list(segundos = cut(pd_e2_server$time, "75 sec")), sum)
meanpd75segserver_e2_fn<-append(list(size = sumpd75segserver_e2_fn$size), list(time = as.numeric(sumpd75segserver_e2_fn$segundos)))

#Compute Car sent Server E2
tracecar_e2_fn<-read.table(file = 'result/cartf_fn_5004_tt.txt', sep=' ')
names(tracecar_e2_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_e2_fn$time <- as.POSIXlt(tracecar_e2_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fn$size<- tracecar_e2_fn$size*8
sum1segcar_e2_fn<-aggregate(list(size = tracecar_e2_fn$size), list(segundos = cut(tracecar_e2_fn$time, "1 sec")), sum)
mean1segcar_e2_fn<-append(list(size = sum1segcar_e2_fn$size), list(time =  as.numeric(sum1segcar_e2_fn$segundos)))

mean1segcar_e2_fn$size[1:150]<- mean1segcar_e2_fn$size[1:150]/7
mean1segcar_e2_fn$size[151:225]<- mean1segcar_e2_fn$size[151:225]/11
mean1segcar_e2_fn$size[226:300]<- mean1segcar_e2_fn$size[226:300]/15

pd_e2_car<-tracecar_e2_fn
pd_e2_car$size<-pd_e2_car$size/8/1498
sumpd75segcar_e2_fn<-aggregate(list(size = pd_e2_car$size), list(segundos = cut(pd_e2_car$time, "75 sec")), sum)
meanpd75segcar_e2_fn<-append(list(size = sumpd75segcar_e2_fn$size), list(time = as.numeric(sumpd75segcar_e2_fn$segundos)))

#Compute PDR Server E2
pdr75seg_e2_fn<-meanpd75segserver_e2_fn$size/meanpd75segcar_e2_fn$size
pdr1seg_e2_fn<-mean1segserver_e2_fn$size[1:300]/mean1segcar_e2_fn$size[1:300]

require(Rmisc)
w_e2_fn<-CI(pdr1seg_e2_fn[1:75], ci=0.95)
x_e2_fn<-CI(pdr1seg_e2_fn[76:150], ci=0.95)
y_e2_fn<-CI(pdr1seg_e2_fn[151:225], ci=0.95)
z_e2_fn<-CI(pdr1seg_e2_fn[225:300], ci=0.95)

up_e2_fn<-c(w_e2_fn[1], x_e2_fn[1], y_e2_fn[1], z_e2_fn[1])
lo_e2_fn<-c(w_e2_fn[3], x_e2_fn[3], y_e2_fn[3], z_e2_fn[3])


require(plotrix)

plotCI(c(1:4), pdr75seg_e2_fs[1:4], ui=up_e2_fs, li=lo_e2_fs, col="red", main="PDR Application E2", ylab = "PDR", xlab = "time(s)", lwd="2", ylim=c(0.5,1))
lines(c(1:4),pdr75seg_e2_fs[1:4], type = "l", col="red", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_e2_fq[1:4], ui=up_e2_fq, li=lo_e2_fq, col="blue", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0.5,1))
lines(c(1:4),pdr75seg_e2_fq[1:4], type = "l", col="blue", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_e2_fn[1:4], ui=up_e2_fn, li=lo_e2_fn, col="orange", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0.5,1))
lines(c(1:4),pdr75seg_e2_fn[1:4], type = "l", col="orange", lwd="2")
legend("topright", legend=c("FS", "FQ", "FN"), lty=c(1,1,1), col=c("red", "blue", "orange"))

######################
#APP G
###FS
#Compute Server G received
traceserver_g_fs<-read.table(file = 'result/server_gtf_car_fs_tt.txt', sep=' ')
names(traceserver_g_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_g_fs$time <- as.POSIXlt(traceserver_g_fs$time, origin = "1987-10-05 11:00:00")
traceserver_g_fs$size<- traceserver_g_fs$size*8
sum1segserver_g_fs<-aggregate(list(size = traceserver_g_fs$size), list(segundos = cut(traceserver_g_fs$time, "1 sec")), sum)
mean1segserver_g_fs<-append(list(size = sum1segserver_g_fs$size), list(time = as.numeric(sum1segserver_g_fs$segundos)))

mean1segserver_g_fs$size[1:150]<- mean1segserver_g_fs$size[1:150]/7
mean1segserver_g_fs$size[151:225]<- mean1segserver_g_fs$size[151:225]/11
mean1segserver_g_fs$size[226:300]<- mean1segserver_g_fs$size[226:300]/15

pd_g_server<-traceserver_g_fs
pd_g_server$size<-pd_g_server$size/8/1498
sumpd75segserver_g_fs<-aggregate(list(size = pd_g_server$size), list(segundos = cut(pd_g_server$time, "75 sec")), sum)
meanpd75segserver_g_fs<-append(list(size = sumpd75segserver_g_fs$size), list(time = as.numeric(sumpd75segserver_g_fs$segundos)))

#Compute Car sent Server G
tracecar_g_fs<-read.table(file = 'result/cartf_fs_5005_tt.txt', sep=' ')
names(tracecar_g_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fs$time <- as.POSIXlt(tracecar_g_fs$time, origin = "1987-10-05 11:00:00")
tracecar_g_fs$size<- tracecar_g_fs$size*8
sum1segcar_g_fs<-aggregate(list(size = tracecar_g_fs$size), list(segundos = cut(tracecar_g_fs$time, "1 sec")), sum)
mean1segcar_g_fs<-append(list(size = sum1segcar_g_fs$size), list(time =  as.numeric(sum1segcar_g_fs$segundos)))

mean1segcar_g_fs$size[1:150]<- mean1segcar_g_fs$size[1:150]/7
mean1segcar_g_fs$size[151:225]<- mean1segcar_g_fs$size[151:225]/11
mean1segcar_g_fs$size[226:300]<- mean1segcar_g_fs$size[226:300]/15

pd_g_car<-tracecar_g_fs
pd_g_car$size<-pd_g_car$size/8/1498
sumpd75segcar_g_fs<-aggregate(list(size = pd_g_car$size), list(segundos = cut(pd_g_car$time, "75 sec")), sum)
meanpd75segcar_g_fs<-append(list(size = sumpd75segcar_g_fs$size), list(time = as.numeric(sumpd75segcar_g_fs$segundos)))

#Compute PDR Server G
pdr75seg_g_fs<-meanpd75segserver_g_fs$size/meanpd75segcar_g_fs$size
pdr1seg_g_fs<-mean1segserver_g_fs$size[1:300]/mean1segcar_g_fs$size[1:300]

require(Rmisc)
w_g_fs<-CI(pdr1seg_g_fs[1:75], ci=0.95)
x_g_fs<-CI(pdr1seg_g_fs[76:150], ci=0.95)
y_g_fs<-CI(pdr1seg_g_fs[151:225], ci=0.95)
z_g_fs<-CI(pdr1seg_g_fs[225:300], ci=0.95)

up_g_fs<-c(w_g_fs[1], x_g_fs[1], y_g_fs[1], z_g_fs[1])
lo_g_fs<-c(w_g_fs[3], x_g_fs[3], y_g_fs[3], z_g_fs[3])


###FQ
#Compute Server G received
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
tracecar_g_fq<-read.table(file = 'result/cartf_fq_5005_tt.txt', sep=' ')
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

#Compute PDR Server G
pdr75seg_g_fq<-meanpd75segserver_g_fq$size/meanpd75segcar_g_fq$size
pdr1seg_g_fq<-mean1segserver_g_fq$size[1:300]/mean1segcar_g_fq$size[1:300]

require(Rmisc)
w_g_fq<-CI(pdr1seg_g_fq[1:75], ci=0.95)
x_g_fq<-CI(pdr1seg_g_fq[76:150], ci=0.95)
y_g_fq<-CI(pdr1seg_g_fq[151:225], ci=0.95)
z_g_fq<-CI(pdr1seg_g_fq[225:300], ci=0.95)

up_g_fq<-c(w_g_fq[1], x_g_fq[1], y_g_fq[1], z_g_fq[1])
lo_g_fq<-c(w_g_fq[3], x_g_fq[3], y_g_fq[3], z_g_fq[3])


####FN
#Compute Server G received
traceserver_g_fn<-read.table(file = 'result/server_gtf_car_fn_tt.txt', sep=' ')
names(traceserver_g_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_g_fn$time <- as.POSIXlt(traceserver_g_fn$time, origin = "1987-10-05 11:00:00")
traceserver_g_fn$size<- traceserver_g_fn$size*8
sum1segserver_g_fn<-aggregate(list(size = traceserver_g_fn$size), list(segundos = cut(traceserver_g_fn$time, "1 sec")), sum)
mean1segserver_g_fn<-append(list(size = sum1segserver_g_fn$size), list(time = as.numeric(sum1segserver_g_fn$segundos)))

mean1segserver_g_fn$size[1:150]<- mean1segserver_g_fn$size[1:150]/7
mean1segserver_g_fn$size[151:225]<- mean1segserver_g_fn$size[151:225]/11
mean1segserver_g_fn$size[226:300]<- mean1segserver_g_fn$size[226:300]/15

pd_g_server<-traceserver_g_fn
pd_g_server$size<-pd_g_server$size/8/1498
sumpd75segserver_g_fn<-aggregate(list(size = pd_g_server$size), list(segundos = cut(pd_g_server$time, "75 sec")), sum)
meanpd75segserver_g_fn<-append(list(size = sumpd75segserver_g_fn$size), list(time = as.numeric(sumpd75segserver_g_fn$segundos)))

#Compute Car sent Server G
tracecar_g_fn<-read.table(file = 'result/cartf_fn_5005_tt.txt', sep=' ')
names(tracecar_g_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_g_fn$time <- as.POSIXlt(tracecar_g_fn$time, origin = "1987-10-05 11:00:00")
tracecar_g_fn$size<- tracecar_g_fn$size*8
sum1segcar_g_fn<-aggregate(list(size = tracecar_g_fn$size), list(segundos = cut(tracecar_g_fn$time, "1 sec")), sum)
mean1segcar_g_fn<-append(list(size = sum1segcar_g_fn$size), list(time =  as.numeric(sum1segcar_g_fn$segundos)))

mean1segcar_g_fn$size[1:150]<- mean1segcar_g_fn$size[1:150]/7
mean1segcar_g_fn$size[151:225]<- mean1segcar_g_fn$size[151:225]/11
mean1segcar_g_fn$size[226:300]<- mean1segcar_g_fn$size[226:300]/15

pd_g_car<-tracecar_g_fn
pd_g_car$size<-pd_g_car$size/8/1498
sumpd75segcar_g_fn<-aggregate(list(size = pd_g_car$size), list(segundos = cut(pd_g_car$time, "75 sec")), sum)
meanpd75segcar_g_fn<-append(list(size = sumpd75segcar_g_fn$size), list(time = as.numeric(sumpd75segcar_g_fn$segundos)))

#Compute PDR Server G
pdr75seg_g_fn<-meanpd75segserver_g_fn$size/meanpd75segcar_g_fn$size
pdr1seg_g_fn<-mean1segserver_g_fn$size[1:300]/mean1segcar_g_fn$size[1:300]

require(Rmisc)
w_g_fn<-CI(pdr1seg_g_fn[1:75], ci=0.95)
x_g_fn<-CI(pdr1seg_g_fn[76:150], ci=0.95)
y_g_fn<-CI(pdr1seg_g_fn[151:225], ci=0.95)
z_g_fn<-CI(pdr1seg_g_fn[225:300], ci=0.95)

up_g_fn<-c(w_g_fn[1], x_g_fn[1], y_g_fn[1], z_g_fn[1])
lo_g_fn<-c(w_g_fn[3], x_g_fn[3], y_g_fn[3], z_g_fn[3])


require(plotrix)

plotCI(c(1:4), pdr75seg_g_fs[1:4], ui=up_g_fs, li=lo_g_fs, col="red", main="PDR Application G", ylab = "PDR", xlab = "time(s)", lwd="2" , ylim=c(0,1))
lines(c(1:4),pdr75seg_g_fs[1:4], type = "l", col="red", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_g_fq[1:4], ui=up_g_fq, li=lo_g_fq, col="blue", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0,1))
lines(c(1:4),pdr75seg_g_fq[1:4], type = "l", col="blue", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_g_fn[1:4], ui=up_g_fn, li=lo_g_fn, col="orange", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0,1) )
lines(c(1:4),pdr75seg_g_fn[1:4], type = "l", col="orange", lwd="2")
legend("topright", legend=c("FS", "FQ", "FN"), lty=c(1,1,1), col=c("red", "blue", "orange"))

################################################################################
#APP S
###FS
#Compute Server S received
traceserver_s_fs<-read.table(file = 'result/server_stf_car_fs_tt.txt', sep=' ')
names(traceserver_s_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_s_fs$time <- as.POSIXlt(traceserver_s_fs$time, origin = "1987-10-05 11:00:00")
traceserver_s_fs$size<- traceserver_s_fs$size*8
sum1segserver_s_fs<-aggregate(list(size = traceserver_s_fs$size), list(segundos = cut(traceserver_s_fs$time, "1 sec")), sum)
mean1segserver_s_fs<-append(list(size = sum1segserver_s_fs$size), list(time = as.numeric(sum1segserver_s_fs$segundos)))

mean1segserver_s_fs$size[1:150]<- mean1segserver_s_fs$size[1:150]/7
mean1segserver_s_fs$size[151:225]<- mean1segserver_s_fs$size[151:225]/11
mean1segserver_s_fs$size[226:300]<- mean1segserver_s_fs$size[226:300]/15

pd_s_server<-traceserver_s_fs
pd_s_server$size<-pd_s_server$size/8/1498
sumpd75segserver_s_fs<-aggregate(list(size = pd_s_server$size), list(segundos = cut(pd_s_server$time, "75 sec")), sum)
meanpd75segserver_s_fs<-append(list(size = sumpd75segserver_s_fs$size), list(time = as.numeric(sumpd75segserver_s_fs$segundos)))

#Compute Car sent Server S
tracecar_s_fs<-read.table(file = 'result/cartf_fs_5002_tt.txt', sep=' ')
names(tracecar_s_fs)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fs$time <- as.POSIXlt(tracecar_s_fs$time, origin = "1987-10-05 11:00:00")
tracecar_s_fs$size<- tracecar_s_fs$size*8
sum1segcar_s_fs<-aggregate(list(size = tracecar_s_fs$size), list(segundos = cut(tracecar_s_fs$time, "1 sec")), sum)
mean1segcar_s_fs<-append(list(size = sum1segcar_s_fs$size), list(time =  as.numeric(sum1segcar_s_fs$segundos)))

mean1segcar_s_fs$size[1:150]<- mean1segcar_s_fs$size[1:150]/7
mean1segcar_s_fs$size[151:225]<- mean1segcar_s_fs$size[151:225]/11
mean1segcar_s_fs$size[226:300]<- mean1segcar_s_fs$size[226:300]/15

pd_s_car<-tracecar_s_fs
pd_s_car$size<-pd_s_car$size/8/1498
sumpd75segcar_s_fs<-aggregate(list(size = pd_s_car$size), list(segundos = cut(pd_s_car$time, "75 sec")), sum)
meanpd75segcar_s_fs<-append(list(size = sumpd75segcar_s_fs$size), list(time = as.numeric(sumpd75segcar_s_fs$segundos)))

#Compute PDR Server S
pdr75seg_s_fs<-meanpd75segserver_s_fs$size/meanpd75segcar_s_fs$size
pdr1seg_s_fs<-mean1segserver_s_fs$size[1:300]/mean1segcar_s_fs$size[1:300]

require(Rmisc)
w_s_fs<-CI(pdr1seg_s_fs[1:75], ci=0.95)
x_s_fs<-CI(pdr1seg_s_fs[76:150], ci=0.95)
y_s_fs<-CI(pdr1seg_s_fs[151:225], ci=0.95)
z_s_fs<-CI(pdr1seg_s_fs[225:300], ci=0.95)

up_s_fs<-c(w_s_fs[1], x_s_fs[1], y_s_fs[1], z_s_fs[1])
lo_s_fs<-c(w_s_fs[3], x_s_fs[3], y_s_fs[3], z_s_fs[3])


###FQ
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
tracecar_s_fq<-read.table(file = 'result/cartf_fq_5002_tt.txt', sep=' ')
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

#Compute PDR Server S
pdr75seg_s_fq<-meanpd75segserver_s_fq$size/meanpd75segcar_s_fq$size
pdr1seg_s_fq<-mean1segserver_s_fq$size[1:300]/mean1segcar_s_fq$size[1:300]

require(Rmisc)
w_s_fq<-CI(pdr1seg_s_fq[1:75], ci=0.95)
x_s_fq<-CI(pdr1seg_s_fq[76:150], ci=0.95)
y_s_fq<-CI(pdr1seg_s_fq[151:225], ci=0.95)
z_s_fq<-CI(pdr1seg_s_fq[225:300], ci=0.95)

up_s_fq<-c(w_s_fq[1], x_s_fq[1], y_s_fq[1], z_s_fq[1])
lo_s_fq<-c(w_s_fq[3], x_s_fq[3], y_s_fq[3], z_s_fq[3])


####FN
#Compute Server S received
traceserver_s_fn<-read.table(file = 'result/server_stf_car_fn_tt.txt', sep=' ')
names(traceserver_s_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
traceserver_s_fn$time <- as.POSIXlt(traceserver_s_fn$time, origin = "1987-10-05 11:00:00")
traceserver_s_fn$size<- traceserver_s_fn$size*8
sum1segserver_s_fn<-aggregate(list(size = traceserver_s_fn$size), list(segundos = cut(traceserver_s_fn$time, "1 sec")), sum)
mean1segserver_s_fn<-append(list(size = sum1segserver_s_fn$size), list(time = as.numeric(sum1segserver_s_fn$segundos)))

mean1segserver_s_fn$size[1:150]<- mean1segserver_s_fn$size[1:150]/7
mean1segserver_s_fn$size[151:225]<- mean1segserver_s_fn$size[151:225]/11
mean1segserver_s_fn$size[226:300]<- mean1segserver_s_fn$size[226:300]/15

pd_s_server<-traceserver_s_fn
pd_s_server$size<-pd_s_server$size/8/1498
sumpd75segserver_s_fn<-aggregate(list(size = pd_s_server$size), list(segundos = cut(pd_s_server$time, "75 sec")), sum)
meanpd75segserver_s_fn<-append(list(size = sumpd75segserver_s_fn$size), list(time = as.numeric(sumpd75segserver_s_fn$segundos)))

#Compute Car sent Server S
tracecar_s_fn<-read.table(file = 'result/cartf_fn_5002_tt.txt', sep=' ')
names(tracecar_s_fn)<-c("time", "id", "size", "ori", "dest" )
tracecar_s_fn$time <- as.POSIXlt(tracecar_s_fn$time, origin = "1987-10-05 11:00:00")
tracecar_s_fn$size<- tracecar_s_fn$size*8
sum1segcar_s_fn<-aggregate(list(size = tracecar_s_fn$size), list(segundos = cut(tracecar_s_fn$time, "1 sec")), sum)
mean1segcar_s_fn<-append(list(size = sum1segcar_s_fn$size), list(time =  as.numeric(sum1segcar_s_fn$segundos)))

mean1segcar_s_fn$size[1:150]<- mean1segcar_s_fn$size[1:150]/7
mean1segcar_s_fn$size[151:225]<- mean1segcar_s_fn$size[151:225]/11
mean1segcar_s_fn$size[226:300]<- mean1segcar_s_fn$size[226:300]/15

pd_s_car<-tracecar_s_fn
pd_s_car$size<-pd_s_car$size/8/1498
sumpd75segcar_s_fn<-aggregate(list(size = pd_s_car$size), list(segundos = cut(pd_s_car$time, "75 sec")), sum)
meanpd75segcar_s_fn<-append(list(size = sumpd75segcar_s_fn$size), list(time = as.numeric(sumpd75segcar_s_fn$segundos)))

#Compute PDR Server S
pdr75seg_s_fn<-meanpd75segserver_s_fn$size/meanpd75segcar_s_fn$size
pdr1seg_s_fn<-mean1segserver_s_fn$size[1:300]/mean1segcar_s_fn$size[1:300]

require(Rmisc)
w_s_fn<-CI(pdr1seg_s_fn[1:75], ci=0.95)
x_s_fn<-CI(pdr1seg_s_fn[76:150], ci=0.95)
y_s_fn<-CI(pdr1seg_s_fn[151:225], ci=0.95)
z_s_fn<-CI(pdr1seg_s_fn[225:300], ci=0.95)

up_s_fn<-c(w_s_fn[1], x_s_fn[1], y_s_fn[1], z_s_fn[1])
lo_s_fn<-c(w_s_fn[3], x_s_fn[3], y_s_fn[3], z_s_fn[3])


require(plotrix)

plotCI(c(1:4), pdr75seg_s_fs[1:4], ui=up_s_fs, li=lo_s_fs, col="red", main="PDR Application S", ylab = "PDR", xlab = "time(s)", lwd="2", ylim=c(0.6,1.05))
lines(c(1:4),pdr75seg_s_fs[1:4], type = "l", col="red", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_s_fq[1:4], ui=up_s_fq, li=lo_s_fq, col="blue", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0.6,1.05))
lines(c(1:4),pdr75seg_s_fq[1:4], type = "l", col="blue", lwd="2")
par(new=T)
plotCI(c(1:4), pdr75seg_s_fn[1:4], ui=up_s_fn, li=lo_s_fn, col="orange", axes=F, xlab=NA, ylab=NA, lwd="2", ylim=c(0.6,1.05))
lines(c(1:4),pdr75seg_s_fn[1:4], type = "l", col="orange", lwd="2")
legend("topright", legend=c("FS", "FQ", "FN"), lty=c(1,1,1), col=c("red", "blue", "orange"))
