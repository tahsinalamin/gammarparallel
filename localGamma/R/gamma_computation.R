gamma.partition <- function(filename, sparse="Y") {
  library(data.table)
  library(chunkR)
  gamma_cpp <- function(X, Flag1) {
    .Call(`_gammaPartition_gamma_cpp`, X, Flag1)
  }
  
  
  print("**gamma started**")
  print(sparse)
  
  #read the dataset
  #X_Matrix = read.csv(filename, header =TRUE)
  #X_Matrix = fread(filename, header =TRUE) #need library(data.table)
  # NumDim = ncol(X_Matrix)
  partial_gamma <- matrix() #gamma for each chunk
  #full_gamma <- matrix(0,NumDim+1, NumDim+1) ##full gamma matrix initialized as zero
  #full_gamma<-matrix()
  ChunkSize = 2000
  #ChunkSize = as.integer(sqrt(nrow(X_Matri"scp" %in% curlVersion()$protocolsx)))
  
  
  
  
  t0= proc.time() #time starts  
  t_Start = Sys.time()
  time_list = list()
  
  tmp_path <- file.path(filename) #construct the path to a file
  chunker_object <- chunker(tmp_path,chunksize = ChunkSize, sep=",", has_colnames = F, has_rownames = F) #create chunk object
  iter = 1
  
  while(next_chunk(chunker_object)){ #reading the chunk
    chunk_table = get_table(chunker_object) #get the chunk
    partial_gamma = gamma_cpp(t(as.matrix(chunk_table)), sparse) #pass the chunk to rcpp
    if(iter==1){
      NumDim = ncol(chunk_table)
      full_gamma <- matrix(0,NumDim+1, NumDim+1) ##full gamma matrix initialized as zero
    }
    full_gamma = full_gamma + partial_gamma  #add partial gamma with the previous gamma
    
    iter = iter + 1
  }
  
  #print(full_gamma)
  
  
  t1=proc.time()
  elapsed=t1-t0
  print(elapsed)
  
  write.table(full_gamma,"partition_gamma_1.txt",append=FALSE, sep=" ",row.names=FALSE, col.names=FALSE)
  
  print(paste0("Total blocks: ",iter))
  
}
