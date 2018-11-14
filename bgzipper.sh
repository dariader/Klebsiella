 #!/bin/Bash

for F in *.vcf;
 do bcftools view "$F" -Oz -o "$F.gz";
 done
