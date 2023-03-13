#Change the directory path in below statement to dataset path
setwd("~/Project/Final_Dimen_ana/HMP_Dataset")
# dirlist <- list.dirs(recursive = F)[c(1,2,3,4,5,6,7,8,9,10,11,12,13,14)]
dirlist <- list.dirs(recursive = F)[c(1)]
filelist <- sapply(dirlist,function(x) list.files(x))
resdf <- data.frame()
for (i in 1:length(dirlist))
{
  # for (j in 1:length(filelist[[i]]))
  for (j in 1:1)  
  {
    file <- paste0(paste0(dirlist[i],"/",filelist[[i]][j]))
    dat <- read.table(file)
    names(dat) <- c("x_acc","y_acc","z_acc")
    cors <- cor(dat)
    variances <- var(dat)
    fftx <- fft(dat$x_acc)
    ffty <- fft(dat$y_acc)
    fftz <- fft(dat$z_acc)
    resdf <- rbind(resdf,data.frame(vol=gsub(".txt","",strsplit(filelist[[i]][j],"-")[[1]][9]),
                                    meanx = mean(dat$x_acc),
                                    meany = mean(dat$y_acc),
                                    meanz = mean(dat$z_acc),
                                    medianx = median(dat$x_acc),
                                    mediany = median(dat$y_acc),
                                    medianz = median(dat$z_acc),
                                    corxy=cors[1,2],
                                    coryz=cors[2,3],
                                    corxz=cors[1,3],
                                    varx=variances[1,1],
                                    vary=variances[2,2],
                                    varz=variances[3,3],
                                    varxy=variances[1,2],
                                    varyz=variances[2,3],
                                    varxz=variances[1,3],
                                    fftxmax=max(abs(Mod(fftx))), #Peak Amplitude of the Fourier Transform
                                    fftymax=max(abs(Mod(ffty))),
                                    fftzmax=max(abs(Mod(fftz))),
                                    specenergy=(sum(Mod(fftx))/length(fftx))+(sum(Mod(ffty))/length(ffty))+(sum(Mod(fftz))/length
                                                                                                            (fftz)), #Spectral Energy
                                    xbtwnzandy=mean((dat$z_acc > dat$x_acc & dat$y_acc < dat$x_acc)),
                                    #drinkglasscharacteristic
                                    xless10=sum(dat$x_acc<10)/nrow(dat),
                                    HMPactivity=gsub("./","",dirlist[i])
    ))
  }
}

# write.csv(resdf,file="Featured_Data.csv")

file <- paste0(paste0("Brush_teeth","/","Accelerometer-2011-04-11-13-28-18-brush_teeth-f1.txt"))
dat <- read.table(file)
names(dat) <- c("x_acc","y_acc","z_acc")
xbtwnzandy=mean((dat$z_acc > dat$x_acc & dat$y_acc < dat$x_acc))
xbtwnzandy
