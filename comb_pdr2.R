##################PDRs

t <- 450

###APP E

###FS
#Compute Car sent Server E
tracecar_e_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_e_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_e_fs$time <- as.POSIXlt(tracecar_e_fs$time, origin = "1987-10-05 11:00:00")
pd_e_car<-tracecar_e_fs
pd_e_car$size<-pd_e_car$size/1498
sumpd1segcar_e_fs<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "1 sec")), sum)
meanpd1segcar_e_fs<-append(list(size = sumpd1segcar_e_fs$size), list(time = as.numeric(sumpd1segcar_e_fs$segundos)))

#Compute Server E received
traceserver_e_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_etf_car_fs_tt.txt', sep=' ')
names(traceserver_e_fs)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_fs$time <- as.POSIXlt(traceserver_e_fs$time, origin = "1987-10-05 11:00:00")
pd_e_server<-traceserver_e_fs
pd_e_server$size<-pd_e_server$size/1498
sumpd1segserver_e_fs<-aggregate(list(size = pd_e_server$size), list(segundos = cut(pd_e_server$time, "1 sec")), sum)
meanpd1segserver_e_fs<-append(list(size = sumpd1segserver_e_fs$size), list(time = as.numeric(sumpd1segserver_e_fs$segundos)))

#Compute PDR Server E FS
pdr1seg_e_fs<-append(list(pdr = mean1segserver_e_fs$size[1:t]/mean1segcar_e_fs$size[1:t]), list(time = c(1:t)))
pdr1seg_e_fs$pdr <- pdr1seg_e_fs$pdr[1:t]
pdr1seg_e_fs$pdr[pdr1seg_e_fs$pdr > 1] = 1


###FQ
#Compute Car sent Server E
tracecar_e_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fq_5003_tt.txt', sep=' ')
names(tracecar_e_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_e_fq$time <- as.POSIXlt(tracecar_e_fq$time, origin = "1987-10-05 11:00:00")
pd_e_car<-tracecar_e_fq
pd_e_car$size<-pd_e_car$size/1498
sumpd1segcar_e_fq<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "1 sec")), sum)
meanpd1segcar_e_fq<-append(list(size = sumpd1segcar_e_fq$size), list(time = as.numeric(sumpd1segcar_e_fq$segundos)))

#Compute Server E received
traceserver_e_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_etf_car_fq_tt.txt', sep=' ')
names(traceserver_e_fq)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_fq$time <- as.POSIXlt(traceserver_e_fq$time, origin = "1987-10-05 11:00:00")
pd_e_server<-traceserver_e_fq
pd_e_server$size<-pd_e_server$size/1498
sumpd1segserver_e_fq<-aggregate(list(size = pd_e_server$size), list(segundos = cut(pd_e_server$time, "1 sec")), sum)
meanpd1segserver_e_fq<-append(list(size = sumpd1segserver_e_fq$size), list(time = as.numeric(sumpd1segserver_e_fq$segundos)))

#Compute PDR Server E FQ
pdr1seg_e_fq<-append(list(pdr = mean1segserver_e_fq$size[1:t]/mean1segcar_e_fq$size[1:t]), list(time = c(1:t)))
pdr1seg_e_fq$pdr <- pdr1seg_e_fq$pdr[1:t]
pdr1seg_e_fq$pdr[pdr1seg_e_fq$pdr > 1] = 1


