# KPN1053 alignments

In this part the following steps were executed:
  - Choosing appropriate reference sequence from 4 possible variants
  - Alignment of KPN1053 to best reference using two different tools
  - Simple common variants calling

## Installation requirements
We need the following software installed:
  - python3 (https://www.python.org/downloads/)
  - java8 or higher (https://www.oracle.com/technetwork/java/javase/overview/java8-2100321.html)
  - pip3 (https://pip.pypa.io/en/stable/)
  - samtools (http://samtools.sourceforge.net/)
  - bwa (http://bio-bwa.sourceforge.net/)
  - bowtie2 (http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
  - refRank (https://gitlab.com/s.fuchs/refRank/)
  - varscan (http://varscan.sourceforge.net/)
  - faidx (https://pypi.org/project/pyfaidx/)

## 1. Data preperation

### 1.1 Download data

Download the following references:
* GCF_001902195.1 (https://www.ncbi.nlm.nih.gov/assembly/GCF_001902195.1#/st)
* GCF_001887995.2 (https://www.ncbi.nlm.nih.gov/assembly/GCF_001887995.2#/st)
* GCF_003432165.1 (https://www.ncbi.nlm.nih.gov/assembly/GCF_003432165.1#/def)
* GCF_003571705.1 (https://www.ncbi.nlm.nih.gov/assembly/GCF_003571705.1)

Download the following sequencing data:
* SRR6480154 (https://www.ncbi.nlm.nih.gov/Traces/study/?uids=4955501)

### 1.2 Split references over chromosomes

```sh
$ faidx -x GCF_001887995.2_ASM188799v2_genomic.fna
$ faidx -x GCF_001902195.1_ASM190219v1_genomic.fna
$ faidx -x GCF_003432165.1_ASM343216v1_genomic.fna
$ faidx -x GCF_003571705.1_ASM357170v1_genomic.fna
```

Results: http://195.208.116.225/bioinf/data/reference/ 

### 1.3 Calculate average read length to choose appropriate aligner

```sh
$ grep -A1 --no-group-separator "@SRR" SRR6480154_1_P.fastq | grep -v "@SRR" | awk '{sum += length($0) } END { print "The average read length is:" sum/NR}'

The average read length is:189.374

$ grep -A1 --no-group-separator "@SRR" SRR6480154_2_P.fastq | grep -v "@SRR" | awk '{sum += length($0) } END { print "The average read length is:" sum/NR}'

The average read length is:165.212
```

Average read length is usually >= 100 b.p., therefore it seems that we can choose any aligner
(see: https://www.researchgate.net/publication/314489561_Evaluation_and_assessment_of_read-mapping_by_multiple_next-generation_sequencing_aligners_based_on_genome-wide_characteristics)

## 2. Reference selection

### 2.1 Run RefRank on splitted references

```sh
$ time refrank.py --fastq SRR6480136_1_P.fastq SRR6480136_2_P.fastq --ref NZ*.fna
```
Timing:
```sh
real 1m16.252s
user 4m55.221s
sys 0m15.682s
```

Results: http://195.208.116.225/bioinf/Klebsiella/6_reference_selection/REFRANK_2018-10-18_11-08-09/

## 3. BWA Alignment

Results: http://195.208.116.225/bioinf/Klebsiella/7_kpn1053_alignment/bwa/

### 3.1 Index reference

```sh
$ bwa index NZ_CP031882.1.fna
[bwa_index] Pack FASTA... 0.00 sec
[bwa_index] Construct BWT for the packed sequence...
[bwa_index] 0.00 seconds elapse.
[bwa_index] Update BWT... 0.00 sec
[bwa_index] Pack forward-only FASTA... 0.00 sec
[bwa_index] Construct SA from BWT and Occ... 0.00 sec
[main] Version: 0.7.17-r1188
[main] CMD: bwa index ../../data/reference/NZ_CP031882.1.fna
[main] Real time: 0.016 sec; CPU: 0.007 sec
```

### 3.2 Align

```sh
$ time bwa mem NZ_CP031882.1.fna SRR6480154_1_P.fastq SRR6480154_2_P.fastq > alignment_NZ_CP031882_1.sam
real 1m41.429s
user 1m44.360s
sys	0m2.359s
```

### 3.3 Index and sort resulting SAM file

```sh
$ time samtools view -S -b alignment_NZ_CP031882_1.sam | samtools sort - -o alignment_NZ_CP031882_1.bam
real 1m7.166s
user 1m6.219s
sys	0m2.340s
```

### 3.4 Index BAM file

```sh
$ samtools index alignment_NZ_CP031882_1.bam
```

### 3.4 Alignment statistics

```sh
$ samtools flagstat alignment_NZ_CP031882_1.sam
1554251 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 secondary
35 + 0 supplementary
0 + 0 duplicates
1165 + 0 mapped (0.07% : N/A)
1554216 + 0 paired in sequencing
777108 + 0 read1
777108 + 0 read2
1118 + 0 properly paired (0.07% : N/A)
1122 + 0 with itself and mate mapped
8 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

## 4. BWA Variants calling

Results: http://195.208.116.225/bioinf/Klebsiella/7_kpn1053_alignment/bwa/

### 4.1 Create mpileup

```sh
$ samtools mpileup -f NZ_CP031882.1.fna -d 100000 alignment_NZ_CP031882_1.bam > NZ_CP031882_1_bwa.mpileup
```

### 4.2 Find SNPs with VarScan

```sh
$ varscan mpileup2snp NZ_CP031882_1_bwa.mpileup --min-var-freq 0.95 --variants --output-vcf 1 > NZ_CP031882_1_095.vcf
Only SNPs will be reported
Warning: No p-value threshold provided, so p-values will not be calculated
Min coverage:	8
Min reads2:	2
Min var freq:	0.95
Min avg qual:	15
P-value thresh:	0.01
Reading input from NZ_CP031882_1_bwa.mpileup
1253 bases in pileup file
51 variant positions (46 SNP, 5 indel)
31 were failed by the strand-filter
16 variant positions reported (16 SNP, 0 indel)
Markdown
Toggle Zen Mode
Preview
Toggle Mode

```

## 5. Bowtie2 Alignment

Results: http://195.208.116.225/bioinf/Klebsiella/7_kpn1053_alignment/bowtie2/

### 5.1 Index reference

```sh
$ time bowtie2-build NZ_CP031882.1.fna NZ_CP031882_1
real	0m0.371s
user	0m0.137s
sys	0m0.235s
```

### 5.2 Align

```sh
$ time bowtie2 -x NZ_CP031882_1 -q -1 SRR6480154_1_P.fastq -2 SRR6480154_2_P.fastq -S alignment_NZ_CP031882_1_bowtie2.sam
777108 reads; of these:
  777108 (100.00%) were paired; of these:
    776866 (99.97%) aligned concordantly 0 times
    242 (0.03%) aligned concordantly exactly 1 time
    0 (0.00%) aligned concordantly >1 times
    ----
    776866 pairs aligned concordantly 0 times; of these:
      1 (0.00%) aligned discordantly 1 time
    ----
    776865 pairs aligned 0 times concordantly or discordantly; of these:
      1553730 mates make up the pairs; of these:
        1553683 (100.00%) aligned 0 times
        47 (0.00%) aligned exactly 1 time
        0 (0.00%) aligned >1 times
0.03% overall alignment rate

real	0m23.294s
user	0m19.396s
sys	0m2.670s
```

### 5.2 Alignment statistics

```sh
$ samtools flagstat alignment_NZ_CP031882_1_bowtie2.sam
1554216 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
533 + 0 mapped (0.03% : N/A)
1554216 + 0 paired in sequencing
777108 + 0 read1
777108 + 0 read2
484 + 0 properly paired (0.03% : N/A)
486 + 0 with itself and mate mapped
47 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

### 5.3 Index and sort resulting SAM file

```sh
$ time samtools view -S -b alignment_NZ_CP031882_1_bowtie2.sam | samtools sort - -o alignment_NZ_CP031882_1_bowtie2.bam
real	1m7.831s
user	1m5.181s
sys	0m3.372s
```

## 6. Bowtie2 Variants calling

Results: http://195.208.116.225/bioinf/Klebsiella/7_kpn1053_alignment/bowtie2/

### 6.1 Create mpileup

```sh
$ time samtools mpileup -f NZ_CP031882.1.fna -d 100000 alignment_NZ_CP031882_1_bowtie2.bam > alignment_NZ_CP031882_1_bowtie2.mpileup
[mpileup] 1 samples in 1 input files

real	0m3.420s
user	0m3.358s
sys	0m0.062s
```

### 6.2 Find SNPs with VarScan

```sh
$ time varscan mpileup2snp alignment_NZ_CP031882_1_bowtie2.mpileup --min-var-freq 0.95 --variants --output-vcf 1 > NZ_CP031882_1_095_bowtie2.vcf
Only SNPs will be reported
Warning: No p-value threshold provided, so p-values will not be calculated
Min coverage:	8
Min reads2:	2
Min var freq:	0.95
Min avg qual:	15
P-value thresh:	0.01
Reading input from alignment_NZ_CP031882_1_bowtie2.mpileup
1358 bases in pileup file
56 variant positions (54 SNP, 2 indel)
39 were failed by the strand-filter
16 variant positions reported (16 SNP, 0 indel)
real	0m0.370s
user	0m1.120s
sys	0m0.121s
```

