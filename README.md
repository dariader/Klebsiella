## Klebsiella

В этой части репозитория лежат файлы, которые относятся к части проекта по анализу генома разных штаммов Клебсиеллы - анализ SNP при помощи PCA. 

1. #Klebs_rep.html - интерактивный лабжурнал, в котором прописаны все команды необходимые для РСА, а также приведен результат их исполнения (исключение - команды на bash и загрузка пакетов). На 14.11.2018 - он содержит технический отчет с построением РСА по всем генам, а не по коровому геному.
2. #Klebs_rep.Rmd -  R markdown лабжурнал, в котором прописаны все команды, можно скачать репозиторий и запустить этот rmd в Rstudio. Имеет некоторые отличия от #Klebs_rep.html: последний чанк строит график частот SNP на каждой позиции на хромосоме, в html отчет это не вошло.  
3. #CCOMBO.gds - файл внутреннего формата SNPrelate для построения PCA
4. #indexator.sh и #bgzipper.sh - скрипты на bash для создания vcf.gz их последующего индексирования
5. файл COMBINED.vcf - объединенный vcf файл. Образцы названы в соответсвии с их SRR-id. Файл доступен по ссылке 
https://drive.google.com/open?id=15CkSm6dYq4XDlb-nh8lvOGkUvM0_YmGC


-------- Текущие вопросы
0. Выбор Ейгенвекторов для кластеризациии
1. Нормализация данных
2. Центрирование данных
3. Определение корового генома