####FN
#Compute Car sent Server E
tracecar_e_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fn_5003_tt.txt', sep=' ')
names(tracecar_e_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_e_fn$time <- as.POSIXlt(tracecar_e_fn$time, origin = "1987-10-05 11:00:00")
pd_e_car<-tracecar_e_fn
pd_e_car$size<-pd_e_car$size/1498
sumpd1segcar_e_fn<-aggregate(list(size = pd_e_car$size), list(segundos = cut(pd_e_car$time, "1 sec")), sum)
meanpd1segcar_e_fn<-append(list(size = sumpd1segcar_e_fn$size), list(time = as.numeric(sumpd1segcar_e_fn$segundos)))

#Compute Server E received
traceserver_e_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_etf_car_fn_tt.txt', sep=' ')
names(traceserver_e_fn)<-c("time", "id", "size", "ori", "dest" )
traceserver_e_fn$time <- as.POSIXlt(traceserver_e_fn$time, origin = "1987-10-05 11:00:00")
pd_e_server<-traceserver_e_fn
pd_e_server$size<-pd_e_server$size/1498
sumpd1segserver_e_fn<-aggregate(list(size = pd_e_server$size), list(segundos = cut(pd_e_server$time, "1 sec")), sum)
meanpd1segserver_e_fn<-append(list(size = sumpd1segserver_e_fn$size), list(time = as.numeric(sumpd1segserver_e_fn$segundos)))

#Compute PDR Server E FN
pdr1seg_e_fn<-append(list(pdr = mean1segserver_e_fn$size[1:t]/mean1segcar_e_fn$size[1:t]), list(time = c(1:t)))
pdr1seg_e_fn$pdr <- pdr1seg_e_fn$pdr[1:t]
pdr1seg_e_fn$pdr[pdr1seg_e_fn$pdr > 1] = 1

time <- append(pdr1seg_e_fs$time, pdr1seg_e_fq$time)
time <- append(time, pdr1seg_e_fn$time)
pdr <- append(pdr1seg_e_fs$pdr, pdr1seg_e_fq$pdr)
pdr <- append(pdr, pdr1seg_e_fn$pdr)
tipo <- list(type= rep(c("Framework", "QoS Only", "Best effort"), each = t))
total_pre_e <- append(list(segundos = time), list(taxa = pdr))
total_final_e <- append(total_pre_e, tipo)
total_final_e <- data.frame(total_final_e)

#########
###APP E2

###FS
#Compute Car sent Server E2
tracecar_e2_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5004_tt.txt', sep=' ')
names(tracecar_e2_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_e2_fs$time <- as.POSIXlt(tracecar_e2_fs$time, origin = "1987-10-05 11:00:00")
pd_e2_car<-tracecar_e2_fs
pd_e2_car$size<-pd_e2_car$size/1498
sumpd1segcar_e2_fs<-aggregate(list(size = pd_e2_car$size), list(segundos = cut(pd_e2_car$time, "1 sec")), sum)
meanpd1segcar_e2_fs<-append(list(size = sumpd1segcar_e2_fs$size), list(time = as.numeric(sumpd1segcar_e2_fs$segundos)))

#Compute Server E2 received
traceserver_e2_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_e2tf_car_fs_tt.txt', sep=' ')
names(traceserver_e2_fs)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_fs$time <- as.POSIXlt(traceserver_e2_fs$time, origin = "1987-10-05 11:00:00")
pd_e2_server<-traceserver_e2_fs
pd_e2_server$size<-pd_e2_server$size/1498
sumpd1segserver_e2_fs<-aggregate(list(size = pd_e2_server$size), list(segundos = cut(pd_e2_server$time, "1 sec")), sum)
meanpd1segserver_e2_fs<-append(list(size = sumpd1segserver_e2_fs$size), list(time = as.numeric(sumpd1segserver_e2_fs$segundos)))

#Compute PDR Server E2 FS
pdr1seg_e2_fs<-append(list(pdr = mean1segserver_e2_fs$size[1:t]/mean1segcar_e2_fs$size[1:t]), list(time = c(1:t)))
pdr1seg_e2_fs$pdr <- pdr1seg_e2_fs$pdr[1:t]
pdr1seg_e2_fs$pdr[pdr1seg_e2_fs$pdr > 1] = 1


###FQ
#Compute Car sent Server E2
tracecar_e2_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fq_5004_tt.txt', sep=' ')
names(tracecar_e2_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_e2_fq$time <- as.POSIXlt(tracecar_e2_fq$time, origin = "1987-10-05 11:00:00")
pd_e2_car<-tracecar_e2_fq
pd_e2_car$size<-pd_e2_car$size/1498
sumpd1segcar_e2_fq<-aggregate(list(size = pd_e2_car$size), list(segundos = cut(pd_e2_car$time, "1 sec")), sum)
meanpd1segcar_e2_fq<-append(list(size = sumpd1segcar_e2_fq$size), list(time = as.numeric(sumpd1segcar_e2_fq$segundos)))

#Compute Server E2 received
traceserver_e2_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_e2tf_car_fq_tt.txt', sep=' ')
names(traceserver_e2_fq)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_fq$time <- as.POSIXlt(traceserver_e2_fq$time, origin = "1987-10-05 11:00:00")
pd_e2_server<-traceserver_e2_fq
pd_e2_server$size<-pd_e2_server$size/1498
sumpd1segserver_e2_fq<-aggregate(list(size = pd_e2_server$size), list(segundos = cut(pd_e2_server$time, "1 sec")), sum)
meanpd1segserver_e2_fq<-append(list(size = sumpd1segserver_e2_fq$size), list(time = as.numeric(sumpd1segserver_e2_fq$segundos)))

#Compute PDR Server E2 FQ
pdr1seg_e2_fq<-append(list(pdr = mean1segserver_e2_fq$size[1:t]/mean1segcar_e2_fq$size[1:t]), list(time = c(1:t)))
pdr1seg_e2_fq$pdr <- pdr1seg_e2_fq$pdr[1:t]
pdr1seg_e2_fq$pdr[pdr1seg_e2_fq$pdr > 1] = 1


####FN
#Compute Car sent Server E2
tracecar_e2_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fn_5004_tt.txt', sep=' ')
names(tracecar_e2_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_e2_fn$time <- as.POSIXlt(tracecar_e2_fn$time, origin = "1987-10-05 11:00:00")
pd_e2_car<-tracecar_e2_fn
pd_e2_car$size<-pd_e2_car$size/1498
sumpd1segcar_e2_fn<-aggregate(list(size = pd_e2_car$size), list(segundos = cut(pd_e2_car$time, "1 sec")), sum)
meanpd1segcar_e2_fn<-append(list(size = sumpd1segcar_e2_fn$size), list(time = as.numeric(sumpd1segcar_e2_fn$segundos)))

#Compute Server E2 received
traceserver_e2_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_e2tf_car_fn_tt.txt', sep=' ')
names(traceserver_e2_fn)<-c("time", "id", "size", "ori", "dest" )
traceserver_e2_fn$time <- as.POSIXlt(traceserver_e2_fn$time, origin = "1987-10-05 11:00:00")
pd_e2_server<-traceserver_e2_fn
pd_e2_server$size<-pd_e2_server$size/1498
sumpd1segserver_e2_fn<-aggregate(list(size = pd_e2_server$size), list(segundos = cut(pd_e2_server$time, "1 sec")), sum)
meanpd1segserver_e2_fn<-append(list(size = sumpd1segserver_e2_fn$size), list(time = as.numeric(sumpd1segserver_e2_fn$segundos)))

#Compute PDR Server E2 FN
pdr1seg_e2_fn<-append(list(pdr = mean1segserver_e2_fn$size[1:t]/mean1segcar_e2_fn$size[1:t]), list(time = c(1:t)))
pdr1seg_e2_fn$pdr <- pdr1seg_e2_fn$pdr[1:t]
pdr1seg_e2_fn$pdr[pdr1seg_e2_fn$pdr > 1] = 1

time <- append(pdr1seg_e2_fs$time, pdr1seg_e2_fq$time)
time <- append(time, pdr1seg_e2_fn$time)
pdr <- append(pdr1seg_e2_fs$pdr, pdr1seg_e2_fq$pdr)
pdr <- append(pdr, pdr1seg_e2_fn$pdr)
tipo <- list(type= rep(c("Framework", "QoS Only", "Best effort"), each = t))
total_pre_e2 <- append(list(segundos = time), list(taxa = pdr))
total_final_e2 <- append(total_pre_e2, tipo)
total_final_e2 <- data.frame(total_final_e2)

######################
#APP G
###FS
#Compute Car sent Server G
tracecar_g_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5005_tt.txt', sep=' ')
names(tracecar_g_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_g_fs$time <- as.POSIXlt(tracecar_g_fs$time, origin = "1987-10-05 11:00:00")
pd_g_car<-tracecar_g_fs
pd_g_car$size<-pd_g_car$size/1498
sumpd1segcar_g_fs<-aggregate(list(size = pd_g_car$size), list(segundos = cut(pd_g_car$time, "1 sec")), sum)
meanpd1segcar_g_fs<-append(list(size = sumpd1segcar_g_fs$size), list(time = as.numeric(sumpd1segcar_g_fs$segundos)))

#Compute Server G received
traceserver_g_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_gtf_car_fs_tt.txt', sep=' ')
names(traceserver_g_fs)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_fs$time <- as.POSIXlt(traceserver_g_fs$time, origin = "1987-10-05 11:00:00")
pd_g_server<-traceserver_g_fs
pd_g_server$size<-pd_g_server$size/1498
sumpd1segserver_g_fs<-aggregate(list(size = pd_g_server$size), list(segundos = cut(pd_g_server$time, "1 sec")), sum)
meanpd1segserver_g_fs<-append(list(size = sumpd1segserver_g_fs$size), list(time = as.numeric(sumpd1segserver_g_fs$segundos)))

#Compute PDR Server G FS
pdr1seg_g_fs<-append(list(pdr = mean1segserver_g_fs$size[1:t]/mean1segcar_g_fs$size[1:t]), list(time = c(1:t)))
pdr1seg_g_fs$pdr <- pdr1seg_g_fs$pdr[1:t]
pdr1seg_g_fs$pdr[pdr1seg_g_fs$pdr > 1] = 1


###FQ
#Compute Car sent Server G
tracecar_g_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fq_5005_tt.txt', sep=' ')
names(tracecar_g_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_g_fq$time <- as.POSIXlt(tracecar_g_fq$time, origin = "1987-10-05 11:00:00")
pd_g_car<-tracecar_g_fq
pd_g_car$size<-pd_g_car$size/1498
sumpd1segcar_g_fq<-aggregate(list(size = pd_g_car$size), list(segundos = cut(pd_g_car$time, "1 sec")), sum)
meanpd1segcar_g_fq<-append(list(size = sumpd1segcar_g_fq$size), list(time = as.numeric(sumpd1segcar_g_fq$segundos)))

#Compute Server G received
traceserver_g_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_gtf_car_fq_tt.txt', sep=' ')
names(traceserver_g_fq)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_fq$time <- as.POSIXlt(traceserver_g_fq$time, origin = "1987-10-05 11:00:00")
pd_g_server<-traceserver_g_fq
pd_g_server$size<-pd_g_server$size/1498
sumpd1segserver_g_fq<-aggregate(list(size = pd_g_server$size), list(segundos = cut(pd_g_server$time, "1 sec")), sum)
meanpd1segserver_g_fq<-append(list(size = sumpd1segserver_g_fq$size), list(time = as.numeric(sumpd1segserver_g_fq$segundos)))

#Compute PDR Server G FQ
pdr1seg_g_fq<-append(list(pdr = mean1segserver_g_fq$size[1:t]/mean1segcar_g_fq$size[1:t]), list(time = c(1:t)))
pdr1seg_g_fq$pdr <- pdr1seg_g_fq$pdr[1:t]
pdr1seg_g_fq$pdr[pdr1seg_g_fq$pdr > 1] = 1


####FN
#Compute Car sent Server G
tracecar_g_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fn_5005_tt.txt', sep=' ')
names(tracecar_g_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_g_fn$time <- as.POSIXlt(tracecar_g_fn$time, origin = "1987-10-05 11:00:00")
pd_g_car<-tracecar_g_fn
pd_g_car$size<-pd_g_car$size/1498
sumpd1segcar_g_fn<-aggregate(list(size = pd_g_car$size), list(segundos = cut(pd_g_car$time, "1 sec")), sum)
meanpd1segcar_g_fn<-append(list(size = sumpd1segcar_g_fn$size), list(time = as.numeric(sumpd1segcar_g_fn$segundos)))

#Compute Server G received
traceserver_g_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_gtf_car_fn_tt.txt', sep=' ')
names(traceserver_g_fn)<-c("time", "id", "size", "ori", "dest" )
traceserver_g_fn$time <- as.POSIXlt(traceserver_g_fn$time, origin = "1987-10-05 11:00:00")
pd_g_server<-traceserver_g_fn
pd_g_server$size<-pd_g_server$size/1498
sumpd1segserver_g_fn<-aggregate(list(size = pd_g_server$size), list(segundos = cut(pd_g_server$time, "1 sec")), sum)
meanpd1segserver_g_fn<-append(list(size = sumpd1segserver_g_fn$size), list(time = as.numeric(sumpd1segserver_g_fn$segundos)))

#Compute PDR Server G FN
pdr1seg_g_fn<-append(list(pdr = mean1segserver_g_fn$size[1:t]/mean1segcar_g_fn$size[1:t]), list(time = c(1:t)))
pdr1seg_g_fn$pdr <- pdr1seg_g_fn$pdr[1:t]
pdr1seg_g_fn$pdr[pdr1seg_g_fn$pdr > 1] = 1

time <- append(pdr1seg_g_fs$time, pdr1seg_g_fq$time)
time <- append(time, pdr1seg_g_fn$time)
pdr <- append(pdr1seg_g_fs$pdr, pdr1seg_g_fq$pdr)
pdr <- append(pdr, pdr1seg_g_fn$pdr)
tipo <- list(type= rep(c("Framework", "QoS Only", "Best effort"), each = t))
total_pre_g <- append(list(segundos = time), list(taxa = pdr))
total_final_g <- append(total_pre_g, tipo)
total_final_g <- data.frame(total_final_g)

################################################################################
#APP S
#Compute Car sent Server S
tracecar_s_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5002_tt.txt', sep=' ')
names(tracecar_s_fs)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_s_fs$time <- as.POSIXlt(tracecar_s_fs$time, origin = "1987-10-05 11:00:00")
pd_s_car<-tracecar_s_fs
pd_s_car$size<-pd_s_car$size/1498
sumpd1segcar_s_fs<-aggregate(list(size = pd_s_car$size), list(segundos = cut(pd_s_car$time, "1 sec")), sum)
meanpd1segcar_s_fs<-append(list(size = sumpd1segcar_s_fs$size), list(time = as.numeric(sumpd1segcar_s_fs$segundos)))

#Compute Server S received
traceserver_s_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_stf_car_fs_tt.txt', sep=' ')
names(traceserver_s_fs)<-c("time", "id", "size", "ori", "dest" )
traceserver_s_fs$time <- as.POSIXlt(traceserver_s_fs$time, origin = "1987-10-05 11:00:00")
pd_s_server<-traceserver_s_fs
pd_s_server$size<-pd_s_server$size/1498
sumpd1segserver_s_fs<-aggregate(list(size = pd_s_server$size), list(segundos = cut(pd_s_server$time, "1 sec")), sum)
meanpd1segserver_s_fs<-append(list(size = sumpd1segserver_s_fs$size), list(time = as.numeric(sumpd1segserver_s_fs$segundos)))

#Compute PDR Server S FS
pdr1seg_s_fs<-append(list(pdr = mean1segserver_s_fs$size[1:t]/mean1segcar_s_fs$size[1:t]), list(time = c(1:t)))
pdr1seg_s_fs$pdr <- pdr1seg_s_fs$pdr[1:t]
pdr1seg_s_fs$pdr[pdr1seg_s_fs$pdr > 1] = 1


###FQ
#Compute Car sent Server S
tracecar_s_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fq_5002_tt.txt', sep=' ')
names(tracecar_s_fq)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_s_fq$time <- as.POSIXlt(tracecar_s_fq$time, origin = "1987-10-05 11:00:00")
pd_s_car<-tracecar_s_fq
pd_s_car$size<-pd_s_car$size/1498
sumpd1segcar_s_fq<-aggregate(list(size = pd_s_car$size), list(segundos = cut(pd_s_car$time, "1 sec")), sum)
meanpd1segcar_s_fq<-append(list(size = sumpd1segcar_s_fq$size), list(time = as.numeric(sumpd1segcar_s_fq$segundos)))

#Compute Server S received
traceserver_s_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_stf_car_fq_tt.txt', sep=' ')
names(traceserver_s_fq)<-c("time", "id", "size", "ori", "dest" )
traceserver_s_fq$time <- as.POSIXlt(traceserver_s_fq$time, origin = "1987-10-05 11:00:00")
pd_s_server<-traceserver_s_fq
pd_s_server$size<-pd_s_server$size/1498
sumpd1segserver_s_fq<-aggregate(list(size = pd_s_server$size), list(segundos = cut(pd_s_server$time, "1 sec")), sum)
meanpd1segserver_s_fq<-append(list(size = sumpd1segserver_s_fq$size), list(time = as.numeric(sumpd1segserver_s_fq$segundos)))

#Compute PDR Server S FQ
pdr1seg_s_fq<-append(list(pdr = mean1segserver_s_fq$size[1:t]/mean1segcar_s_fq$size[1:t]), list(time = c(1:t)))
pdr1seg_s_fq$pdr <- pdr1seg_s_fq$pdr[1:t]
pdr1seg_s_fq$pdr[pdr1seg_s_fq$pdr > 1] = 1


####FN
#Compute Car sent Server S
tracecar_s_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fn_5002_tt.txt', sep=' ')
names(tracecar_s_fn)<-c("time", "id", "size", "ori", "dest" )
options(drigits.secs = 6)
tracecar_s_fn$time <- as.POSIXlt(tracecar_s_fn$time, origin = "1987-10-05 11:00:00")
pd_s_car<-tracecar_s_fn
pd_s_car$size<-pd_s_car$size/1498
sumpd1segcar_s_fn<-aggregate(list(size = pd_s_car$size), list(segundos = cut(pd_s_car$time, "1 sec")), sum)
meanpd1segcar_s_fn<-append(list(size = sumpd1segcar_s_fn$size), list(time = as.numeric(sumpd1segcar_s_fn$segundos)))

#Compute Server S received
traceserver_s_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/server_stf_car_fn_tt.txt', sep=' ')
names(traceserver_s_fn)<-c("time", "id", "size", "ori", "dest" )
traceserver_s_fn$time <- as.POSIXlt(traceserver_s_fn$time, origin = "1987-10-05 11:00:00")
pd_s_server<-traceserver_s_fn
pd_s_server$size<-pd_s_server$size/1498
sumpd1segserver_s_fn<-aggregate(list(size = pd_s_server$size), list(segundos = cut(pd_s_server$time, "1 sec")), sum)
meanpd1segserver_s_fn<-append(list(size = sumpd1segserver_s_fn$size), list(time = as.numeric(sumpd1segserver_s_fn$segundos)))

#Compute PDR Server S FN
pdr1seg_s_fn<-append(list(pdr = mean1segserver_s_fn$size[1:t]/mean1segcar_s_fn$size[1:t]), list(time = c(1:t)))
pdr1seg_s_fn$pdr <- pdr1seg_s_fn$pdr[1:t]
pdr1seg_s_fn$pdr[pdr1seg_s_fn$pdr > 1] = 1

time <- append(pdr1seg_s_fs$time, pdr1seg_s_fq$time)
time <- append(time, pdr1seg_s_fn$time)
pdr <- append(pdr1seg_s_fs$pdr, pdr1seg_s_fq$pdr)
pdr <- append(pdr, pdr1seg_s_fn$pdr)
tipo <- list(type= rep(c("Framework", "QoS Only", "Best effort"), each = t))
total_pre_s <- append(list(segundos = time), list(taxa = pdr))
total_final_s <- append(total_pre_s, tipo)
total_final_s <- data.frame(total_final_s)

##########################################Final

total_final_e$app <- "E"
total_final_e2$app <- "E2"
total_final_g$app <- "G"
total_final_s$app <- "S"

names(total_final_e) <- c("tempo", "pdr", "tipo", "app")
names(total_final_e2) <- c("tempo", "pdr", "tipo", "app")
names(total_final_g) <- c("tempo", "pdr", "tipo", "app")
names(total_final_s) <- c("tempo", "pdr", "tipo", "app")

pdr_final <- rbind(total_final_e, total_final_e2, total_final_g, total_final_s)

#Plot

library(ggplot2)
library(dplyr)


ggplot(pdr_final, aes(x=tipo, y=pdr, fill=app)) +
  geom_violin()


#E
e_app <- pdr_final %>%
        filter(app == "E" ) %>%
        select("pdr", "tipo")
  
ggplot(e_app, aes(x=tipo, y=pdr)) + 
  geom_violin(trim=TRUE, fill="gray")+
  labs(title="",x="", y = "PDR")+
  geom_boxplot(width=0.1)+
  scale_y_continuous(breaks = c(0.2, 0.4, 0.6, 0.8, 1.0)) +
  theme_bw() + theme(
        axis.text.x=element_text(size=28,vjust=1),
        axis.text.y=element_text(size=28, angle = 90, hjust=0.55,vjust=1),
        axis.title.y = element_text(size=28, angle = 90))
                     

#E2
e2_app <- pdr_final %>%
  filter(app == "E2" ) %>%
  select("pdr", "tipo")

ggplot(e2_app, aes(x=tipo, y=pdr)) + 
  geom_violin(trim=TRUE, fill="gray")+
  labs(title="",x="", y = "PDR")+
  geom_boxplot(width=0.05)+
  scale_y_continuous(breaks = c(0.2, 0.4, 0.6, 0.8, 1.0)) +
  theme_bw() + theme(
    axis.text.x=element_text(size=28,vjust=1),
    axis.text.y=element_text(size=28, angle = 90, hjust=0.55,vjust=1),
    axis.title.y = element_text(size=28, angle = 90))

#G
g_app <- pdr_final %>%
  filter(app == "G" ) %>%
  select("pdr", "tipo")

ggplot(g_app, aes(x=tipo, y=pdr)) + 
  geom_violin(trim=TRUE, fill="gray")+
  labs(title="",x="", y = "PDR")+
  geom_boxplot(width=0.05)+
  scale_y_continuous(breaks = c(0.2, 0.4, 0.6, 0.8, 1.0)) +
  theme_bw() + theme(
    axis.text.x=element_text(size=28,vjust=1),
    axis.text.y=element_text(size=28, angle = 90, hjust=0.55,vjust=1),
    axis.title.y = element_text(size=28, angle = 90))

#S
s_app <- pdr_final %>%
  filter(app == "S" ) %>%
  select("pdr", "tipo")

ggplot(s_app, aes(x=tipo, y=pdr)) + 
  geom_violin(trim=TRUE, fill="gray")+
  labs(title="",x="", y = "PDR")+
  geom_boxplot(width=0.1)+
  scale_y_continuous(breaks = c(0.2, 0.4, 0.6, 0.8, 1.0)) +
  theme_bw() + theme(
    axis.text.x=element_text(size=28,vjust=1),
    axis.text.y=element_text(size=28, angle = 90, hjust=0.55,vjust=1),
    axis.title.y = element_text(size=28, angle = 90))

