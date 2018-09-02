rttmean_e_fs <-summary(mean1segdelay_e_fs$size[0:300])
rttmean_e_fq <-summary(mean1segdelay_e_fq$size[0:300])
rttmean_e_fn <-summary(mean1segdelay_e_fn$size[0:300])
rttmean_e_fs; sd(mean1segdelay_e_fs$size[0:300])
sd(mean1segdelay_e_fq$size[0:300])
sd(mean1segdelay_e_fn$size[0:300])



rttmean_e_fq
rttmean_e_fn 

rttmean_e2_fs <-summary(mean1segdelay_e2_fs$size[0:300])
rttmean_e2_fq <-summary(mean1segdelay_e2_fq$size[0:300])
rttmean_e2_fn <-summary(mean1segdelay_e2_fn$size[0:300])
rttmean_e2_fs 
rttmean_e2_fq
rttmean_e2_fn 

rttmean_g_fs <-summary(mean1segdelay_g_fs$size[0:287])
rttmean_g_fq <-summary(mean1segdelay_g_fq$size[0:290])
rttmean_g_fn <-summary(mean1segdelay_g_fn$size[0:300])
rttmean_g_fs
rttmean_g_fq
rttmean_g_fn

rttmean_s_fs <-summary(mean1segdelay_s_fs$size[0:300])
rttmean_s_fq <-summary(mean1segdelay_s_fq$size[0:300])
rttmean_s_fn <-summary(mean1segdelay_s_fn$size[0:300])
rttmean_s_fs
rttmean_s_fq
rttmean_s_fn

#########################################
#E
pd_e_server_fs<-traceserver_e_fs
pd_e_server_fs$size<-pd_e_server_fs$size/8/1498
sumpd1segserver_e_fs<-aggregate(list(size = pd_e_server_fs$size), list(segundos = cut(pd_e_server_fs$time, "1 sec")), sum)
meanpd1segserver_e_fs<-append(list(size = sumpd1segserver_e_fs$size), list(time = as.numeric(sumpd1segserver_e_fs$segundos)))
pd_e_car_fs<-tracecar_e_fs
pd_e_car_fs$size<-pd_e_car_fs$size/8/1498
sumpd1segcar_e_fs<-aggregate(list(size = pd_e_car_fs$size), list(segundos = cut(pd_e_car_fs$time, "1 sec")), sum)
meanpd1segcar_e_fs<-append(list(size = sumpd1segcar_e_fs$size), list(time = as.numeric(sumpd1segcar_e_fs$segundos)))
pd_e_fs<-meanpd1segserver_e_fs$size[1:300]/meanpd1segcar_e_fs$size[1:300]
summary(pd_e_fs)

pd_e_server_fq<-traceserver_e_fq
pd_e_server_fq$size<-pd_e_server_fq$size/8/1498
sumpd1segserver_e_fq<-aggregate(list(size = pd_e_server_fq$size), list(segundos = cut(pd_e_server_fq$time, "1 sec")), sum)
meanpd1segserver_e_fq<-append(list(size = sumpd1segserver_e_fq$size), list(time = as.numeric(sumpd1segserver_e_fq$segundos)))
pd_e_car_fq<-tracecar_e_fq
pd_e_car_fq$size<-pd_e_car_fq$size/8/1498
sumpd1segcar_e_fq<-aggregate(list(size = pd_e_car_fq$size), list(segundos = cut(pd_e_car_fq$time, "1 sec")), sum)
meanpd1segcar_e_fq<-append(list(size = sumpd1segcar_e_fq$size), list(time = as.numeric(sumpd1segcar_e_fq$segundos)))
pd_e_fq<-meanpd1segserver_e_fq$size[1:300]/meanpd1segcar_e_fq$size[1:300]
summary(pd_e_fq)

pd_e_server_fn<-traceserver_e_fn
pd_e_server_fn$size<-pd_e_server_fn$size/8/1498
sumpd1segserver_e_fn<-aggregate(list(size = pd_e_server_fn$size), list(segundos = cut(pd_e_server_fn$time, "1 sec")), sum)
meanpd1segserver_e_fn<-append(list(size = sumpd1segserver_e_fn$size), list(time = as.numeric(sumpd1segserver_e_fn$segundos)))
pd_e_car_fn<-tracecar_e_fn
pd_e_car_fn$size<-pd_e_car_fn$size/8/1498
sumpd1segcar_e_fn<-aggregate(list(size = pd_e_car_fn$size), list(segundos = cut(pd_e_car_fn$time, "1 sec")), sum)
meanpd1segcar_e_fn<-append(list(size = sumpd1segcar_e_fn$size), list(time = as.numeric(sumpd1segcar_e_fn$segundos)))
pd_e_fn<-meanpd1segserver_e_fn$size[1:300]/meanpd1segcar_e_fn$size[1:300]
summary(pd_e_fn)

#E2

