#Author: Sikder Tahsin Al Amin
#Project: gammacloud
#Description: login to each node (2 nodes) and compute gamma on partitioned dataset

start=`date +%s`

Rscript /run_gamma.R #1st node

ssh username@ip-address "Rscript /path-to-folder/run_gamma.R" #2nd node

end=`date +%s`
runtime=$((end-start))
echo "##############################"
echo "Runtime for computing partial gammas: $runtime"
