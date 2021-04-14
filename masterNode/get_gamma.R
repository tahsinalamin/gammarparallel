#Author: Sikder Tahsin Al Amin
#project: gammacloud
#Description: Get partial gammas from all the nodes and add them to get final gamma

t0= proc.time() #time starts

library(RCurl)

x= scp(host="192.168.1.11",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma1=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))


x= scp(host="192.168.1.12",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma2=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))


x= scp(host="192.168.1.13",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma3=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))


x= scp(host="192.168.1.14",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma4=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))


x= scp(host="192.168.1.15",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma5=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))


x= scp(host="192.168.1.16",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma6=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))



x= scp(host="192.168.1.17",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma7=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))


x= scp(host="192.168.1.18",path="/home/vertica/tahsin/r-partition/partition_gamma_1.txt",user="vertica",pass="12512Marlive")
par1=memDecompress(x,asChar=TRUE)
gl=as.list(strsplit(par1,"\n"))
gamma8=do.call(rbind, lapply(strsplit(gl[[1]]," "), as.numeric))

#print(dim(gamma1),dim(gamma2),dim(gamma3),dim(gamma4),dim(gamma5),dim(gamma6),dim(gamma7),dim(gamma8))

final_gamma= gamma1+gamma2+gamma3+gamma4+gamma5+gamma6+gamma7+gamma8


t1=proc.time()
elapsed=t1-t0
print(elapsed)