pd_e2_server_fs<-traceserver_e2_fs
pd_e2_server_fs$size<-pd_e2_server_fs$size/8/1498
sumpd1segserver_e2_fs<-aggregate(list(size = pd_e2_server_fs$size), list(segundos = cut(pd_e2_server_fs$time, "1 sec")), sum)
meanpd1segserver_e2_fs<-append(list(size = sumpd1segserver_e2_fs$size), list(time = as.numeric(sumpd1segserver_e2_fs$segundos)))
pd_e2_car_fs<-tracecar_e2_fs
pd_e2_car_fs$size<-pd_e2_car_fs$size/8/1498
sumpd1segcar_e2_fs<-aggregate(list(size = pd_e2_car_fs$size), list(segundos = cut(pd_e2_car_fs$time, "1 sec")), sum)
meanpd1segcar_e2_fs<-append(list(size = sumpd1segcar_e2_fs$size), list(time = as.numeric(sumpd1segcar_e2_fs$segundos)))
pd_e2_fs<-meanpd1segserver_e2_fs$size[1:300]/meanpd1segcar_e2_fs$size[1:300]
summary(pd_e2_fs)

pd_e2_server_fq<-traceserver_e2_fq
pd_e2_server_fq$size<-pd_e2_server_fq$size/8/1498
sumpd1segserver_e2_fq<-aggregate(list(size = pd_e2_server_fq$size), list(segundos = cut(pd_e2_server_fq$time, "1 sec")), sum)
meanpd1segserver_e2_fq<-append(list(size = sumpd1segserver_e2_fq$size), list(time = as.numeric(sumpd1segserver_e2_fq$segundos)))
pd_e2_car_fq<-tracecar_e2_fq
pd_e2_car_fq$size<-pd_e2_car_fq$size/8/1498
sumpd1segcar_e2_fq<-aggregate(list(size = pd_e2_car_fq$size), list(segundos = cut(pd_e2_car_fq$time, "1 sec")), sum)
meanpd1segcar_e2_fq<-append(list(size = sumpd1segcar_e2_fq$size), list(time = as.numeric(sumpd1segcar_e2_fq$segundos)))
pd_e2_fq<-meanpd1segserver_e2_fq$size[1:300]/meanpd1segcar_e2_fq$size[1:300]
summary(pd_e2_fq)

pd_e2_server_fn<-traceserver_e2_fn
pd_e2_server_fn$size<-pd_e2_server_fn$size/8/1498
sumpd1segserver_e2_fn<-aggregate(list(size = pd_e2_server_fn$size), list(segundos = cut(pd_e2_server_fn$time, "1 sec")), sum)
meanpd1segserver_e2_fn<-append(list(size = sumpd1segserver_e2_fn$size), list(time = as.numeric(sumpd1segserver_e2_fn$segundos)))
pd_e2_car_fn<-tracecar_e2_fn
pd_e2_car_fn$size<-pd_e2_car_fn$size/8/1498
sumpd1segcar_e2_fn<-aggregate(list(size = pd_e2_car_fn$size), list(segundos = cut(pd_e2_car_fn$time, "1 sec")), sum)
meanpd1segcar_e2_fn<-append(list(size = sumpd1segcar_e2_fn$size), list(time = as.numeric(sumpd1segcar_e2_fn$segundos)))
pd_e2_fn<-meanpd1segserver_e2_fn$size[1:300]/meanpd1segcar_e2_fn$size[1:300]
summary(pd_e2_fn)

#G
pd_g_server_fs<-traceserver_g_fs
pd_g_server_fs$size<-pd_g_server_fs$size/8/1498
sumpd1segserver_g_fs<-aggregate(list(size = pd_g_server_fs$size), list(segundos = cut(pd_g_server_fs$time, "1 sec")), sum)
meanpd1segserver_g_fs<-append(list(size = sumpd1segserver_g_fs$size), list(time = as.numeric(sumpd1segserver_g_fs$segundos)))
pd_g_car_fs<-tracecar_g_fs
pd_g_car_fs$size<-pd_g_car_fs$size/8/1498
sumpd1segcar_g_fs<-aggregate(list(size = pd_g_car_fs$size), list(segundos = cut(pd_g_car_fs$time, "1 sec")), sum)
meanpd1segcar_g_fs<-append(list(size = sumpd1segcar_g_fs$size), list(time = as.numeric(sumpd1segcar_g_fs$segundos)))
pd_g_fs<-meanpd1segserver_g_fs$size[1:300]/meanpd1segcar_g_fs$size[1:300]
summary(pd_g_fs)

