#Project: gammarparallel
#Description: Compute gamma/models on the master node (Phase 2) 

#files: get_gamma.R = compute gamma from 8 nodes
#get_LR.R= compute LR from 2 nodes
#get_NB.R=compute NB from 2 ndoes


file=get_gamma
Rscript $file.R
