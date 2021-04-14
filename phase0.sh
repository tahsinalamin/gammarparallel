#Author: Sikder Tahsin Al Amin
#project: gammarparallel
#Description: Split a data set and send it to 2 machines.
#Usage: input=input data set; partition_size=row size in each partition
#Change the username, ipaddress and path in line 31.

echo "Enter csv file name (ex: test1): "
read input
echo "Enter partition size (ex: 40): "
read partition_size
## varying d for data sets
#cut -d, -f6-91 --complement $input.csv > YearPrediction1m4d.csv
#cut -d, -f6-30 --complement creditcard_1m_randomized.csv > CC1m5d.csv ##upto d-1 column as d-th column is the class column

#### spliting the dataset #######
start=`date +%s`
split -l $partition_size $input.csv $input"_"
end=`date +%s`
runtime=$((end-start))
echo "Runtime for split: $runtime"


### renaming the partitioned dataset to .csv ####
mv $input"_aa" $input"_aa".csv
mv $input"_ab" $input"_ab".csv


####transfer the partitioned dataset to nodes ####                                                     
start=`date +%s`                                                                                       
  
scp -r /home/vertica/tahsin/r-partition/$input"_ab".csv username@ip-address:/path-to-folder                           
                                                                                                                                                                                                                                                                                                           
end=`date +%s`                                                                                         
                                                                                                       
runtime=$((end-start))                                                                                 
echo "Runtime for file transfer: $runtime"                                                             
