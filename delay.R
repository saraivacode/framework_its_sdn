tracedelay<-read.table(file = 'mininet-wifi/delay.txt')
delay<-append(list(delay = tracedelay$V1), list(time = c(1:length(tracedelay$V1))))
plot(delay$time, delay$delay, type = "l", main="Delay per second", ylab='ms', xlab='time(s)', col="blue")
#lines(delay$time[1:100], delay$delay[1:100], type = "l", main="Delay per second", ylab='ms', xlab='time(s)', col="red")
