# Check reference for all samples

## Overview
In this part the following steps were executed:
  - 

See all results here: http://195.208.116.225/bioinf/Klebsiella/9_alignment/

## Installation requirements
See https://github.com/dariader/Klebsiella/blob/alignments/README.md

## 1. Preperation

### 1. Run Trimmomatic

```
$ python3 ~/bioinf/software/my_scripts/run_trimmomatic.py -file ~/bioinf/data/PRJNA429779/ -params "-phred33 ILLUMINACLIP:/home/ubuntu/bioinf/software/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:36"
...
```

### 1.2 Run FastqC to check results

```
$ time fastqc -o ./fastqc2 -f fastq ./trimmomatic/*_p.fastq
...
real	20m42.735s
user	21m0.000s
sys	0m32.840s
```

## 2. Run Refrank

### 2.1

``
$ python3 ~/bioinf/software/my_scripts/run_refrank.py -dir ~/bioinf/Klebsiella/10_other_samples/trimmomatic
``
