#================================= A test case =================================
library(pcalg)
library(graph)
library(MASS)
library(tictoc)
library(igraph)

source("cuPC.R")

# read data
dataset_path <- file.path("data/dataset-6000-1000.csv", fsep=.Platform$file.sep)
dataset <- read.table(dataset_path, sep=",")

# Prepare data
corrolationMatrix <- cor(dataset)
p <- ncol(dataset)
# P大于3000时，corrolationMatrix计算出来会有NAN值，所以在这里加上缺失值补充，将NAN改为0
# 这样改可以消除这个bug，但是由于内存的限制，我这里16G的内存，参数上限大概是4500-2500，再大系统会强制结束进程，如果你有更大内存的机器，可以再试试更大的
corrolationMatrix[is.na(corrolationMatrix)] = 0
suffStat <- list(C = corrolationMatrix, n = nrow(dataset))
# write.table(suffStat,file="data/cor-4000-1000.csv", row.names=FALSE, na= "xxx",col.names= FALSE, sep=",")

tic()
# stable_fast_fit <- pc(suffStat, indepTest=gaussCItest, p=p, skel.method="stable.fast", alpha=0.05, NAdelete=TRUE)
print("the total time consumed by stable.fast is:")
toc()
# print(stable_fast_fit)


tic()
cuPC_fit <- cu_pc(suffStat, p=p, alpha=0.05)                                                              
print("The total time consumed by cuPC is:")
toc()


if (require(Rgraphviz)) {
  ## show estimated CPDAG
  par(mfrow=c(1,2))
  # plot(stable_fast_fit, main = "Estimated CPDAG (stable.fast)")
  plot(cuPC_fit, main = "Estimated CPDAG (cuPC)")
}