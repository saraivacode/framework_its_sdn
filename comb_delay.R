#Delay cdf
library(dplyr)
t <-450
###AppE
#FS
#Compute Delay Server E
tracedelay_e_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_e_fs_tt.txt')
names(tracedelay_e_fs)<-c("time", "delay")
tracecar_e_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5003_tt.txt', sep=' ')
names(tracecar_e_fs)<-c("time", "id", "size", "ori", "dest" )
tracedelay_e_fs$time <- as.POSIXlt(tracedelay_e_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e_fs$time <- as.POSIXlt(tracecar_e_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e_fs$hour <- format(tracecar_e_fs$time, format = "%H")
tracecar_e_fs$minute <- format(tracecar_e_fs$time, format = "%M")
tracecar_e_fs$second <- format(tracecar_e_fs$time, format = "%S")
sum1segdelay_e_fs<-aggregate(list(delay = tracedelay_e_fs$delay), list(segundos = cut(tracedelay_e_fs$time, "1 sec")), sum)
xs<- tracecar_e_fs %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_e_fs<-append(list(size = sum1segdelay_e_fs$delay), list(time = as.numeric(sum1segdelay_e_fs$segundos)))
mean1segdelay_e_fs$transmissores <- xs$transmissores
mean1segdelay_e_fs$size <- mean1segdelay_e_fs$size[1:t] / mean1segdelay_e_fs$transmissores[1:t]

#FQ
#Compute Delay Server E
tracedelay_e_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_e_fq_tt.txt')
names(tracedelay_e_fq)<-c("time", "delay")
tracecar_e_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fq_5003_tt.txt', sep=' ')
names(tracecar_e_fq)<-c("time", "id", "size", "ori", "dest" )
tracedelay_e_fq$time <- as.POSIXlt(tracedelay_e_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e_fq$time <- as.POSIXlt(tracecar_e_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e_fq$hour <- format(tracecar_e_fq$time, format = "%H")
tracecar_e_fq$minute <- format(tracecar_e_fq$time, format = "%M")
tracecar_e_fq$second <- format(tracecar_e_fq$time, format = "%S")
sum1segdelay_e_fq<-aggregate(list(delay = tracedelay_e_fq$delay), list(segundos = cut(tracedelay_e_fq$time, "1 sec")), sum)
xs<- tracecar_e_fq %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_e_fq<-append(list(size = sum1segdelay_e_fq$delay), list(time = as.numeric(sum1segdelay_e_fq$segundos)))
mean1segdelay_e_fq$transmissores <- xs$transmissores
mean1segdelay_e_fq$size <- mean1segdelay_e_fq$size[1:t] / mean1segdelay_e_fq$transmissores[1:t]

#FN
#Compute Delay Server E
tracedelay_e_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_e_fn_tt.txt')
names(tracedelay_e_fn)<-c("time", "delay")
tracecar_e_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fn_5003_tt.txt', sep=' ')
names(tracecar_e_fn)<-c("time", "id", "size", "ori", "dest" )
tracedelay_e_fn$time <- as.POSIXlt(tracedelay_e_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e_fn$time <- as.POSIXlt(tracecar_e_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e_fn$hour <- format(tracecar_e_fn$time, format = "%H")
tracecar_e_fn$minute <- format(tracecar_e_fn$time, format = "%M")
tracecar_e_fn$second <- format(tracecar_e_fn$time, format = "%S")
sum1segdelay_e_fn<-aggregate(list(delay = tracedelay_e_fn$delay), list(segundos = cut(tracedelay_e_fn$time, "1 sec")), sum)
xs<- tracecar_e_fn %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_e_fn<-append(list(size = sum1segdelay_e_fn$delay), list(time = as.numeric(sum1segdelay_e_fn$segundos)))
mean1segdelay_e_fn$transmissores <- xs$transmissores
mean1segdelay_e_fn$size <- mean1segdelay_e_fn$size[1:t] / mean1segdelay_e_fn$transmissores[1:t]

mean1segdelay_e_fs$size <- mean1segdelay_e_fs$size[1:t]
mean1segdelay_e_fs$time <- mean1segdelay_e_fs$time[1:t]
mean1segdelay_e_fs$transmissores <- mean1segdelay_e_fs$transmissores[1:t]
mean1segdelay_e_fs <- data.frame(mean1segdelay_e_fs)

mean1segdelay_e_fq$size <- mean1segdelay_e_fq$size[1:t]
mean1segdelay_e_fq$time <- mean1segdelay_e_fq$time[1:t]
mean1segdelay_e_fq$transmissores <- mean1segdelay_e_fq$transmissores[1:t]
mean1segdelay_e_fq <- data.frame(mean1segdelay_e_fq)

mean1segdelay_e_fn$size <- mean1segdelay_e_fn$size[1:t]
mean1segdelay_e_fn$time <- mean1segdelay_e_fn$time[1:t]
mean1segdelay_e_fn$transmissores <- mean1segdelay_e_fn$transmissores[1:t]
mean1segdelay_e_fn <- data.frame(mean1segdelay_e_fn)

library(ggplot2)
library(tidyverse)
data.frame(approach = c(rep("Framework", nrow(mean1segdelay_e_fs)),
                   rep("QoS only", nrow(mean1segdelay_e_fq)),
                   rep("Best effort", nrow(mean1segdelay_e_fn))),
           value = c(mean1segdelay_e_fs$size,
                     mean1segdelay_e_fq$size,
                     mean1segdelay_e_fn$size)) %>%
ggplot(aes(value, colour=approach, shape=approach)) +
  scale_colour_grey() +
  stat_ecdf(geo = "point", size = 4) +
labs(title="",
     y = "PDR", x="RTT (ms)")+
  theme_bw()+
  theme(axis.text.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = .5, face = "plain"),
        axis.text.y = element_text(color = "grey20", size = 20, angle = 0, hjust = 1, vjust = 0, face = "plain"),  
        axis.title.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = 0, face = "plain"),
        axis.title.y = element_text(color = "grey20", size = 20, angle = 90, hjust = .5, vjust = .5, face = "plain"),
        legend.title = element_text(color = "white", size = 20),
        legend.text = element_text(color = "black", size = 20),
        legend.position = c(0.85, 0.2))+
  guides(shape = guide_legend(override.aes = list(size = 5)))

#plot(ecdf(mean1segdelay_e_fs$size), col.01line = "gray70", pch = 19, col="red", xlim = c(0,2000), ylim = c(0,1), main="CDF Delay Application E", ylab = "CDF", xlab = "delay")
#abline( h= 0.8, lty =3, col = "gray60")
#par(new=T)
#plot(ecdf(mean1segdelay_e_fq$size), col.01line = "gray70", pch = 19, col="blue", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA, main ="")
#par(new=T)
#plot(ecdf(mean1segdelay_e_fn$size), col.01line = "gray70", pch = 19, col="orange", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA,  main ="")
#legend("bottomright", legend=c("Framework", "QoS only", "Best effort"), lty=c(1,1,1), col=c("red", "blue", "orange"))

#############################################
###################################################################################################AppE2

#FS
#Compute Delay Server E2
tracedelay_e2_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_e2_fs_tt.txt')
names(tracedelay_e2_fs)<-c("time", "delay")
tracecar_e2_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5004_tt.txt', sep=' ')
names(tracecar_e2_fs)<-c("time", "id", "size", "ori", "dest" )
tracedelay_e2_fs$time <- as.POSIXlt(tracedelay_e2_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fs$time <- as.POSIXlt(tracecar_e2_fs$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fs$hour <- format(tracecar_e2_fs$time, format = "%H")
tracecar_e2_fs$minute <- format(tracecar_e2_fs$time, format = "%M")
tracecar_e2_fs$second <- format(tracecar_e2_fs$time, format = "%S")
sum1segdelay_e2_fs<-aggregate(list(delay = tracedelay_e2_fs$delay), list(segundos = cut(tracedelay_e2_fs$time, "1 sec")), sum)
xs<- tracecar_e2_fs %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_e2_fs<-append(list(size = sum1segdelay_e2_fs$delay), list(time = as.numeric(sum1segdelay_e2_fs$segundos)))
mean1segdelay_e2_fs$transmissores <- xs$transmissores
mean1segdelay_e2_fs$size <- mean1segdelay_e2_fs$size[1:t] / mean1segdelay_e2_fs$transmissores[1:t]

#FQ
#Compute Delay Server E2
tracedelay_e2_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_e2_fq_tt.txt')
names(tracedelay_e2_fq)<-c("time", "delay")
tracecar_e2_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fq_5004_tt.txt', sep=' ')
names(tracecar_e2_fq)<-c("time", "id", "size", "ori", "dest" )
tracedelay_e2_fq$time <- as.POSIXlt(tracedelay_e2_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fq$time <- as.POSIXlt(tracecar_e2_fq$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fq$hour <- format(tracecar_e2_fq$time, format = "%H")
tracecar_e2_fq$minute <- format(tracecar_e2_fq$time, format = "%M")
tracecar_e2_fq$second <- format(tracecar_e2_fq$time, format = "%S")
sum1segdelay_e2_fq<-aggregate(list(delay = tracedelay_e2_fq$delay), list(segundos = cut(tracedelay_e2_fq$time, "1 sec")), sum)
xs<- tracecar_e2_fq %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_e2_fq<-append(list(size = sum1segdelay_e2_fq$delay), list(time = as.numeric(sum1segdelay_e2_fq$segundos)))
mean1segdelay_e2_fq$transmissores <- xs$transmissores
mean1segdelay_e2_fq$size <- mean1segdelay_e2_fq$size[1:t] / mean1segdelay_e2_fq$transmissores[1:t]

#FN
#Compute Delay Server E2
tracedelay_e2_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_e2_fn_tt.txt')
names(tracedelay_e2_fn)<-c("time", "delay")
tracecar_e2_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fn_5004_tt.txt', sep=' ')
names(tracecar_e2_fn)<-c("time", "id", "size", "ori", "dest" )
tracedelay_e2_fn$time <- as.POSIXlt(tracedelay_e2_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fn$time <- as.POSIXlt(tracecar_e2_fn$time, origin = "1987-10-05 11:00:00")
tracecar_e2_fn$hour <- format(tracecar_e2_fn$time, format = "%H")
tracecar_e2_fn$minute <- format(tracecar_e2_fn$time, format = "%M")
tracecar_e2_fn$second <- format(tracecar_e2_fn$time, format = "%S")
sum1segdelay_e2_fn<-aggregate(list(delay = tracedelay_e2_fn$delay), list(segundos = cut(tracedelay_e2_fn$time, "1 sec")), sum)
xs<- tracecar_e2_fn %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_e2_fn<-append(list(size = sum1segdelay_e2_fn$delay), list(time = as.numeric(sum1segdelay_e2_fn$segundos)))
mean1segdelay_e2_fn$transmissores <- xs$transmissores
mean1segdelay_e2_fn$size <- mean1segdelay_e2_fn$size[1:t] / mean1segdelay_e2_fn$transmissores[1:t]

mean1segdelay_e2_fs$size <- mean1segdelay_e2_fs$size[1:t]
mean1segdelay_e2_fs$time <- mean1segdelay_e2_fs$time[1:t]
mean1segdelay_e2_fs$transmissores <- mean1segdelay_e2_fs$transmissores[1:t]
mean1segdelay_e2_fs <- data.frame(mean1segdelay_e2_fs)

mean1segdelay_e2_fq$size <- mean1segdelay_e2_fq$size[1:t]
mean1segdelay_e2_fq$time <- mean1segdelay_e2_fq$time[1:t]
mean1segdelay_e2_fq$transmissores <- mean1segdelay_e2_fq$transmissores[1:t]
mean1segdelay_e2_fq <- data.frame(mean1segdelay_e2_fq)

mean1segdelay_e2_fn$size <- mean1segdelay_e2_fn$size[1:t]
mean1segdelay_e2_fn$time <- mean1segdelay_e2_fn$time[1:t]
mean1segdelay_e2_fn$transmissores <- mean1segdelay_e2_fn$transmissores[1:t]
mean1segdelay_e2_fn <- data.frame(mean1segdelay_e2_fn)


data.frame(approach = c(rep("Framework", nrow(mean1segdelay_e2_fs)),
                        rep("QoS only", nrow(mean1segdelay_e2_fq)),
                        rep("Best effort", nrow(mean1segdelay_e2_fn))),
           value = c(mean1segdelay_e2_fs$size,
                     mean1segdelay_e2_fq$size,
                     mean1segdelay_e2_fn$size)) %>%
  ggplot(aes(value, colour=approach, shape=approach)) +
  scale_colour_grey() +
  stat_ecdf(geo = "point", size = 4) +
  labs(title="",
       y = "PDR", x="RTT (ms)")+
  theme_bw()+
  theme(axis.text.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = .5, face = "plain"),
        axis.text.y = element_text(color = "grey20", size = 20, angle = 0, hjust = 1, vjust = 0, face = "plain"),  
        axis.title.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = 0, face = "plain"),
        axis.title.y = element_text(color = "grey20", size = 20, angle = 90, hjust = .5, vjust = .5, face = "plain"),
        legend.title = element_text(color = "white", size = 20),
        legend.text = element_text(color = "black", size = 20),
        legend.position = c(0.85, 0.2)) +
  guides(shape = guide_legend(override.aes = list(size = 5)))


#plot(ecdf(mean1segdelay_e2_fs$size), col.01line = "gray70", pch = 19, col="red", xlim = c(0,2000), ylim = c(0,1), main="CDF Delay Application E", ylab = "CDF", xlab = "delay")
#abline( h= 0.8, lty =3, col = "gray60")
#par(new=T)
#plot(ecdf(mean1segdelay_e2_fq$size), col.01line = "gray70", pch = 19, col="blue", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA, main ="")
#par(new=T)
#plot(ecdf(mean1segdelay_e2_fn$size), col.01line = "gray70", pch = 19, col="orange", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA,  main ="")
#legend("bottomright", legend=c("Framework", "QoS only", "Best effort"), lty=c(1,1,1), col=c("red", "blue", "orange"))

##############################################################################3#App G

#FS
#Compute Delay Server G
tracedelay_g_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_g_fs_tt.txt')
names(tracedelay_g_fs)<-c("time", "delay")
tracecar_g_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5005_tt.txt', sep=' ')
names(tracecar_g_fs)<-c("time", "id", "size", "ori", "dest" )
tracedelay_g_fs$time <- as.POSIXlt(tracedelay_g_fs$time, origin = "1987-10-05 11:00:00")
tracecar_g_fs$time <- as.POSIXlt(tracecar_g_fs$time, origin = "1987-10-05 11:00:00")
tracecar_g_fs$hour <- format(tracecar_g_fs$time, format = "%H")
tracecar_g_fs$minute <- format(tracecar_g_fs$time, format = "%M")
tracecar_g_fs$second <- format(tracecar_g_fs$time, format = "%S")
sum1segdelay_g_fs<-aggregate(list(delay = tracedelay_g_fs$delay), list(segundos = cut(tracedelay_g_fs$time, "1 sec")), sum)
xs<- tracecar_g_fs %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_g_fs<-append(list(size = sum1segdelay_g_fs$delay), list(time = as.numeric(sum1segdelay_g_fs$segundos)))
mean1segdelay_g_fs$transmissores <- xs$transmissores
mean1segdelay_g_fs$size <- mean1segdelay_g_fs$size[1:t] / mean1segdelay_g_fs$transmissores[1:t]

#FQ
#Compute Delay Server G
tracedelay_g_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_g_fq_tt.txt')
names(tracedelay_g_fq)<-c("time", "delay")
tracecar_g_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fq_5005_tt.txt', sep=' ')
names(tracecar_g_fq)<-c("time", "id", "size", "ori", "dest" )
tracedelay_g_fq$time <- as.POSIXlt(tracedelay_g_fq$time, origin = "1987-10-05 11:00:00")
tracecar_g_fq$time <- as.POSIXlt(tracecar_g_fq$time, origin = "1987-10-05 11:00:00")
tracecar_g_fq$hour <- format(tracecar_g_fq$time, format = "%H")
tracecar_g_fq$minute <- format(tracecar_g_fq$time, format = "%M")
tracecar_g_fq$second <- format(tracecar_g_fq$time, format = "%S")
sum1segdelay_g_fq<-aggregate(list(delay = tracedelay_g_fq$delay), list(segundos = cut(tracedelay_g_fq$time, "1 sec")), sum)
xs<- tracecar_g_fq %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_g_fq<-append(list(size = sum1segdelay_g_fq$delay), list(time = as.numeric(sum1segdelay_g_fq$segundos)))
mean1segdelay_g_fq$transmissores <- xs$transmissores
mean1segdelay_g_fq$size <- mean1segdelay_g_fq$size[1:t] / mean1segdelay_g_fq$transmissores[1:t]

#FN
#Compute Delay Server G
tracedelay_g_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_g_fn_tt.txt')
names(tracedelay_g_fn)<-c("time", "delay")
tracecar_g_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fn_5005_tt.txt', sep=' ')
names(tracecar_g_fn)<-c("time", "id", "size", "ori", "dest" )
tracedelay_g_fn$time <- as.POSIXlt(tracedelay_g_fn$time, origin = "1987-10-05 11:00:00")
tracecar_g_fn$time <- as.POSIXlt(tracecar_g_fn$time, origin = "1987-10-05 11:00:00")
tracecar_g_fn$hour <- format(tracecar_g_fn$time, format = "%H")
tracecar_g_fn$minute <- format(tracecar_g_fn$time, format = "%M")
tracecar_g_fn$second <- format(tracecar_g_fn$time, format = "%S")
sum1segdelay_g_fn<-aggregate(list(delay = tracedelay_g_fn$delay), list(segundos = cut(tracedelay_g_fn$time, "1 sec")), sum)
xs<- tracecar_g_fn %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_g_fn<-append(list(size = sum1segdelay_g_fn$delay), list(time = as.numeric(sum1segdelay_g_fn$segundos)))
mean1segdelay_g_fn$transmissores <- xs$transmissores
mean1segdelay_g_fn$size <- mean1segdelay_g_fn$size[1:t] / mean1segdelay_g_fn$transmissores[1:t]

mean1segdelay_g_fs$size <- mean1segdelay_g_fs$size[1:t]
mean1segdelay_g_fs$time <- mean1segdelay_g_fs$time[1:t]
mean1segdelay_g_fs$transmissores <- mean1segdelay_g_fs$transmissores[1:t]
mean1segdelay_g_fs <- data.frame(mean1segdelay_g_fs)

mean1segdelay_g_fq$size <- mean1segdelay_g_fq$size[1:t]
mean1segdelay_g_fq$time <- mean1segdelay_g_fq$time[1:t]
mean1segdelay_g_fq$transmissores <- mean1segdelay_g_fq$transmissores[1:t]
mean1segdelay_g_fq <- data.frame(mean1segdelay_g_fq)

mean1segdelay_g_fn$size <- mean1segdelay_g_fn$size[1:t]
mean1segdelay_g_fn$time <- mean1segdelay_g_fn$time[1:t]
mean1segdelay_g_fn$transmissores <- mean1segdelay_g_fn$transmissores[1:t]
mean1segdelay_g_fn <- data.frame(mean1segdelay_g_fn)

data.frame(approach = c(rep("Framework", nrow(mean1segdelay_g_fs)),
                        rep("QoS only", nrow(mean1segdelay_g_fq)),
                        rep("Best effort", nrow(mean1segdelay_g_fn))),
           value = c(mean1segdelay_g_fs$size,
                     mean1segdelay_g_fq$size,
                     mean1segdelay_g_fn$size)) %>%
  ggplot(aes(value, colour=approach, shape=approach)) +
  scale_colour_grey() +
  stat_ecdf(geo = "point", size = 4) +
  labs(title="",
       y = "PDR", x="RTT (ms)")+
  theme_bw()+
  theme(axis.text.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = .5, face = "plain"),
        axis.text.y = element_text(color = "grey20", size = 20, angle = 0, hjust = 1, vjust = 0, face = "plain"),  
        axis.title.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = 0, face = "plain"),
        axis.title.y = element_text(color = "grey20", size = 20, angle = 90, hjust = .5, vjust = .5, face = "plain"),
        legend.title = element_text(color = "white", size = 20),
        legend.text = element_text(color = "black", size = 20),
        legend.position = c(0.85, 0.2)) +
  guides(shape = guide_legend(override.aes = list(size = 5)))

#plot(ecdf(mean1segdelay_g_fs$size), col.01line = "gray70", pch = 19, col="red", xlim = c(0,2000), ylim = c(0,1), main="CDF Delay Application E", ylab = "CDF", xlab = "delay")
#abline( h= 0.8, lty =3, col = "gray60")
#par(new=T)
#plot(ecdf(mean1segdelay_g_fq$size), col.01line = "gray70", pch = 19, col="blue", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA, main ="")
#par(new=T)
#plot(ecdf(mean1segdelay_g_fn$size), col.01line = "gray70", pch = 19, col="orange", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA,  main ="")
#legend("right", legend=c("Framework", "QoS only", "Best effort"), lty=c(1,1,1), col=c("red", "blue", "orange"))

####################################################App S

#FS
#Compute Delay Server S
tracedelay_s_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_s_fs_tt.txt')
names(tracedelay_s_fs)<-c("time", "delay")
tracecar_s_fs<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5002_tt.txt', sep=' ')
names(tracecar_s_fs)<-c("time", "id", "size", "ori", "dest" )
tracedelay_s_fs$time <- as.POSIXlt(tracedelay_s_fs$time, origin = "1987-10-05 11:00:00")
tracecar_s_fs$time <- as.POSIXlt(tracecar_s_fs$time, origin = "1987-10-05 11:00:00")
tracecar_s_fs$hour <- format(tracecar_s_fs$time, format = "%H")
tracecar_s_fs$minute <- format(tracecar_s_fs$time, format = "%M")
tracecar_s_fs$second <- format(tracecar_s_fs$time, format = "%S")
sum1segdelay_s_fs<-aggregate(list(delay = tracedelay_s_fs$delay), list(segundos = cut(tracedelay_s_fs$time, "1 sec")), sum)
xs<- tracecar_s_fs %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_s_fs<-append(list(size = sum1segdelay_s_fs$delay), list(time = as.numeric(sum1segdelay_s_fs$segundos)))
mean1segdelay_s_fs$transmissores <- xs$transmissores
mean1segdelay_s_fs$size <- mean1segdelay_s_fs$size[1:t] / mean1segdelay_s_fs$transmissores[1:t]

#FQ
#Compute Delay Server S
tracedelay_s_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_s_fq_tt.txt')
names(tracedelay_s_fq)<-c("time", "delay")
tracecar_s_fq<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5002_tt.txt', sep=' ')
names(tracecar_s_fq)<-c("time", "id", "size", "ori", "dest" )
tracedelay_s_fq$time <- as.POSIXlt(tracedelay_s_fq$time, origin = "1987-10-05 11:00:00")
tracecar_s_fq$time <- as.POSIXlt(tracecar_s_fq$time, origin = "1987-10-05 11:00:00")
tracecar_s_fq$hour <- format(tracecar_s_fq$time, format = "%H")
tracecar_s_fq$minute <- format(tracecar_s_fq$time, format = "%M")
tracecar_s_fq$second <- format(tracecar_s_fq$time, format = "%S")
sum1segdelay_s_fq<-aggregate(list(delay = tracedelay_s_fq$delay), list(segundos = cut(tracedelay_s_fq$time, "1 sec")), sum)
xs<- tracecar_s_fq %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_s_fq<-append(list(size = sum1segdelay_s_fq$delay), list(time = as.numeric(sum1segdelay_s_fq$segundos)))
mean1segdelay_s_fq$transmissores <- xs$transmissores
mean1segdelay_s_fq$size <- mean1segdelay_s_fq$size[1:t] / mean1segdelay_s_fq$transmissores[1:t]

#FN
#Compute Delay Server S
tracedelay_s_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/delay_s_fn_tt.txt')
names(tracedelay_s_fn)<-c("time", "delay")
tracecar_s_fn<-read.table(file = 'experimentos/framework_its_sdn-master/results/cartf_fs_5002_tt.txt', sep=' ')
names(tracecar_s_fn)<-c("time", "id", "size", "ori", "dest" )
tracedelay_s_fn$time <- as.POSIXlt(tracedelay_s_fn$time, origin = "1987-10-05 11:00:00")
tracecar_s_fn$time <- as.POSIXlt(tracecar_s_fn$time, origin = "1987-10-05 11:00:00")
tracecar_s_fn$hour <- format(tracecar_s_fn$time, format = "%H")
tracecar_s_fn$minute <- format(tracecar_s_fn$time, format = "%M")
tracecar_s_fn$second <- format(tracecar_s_fn$time, format = "%S")
sum1segdelay_s_fn<-aggregate(list(delay = tracedelay_s_fn$delay), list(segundos = cut(tracedelay_s_fn$time, "1 sec")), sum)
xs<- tracecar_s_fn %>% 
  group_by(hour, minute, second) %>% 
  summarise(transmissores = n_distinct(ori))
mean1segdelay_s_fn<-append(list(size = sum1segdelay_s_fn$delay), list(time = as.numeric(sum1segdelay_s_fn$segundos)))
mean1segdelay_s_fn$transmissores <- xs$transmissores
mean1segdelay_s_fn$size <- mean1segdelay_s_fn$size[1:t] / mean1segdelay_s_fn$transmissores[1:t]


mean1segdelay_s_fs$size <- mean1segdelay_s_fs$size[1:t]
mean1segdelay_s_fs$time <- mean1segdelay_s_fs$time[1:t]
mean1segdelay_s_fs$transmissores <- mean1segdelay_s_fs$transmissores[1:t]
mean1segdelay_s_fs <- data.frame(mean1segdelay_s_fs)

mean1segdelay_s_fq$size <- mean1segdelay_s_fq$size[1:t]
mean1segdelay_s_fq$time <- mean1segdelay_s_fq$time[1:t]
mean1segdelay_s_fq$transmissores <- mean1segdelay_s_fq$transmissores[1:t]
mean1segdelay_s_fq <- data.frame(mean1segdelay_s_fq)

mean1segdelay_s_fn$size <- mean1segdelay_s_fn$size[1:t]
mean1segdelay_s_fn$time <- mean1segdelay_s_fn$time[1:t]
mean1segdelay_s_fn$transmissores <- mean1segdelay_s_fn$transmissores[1:t]
mean1segdelay_s_fn <- data.frame(mean1segdelay_s_fn)

library(ggplot2)
library(tidyverse)
data.frame(approach = c(rep("Framework", nrow(mean1segdelay_s_fs)),
                        rep("QoS only", nrow(mean1segdelay_s_fq)),
                        rep("Best effort", nrow(mean1segdelay_s_fn))),
           value = c(mean1segdelay_s_fs$size,
                     mean1segdelay_s_fq$size,
                     mean1segdelay_s_fn$size)) %>%
  ggplot(aes(value, colour=approach, shape=approach)) +
  scale_colour_grey() +
  stat_ecdf(geo = "point", size = 4) +
  labs(title="",
       y = "PDR", x="RTT (ms)")+
  theme_bw()+
  theme(axis.text.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = .5, face = "plain"),
        axis.text.y = element_text(color = "grey20", size = 20, angle = 0, hjust = 1, vjust = 0, face = "plain"),  
        axis.title.x = element_text(color = "grey20", size = 20, angle = 0, hjust = .5, vjust = 0, face = "plain"),
        axis.title.y = element_text(color = "grey20", size = 20, angle = 90, hjust = .5, vjust = .5, face = "plain"),
        legend.title = element_text(color = "white", size = 20),
        legend.text = element_text(color = "black", size = 20),
        legend.position = c(0.85, 0.2)) +
  guides(shape = guide_legend(override.aes = list(size = 5)))

#plot(ecdf(mean1segdelay_s_fs$size), col.01line = "gray70", pch = 19, col="red", xlim = c(0,2000), ylim = c(0,1), main="CDF Delay Application E", ylab = "CDF", xlab = "delay")
#abline( h= 0.8, lty =3, col = "gray60")
#par(new=T)
#plot(ecdf(mean1segdelay_s_fq$size), col.01line = "gray70", pch = 19, col="blue", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA, main ="")
#par(new=T)
#plot(ecdf(mean1segdelay_s_fn$size), col.01line = "gray70", pch = 19, col="orange", xlim = c(0,2000), ylim = c(0,1), axes=F, xlab=NA, ylab=NA,  main ="")
#legend("right", legend=c("Framework", "QoS only", "Best effort"), lty=c(1,1,1), col=c("red", "blue", "orange"))
