## Klebsiella

В этой части репозитория лежат файлы, которые относятся к части проекта по анализу генома разных штаммов Клебсиеллы - анализ SNP при помощи PCA. 

1. #Klebs_rep.html - интерактивный лабжурнал, в котором прописаны все команды необходимые для РСА, а также приведен результат их исполнения (исключение - команды на bash и загрузка пакетов). На 14.11.2018 - он содержит технический отчет с построением РСА по всем генам, а не по коровому геному (см. ниже).
2. #Klebs_rep.Rmd -  R markdown лабжурнал, в котором прописаны все команды, можно скачать репозиторий и запустить этот rmd в Rstudio. Имеет некоторые отличия от #Klebs_rep.html: последний чанк строит график частот SNP на каждой позиции на хромосоме, в html отчет это не вошло.  
3. #CCOMBO.gds - файл внутреннего формата SNPrelate для построения PCA
4. #indexator.sh и #bgzipper.sh - скрипты на bash для создания vcf.gz их последующего индексирования
5. файл COMBINED.vcf - объединенный vcf файл. Образцы названы в соответсвии с их SRR-id. Файл доступен по ссылке 
https://drive.google.com/open?id=15CkSm6dYq4XDlb-nh8lvOGkUvM0_YmGC


-------- Текущие вопросы

Этот метод был применен в статье 2015 года для анлиза корового генома. Определение корового генома -  следующий этап нашего проекта: 

The ORFs were translated into protein using #EMBOSS and clustered at the ≤30% amino acid	homology level using #CD-­‐HIT (24), resulting in 29,886 protein/gene clusters. (Alternative	clustering at ≤10%, ≤20% or ≤40% homology resulted in 46718, 37609 or 29779 clusters,	respectively; hence 30% was taken as the point of inflection.) 

These data were then processed	to generate a binary gene content matrix in which the presence of a gene is defined as >90%	coverage of at least one ORF belonging to the corresponding protein cluster. Hence genomes	that encode alleles with ≥30% amino acid homology across the length of the sequence are	considered to encode the same functional gene in our analysis.	
Pangenome accumulation curves were generated for  K. pneumoniae and separately for each	phylogroup using the  vegan package in R ( Fig. 1b) 

Common accessory genes were defined as those found in 5-­‐95% of  K. pneumoniae genomes.	Principal components analysis (PCA) of the binary gene content matrix for these genes was	performed using the  prcomp function in R ( Fig. 1c):	
