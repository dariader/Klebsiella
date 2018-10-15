# Trimmomatic filtering

Raw reads from KPN552 strain were filtered with Trimmomatic tool.

## Command

1. Filtering with sliding window 2:20 and min len 36
Simplified command (paths were shortened):

        time java -jar trimmomatic-0.38.jar PE -phred33 SRR6480136_1.fastq SRR6480136_2.fastq SRR6480136_1_P.fastq SRR6480136_1_U.fastq SRR6480136_2_P.fastq  SRR6480136_2_U.fastq  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:2:20 MINLEN:36

2. Filtering with sliding window 4:20 and min len 36

        time java -jar trimmomatic-0.38.jar PE -phred33 SRR6480136_1.fastq SRR6480136_2.fastq SRR6480136_1_P.fastq SRR6480136_1_U.fastq SRR6480136_2_P.fastq  SRR6480136_2_U.fastq  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:36

    Output:
    
        Input Read Pairs: 457301 Both Surviving: 410096 (89.68%) Forward Only Surviving: 44635 (9.76%) Reverse Only Surviving: 734 (0.16%) Dropped: 1836 (0.40%)
        TrimmomaticPE: Completed successfully

        real	0m7.954s
        user	0m8.059s
        sys	0m1.052s
        
3. Filtering with sliding window 4:15, min len 36 and leading and traing 3

    time java -jar trimmomatic-0.38.jar PE -phred33 SRR6480136_1.fastq SRR6480136_2.fastq ./3/SRR6480136_1_P.fastq SRR6480136_1_U.fastq SRR6480136_2_P.fastq  SRR6480136_2_U.fastq  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:15 MINLEN:36 LEADING:3 TRAILING:3
    
    Output:
    
        Input Read Pairs: 457301 Both Surviving: 416347 (91.04%) Forward Only Surviving: 39520 (8.64%) Reverse Only Surviving: 261 (0.06%) Dropped: 1173 (0.26%)
        TrimmomaticPE: Completed successfully
        
        real	0m9.605s
        user	0m10.113s
        sys	0m0.747s
    
4. Filtering with sliding window 4:15 and min len 36

    time java -jar trimmomatic-0.38.jar PE -phred33 SRR6480136_1.fastq SRR6480136_2.fastq SRR6480136_1_P.fastq SRR6480136_1_U.fastq SRR6480136_2_P.fastq  SRR6480136_2_U.fastq  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:15 MINLEN:36
    
    Output:
    
        Input Read Pairs: 457301 Both Surviving: 416347 (91.04%) Forward Only Surviving: 39520 (8.64%) Reverse Only Surviving: 261 (0.06%) Dropped: 1173 (0.26%)
        TrimmomaticPE: Completed successfully
        
        real	0m8.730s
        user	0m8.946s
        sys	0m0.987s

## Results

Filtering #2 (sliding window 4:20 and min len 36) is ok.

See results here: https://yadi.sk/d/Q0Oku8sXpvnHsA (will be updated)
