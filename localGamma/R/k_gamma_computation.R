  k.gamma.partition <- function(filename,class="-1"){
    library(data.table)
    library(chunkR)
    library(e1071)
    k_gamma_cpp <- function(X, k, class_col) {
      .Call(`_gammaPartition_k_gamma_cpp`, X, k, class_col)
    }
    
    k_gamma_diagonal <- function(X, k, class_col) {
      .Call(`_gammaPartition_k_gamma_diagonal`, X, k, class_col)
    }
    
        
    print("**k_gamma started**")
    ChunkSize = 2000
    #ChunkSize = as.integer(sqrt(nrow(X_Matrix)))
  
    
    k=2
    
    #declare the gammas
    partial_gamma <- matrix()
  
    t0= proc.time() #starting time
    t_Start = Sys.time()
    time_list = list()
    
    #read the dataset by chunk
    tmp_path <- file.path(getwd(),filename)
    chunker_object <- chunker(tmp_path,chunksize = ChunkSize, sep=",", has_colnames = T, has_rownames = F) #create chunk object
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
      #k_list_gamma[[iter]] = k_gamma_diagonal(t(as.matrix(chunk_table)),as.integer(k), as.integer(class_col)) #pass the chunk to rcpp
      partial_gamma = k_gamma_diagonal(t(as.matrix(chunk_table)),as.integer(k), as.integer(class_col)) #pass the chunk to rcpp
      full_gamma = full_gamma + partial_gamma
      Nglobal = get_completed(chunker_object)
  
      iter = iter + 1
      #get_completed(chunker_object)
    }
    
    t1=proc.time()
    elapsed=t1-t0
    print(elapsed)

    write.table(full_gamma,"partition_gamma_1.txt",append=FALSE, sep=" ",row.names=FALSE, col.names=FALSE)

    print(paste0("total blocks = ",iter))
  
    
  }
