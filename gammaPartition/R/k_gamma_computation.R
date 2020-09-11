## Author: Sikder Tahsin Al Amin
## Project: gammarpartition (2020)
## Description: k-Gamma matrix computation in blocks for input data set 
## Output: k-gamma matrix in "partition_gamma_1.txt" file

gamma.partition <- function(filename, sparse="Y") {
  library(data.table)
  library(chunkR)
  gamma_cpp <- function(X, Flag1) {
    .Call(`_gammaPartition_gamma_cpp`, X, Flag1)
  }

  print("**k-gamma computation started**")

  #read the dataset
  partial_gamma <- matrix() #gamma for each chunk
  ChunkSize = 40 ##select the chunksize
  #ChunkSize = as.integer(sqrt(nrow(X_Matrix)))
  
  k=2

  #declare the gammas
  partial_gamma <- matrix()

  t0= proc.time() #starting time
  t_Start = Sys.time()
  time_list = list()

  #read the dataset by chunk
  tmp_path <- file.path(filename)
  chunker_object <- chunker(tmp_path,chunksize = ChunkSize, sep=",", has_colnames = F, has_rownames = F) #create chunk object
  #get_completed(chunker_object) #get the number of lines already read
  iter = 1

  #print("loop starts")
  while(next_chunk(chunker_object)){ #reading the chunk
    chunk_table = get_table(chunker_object) #get the chunk
    if(iter==1){
      NumDim = ncol(chunk_table)
      full_gamma <- matrix(0,NumDim+1,k*2) ##full gamma matrix initialized as zero
      class_col = NumDim
    }
    partial_gamma = k_gamma_diagonal(t(as.matrix(chunk_table)),as.integer(k), as.integer(class_col)) #pass the chunk to rcpp
    full_gamma = full_gamma + partial_gamma
    #Nglobal = get_completed(chunker_object)

    iter = iter + 1
    #get_completed(chunker_object)
  }

  t1=proc.time()
  elapsed=t1-t0
  print(elapsed)

  write.table(full_gamma,"partition_gamma_1.txt",append=FALSE, sep=" ",row.names=FALSE, col.names=FALSE)
  #print(paste0("total blocks = ",iter))

}
