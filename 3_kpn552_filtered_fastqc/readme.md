# Running FastQC tool on raw reads

Command:

    time fastqc -o . /2_kpn552_trimmomatic/<number of experiment>/SRR6480136_1_P.fastq /2_kpn552_trimmomatic/<number of experiment>/SRR6480136_2_P.fastq

1 - Filtered with sliding window 2:20 and min len 36
2 - Filtered with sliding window 4:20 and min len 36
3 - Filtered with sliding window 4:15 and min len 36 and leading and traing 3
4 - Filtered with sliding window 4:15 and min len 36
