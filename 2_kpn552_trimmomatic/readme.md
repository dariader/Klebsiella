# Run Trimmomatic on raw readd

Raw reads from KPN552 strain were filtered with Trimmomatic tool.

## Command

Trimmomatic command:

    time java -jar ../../software/Trimmomatic-0.38/trimmomatic-0.38.jar PE -phred33 ../../data/kpn552/SRR6480136_1.fastq ../../data/kpn552/SRR6480136_2.fastq SRR6480136_1_P.fastq SRR6480136_1_U.fastq SRR6480136_2_P.fastq  SRR6480136_2_U.fastq  ILLUMINACLIP:../../software/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:2:20 MINLEN:36

## Results

See results here: https://yadi.sk/d/Q0Oku8sXpvnHsA
