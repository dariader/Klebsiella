# Klebsiella

Trimmomatic options:
TrimmomaticPE -phred33 SRR6480152_1.fastq SRR6480152_2.fastq SRR6480152_1_Paired.fastq SRR6480152_1_Unpaired.fastq SRR6480152_2_Paired.fastq  SRR6480152_2_Unpaired.fastq  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:36

SPAdes options:
~/bioinf/SPAdes-3.13.0-Linux/bin/spades.py --careful -1 SRR6480154_1_Paired.fastq -2 SRR6480154_2_Paired.fastq -o spades_output

QUAST options:
python ~/bioinf/quast-5.0.0/quast.py -r ~/bioinf/Klebsiella/reference/GCF_000240185.1_ASM24018v2_genomic.fna ~/bioinf/Klebsiella/kpn1053/spades_output/contigs.fasta
