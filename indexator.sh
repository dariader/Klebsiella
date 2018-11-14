#!/bin/Bash

for F in *.gz;
   do bcftools index $F;
   done