pd_g_server_fq<-traceserver_g_fq
pd_g_server_fq$size<-pd_g_server_fq$size/8/1498
sumpd1segserver_g_fq<-aggregate(list(size = pd_g_server_fq$size), list(segundos = cut(pd_g_server_fq$time, "1 sec")), sum)
meanpd1segserver_g_fq<-append(list(size = sumpd1segserver_g_fq$size), list(time = as.numeric(sumpd1segserver_g_fq$segundos)))
pd_g_car_fq<-tracecar_g_fq
pd_g_car_fq$size<-pd_g_car_fq$size/8/1498
sumpd1segcar_g_fq<-aggregate(list(size = pd_g_car_fq$size), list(segundos = cut(pd_g_car_fq$time, "1 sec")), sum)
meanpd1segcar_g_fq<-append(list(size = sumpd1segcar_g_fq$size), list(time = as.numeric(sumpd1segcar_g_fq$segundos)))
pd_g_fq<-meanpd1segserver_g_fq$size[1:300]/meanpd1segcar_g_fq$size[1:300]
summary(pd_g_fq)

pd_g_server_fn<-traceserver_g_fn
pd_g_server_fn$size<-pd_g_server_fn$size/8/1498
sumpd1segserver_g_fn<-aggregate(list(size = pd_g_server_fn$size), list(segundos = cut(pd_g_server_fn$time, "1 sec")), sum)
meanpd1segserver_g_fn<-append(list(size = sumpd1segserver_g_fn$size), list(time = as.numeric(sumpd1segserver_g_fn$segundos)))
pd_g_car_fn<-tracecar_g_fn
pd_g_car_fn$size<-pd_g_car_fn$size/8/1498
sumpd1segcar_g_fn<-aggregate(list(size = pd_g_car_fn$size), list(segundos = cut(pd_g_car_fn$time, "1 sec")), sum)
meanpd1segcar_g_fn<-append(list(size = sumpd1segcar_g_fn$size), list(time = as.numeric(sumpd1segcar_g_fn$segundos)))
pd_g_fn<-meanpd1segserver_g_fn$size[1:300]/meanpd1segcar_g_fn$size[1:300]
summary(pd_g_fn)

#S

pd_s_server_fs<-traceserver_s_fs
pd_s_server_fs$size<-pd_s_server_fs$size/8/1498
sumpd1segserver_s_fs<-aggregate(list(size = pd_s_server_fs$size), list(segundos = cut(pd_s_server_fs$time, "1 sec")), sum)
meanpd1segserver_s_fs<-append(list(size = sumpd1segserver_s_fs$size), list(time = as.numeric(sumpd1segserver_s_fs$segundos)))
pd_s_car_fs<-tracecar_s_fs
pd_s_car_fs$size<-pd_s_car_fs$size/8/1498
sumpd1segcar_s_fs<-aggregate(list(size = pd_s_car_fs$size), list(segundos = cut(pd_s_car_fs$time, "1 sec")), sum)
meanpd1segcar_s_fs<-append(list(size = sumpd1segcar_s_fs$size), list(time = as.numeric(sumpd1segcar_s_fs$segundos)))
pd_s_fs<-meanpd1segserver_s_fs$size[1:300]/meanpd1segcar_s_fs$size[1:300]
summary(pd_s_fs)

pd_s_server_fq<-traceserver_s_fq
pd_s_server_fq$size<-pd_s_server_fq$size/8/1498
sumpd1segserver_s_fq<-aggregate(list(size = pd_s_server_fq$size), list(segundos = cut(pd_s_server_fq$time, "1 sec")), sum)
meanpd1segserver_s_fq<-append(list(size = sumpd1segserver_s_fq$size), list(time = as.numeric(sumpd1segserver_s_fq$segundos)))
pd_s_car_fq<-tracecar_s_fq
pd_s_car_fq$size<-pd_s_car_fq$size/8/1498
sumpd1segcar_s_fq<-aggregate(list(size = pd_s_car_fq$size), list(segundos = cut(pd_s_car_fq$time, "1 sec")), sum)
meanpd1segcar_s_fq<-append(list(size = sumpd1segcar_s_fq$size), list(time = as.numeric(sumpd1segcar_s_fq$segundos)))
pd_s_fq<-meanpd1segserver_s_fq$size[1:300]/meanpd1segcar_s_fq$size[1:300]
summary(pd_s_fq)

pd_s_server_fn<-traceserver_s_fn
pd_s_server_fn$size<-pd_s_server_fn$size/8/1498
sumpd1segserver_s_fn<-aggregate(list(size = pd_s_server_fn$size), list(segundos = cut(pd_s_server_fn$time, "1 sec")), sum)
meanpd1segserver_s_fn<-append(list(size = sumpd1segserver_s_fn$size), list(time = as.numeric(sumpd1segserver_s_fn$segundos)))
pd_s_car_fn<-tracecar_s_fn
pd_s_car_fn$size<-pd_s_car_fn$size/8/1498
sumpd1segcar_s_fn<-aggregate(list(size = pd_s_car_fn$size), list(segundos = cut(pd_s_car_fn$time, "1 sec")), sum)
meanpd1segcar_s_fn<-append(list(size = sumpd1segcar_s_fn$size), list(time = as.numeric(sumpd1segcar_s_fn$segundos)))
pd_s_fn<-meanpd1segserver_s_fn$size[1:300]/meanpd1segcar_s_fn$size[1:300]
summary(pd_s_fn)
