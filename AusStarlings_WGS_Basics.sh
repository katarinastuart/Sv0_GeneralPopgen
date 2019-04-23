CONTINENTAL AUSTRALIA POPULATIONS - S VULGARIS

2018-09-19--------------------------------------------------------------[Getting data from Deakin servers] DONE

https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html#SetupanSSHkey-ssh2

Passphrase: unsw231

eval `ssh-agent` 
ssh-add ~/.ssh/<private_key_file>

# Didn't work
scp -i <ssh private key> -r bcrf@rds-storage.deakin.edu.au:/RDS/RDS12504-Cane-Toad-NGS-projec/project-data/Starling_data_reseq /srv/scratch/z5188231/Deakin.Data
scp -i AAAAB3NzaC1yc2EAAAABIwAAAQEAyyp8dRMhVzxZEKvqZmNjjzzk54ZOx+NtEGFigytGPPB+0aq+3eA7bWNaXCNeufZS6hYq51eQvMnTUzPopcaqOGwJydz1QPLcmHSxFZga3klJkrAZ5ThlAb9zmnARbgSqre/bX3r58lfTXcfA2eo9H3orJUcDyBP5/kkA3uNogYAcpgYJBA5nhuuDMWIOCR+DMqAYz4bP2C6HbMqTVfIz15ONUILjm5CeXx4Pmq51qnoVLNEIHuFI6gAPn+KcRWt127JC1eJpUft6FxmVJsWyQJs1mJUBUti5YbhYTdPogloaoO2Q7B5BwREDnpaXauIdS6+vvLhrSz63csDEqXLIOQ== -r bcrf@rds-storage.deakin.edu.au:/RDS/RDS12504-Cane-Toad-NGS-projec/project-data/Starling_data_reseq /srv/scratch/z5188231/Deakin.Data
scp -i -r bcrf@rds-storage.deakin.edu.au:/RDS/RDS12504-Cane-Toad-NGS-projec/project-data/Starling_data_reseq /srv/scratch/z5188231/Deakin.Data

# worked??
rsync -avuP bcrf@rds-storage.deakin.edu.au:/RDS/RDS12504-Cane-Toad-NGS-projec/project-data/Starling_data_reseq /srv/scratch/z5188231/Deakin.Data
>> done << 

2018-09-23--------------------------------------------------------------[Zip up starling data] 


tar -czvf archivestarlings.tar.gz Starling_data_reseq



2018-09-23--------------------------------------------------------------[Investigating files] 

module load samtools/1.7

# view files
samtools view bamfile.bam | less

LA6: ST-E00264:371:H7H55CCXY:6:1101:10003:30105

# Lenght of files
samtools view gerald_H7H55CCXY_8_TTGGTGCA-TTGGTGCA.bam | wc -l
	28087798

# Number of files matching query
find . -maxdepth 1 -name "gerald_H7H55CCXY_8*" | wc -l
find . -maxdepth 1 -name "*GTCCTTGA-GTCCTTGA*" | wc -l


# Filter out Australian samples from combined data, copy to AustralianStarlings
cp *TCTAGGAG-TCTAGGAG* ../AustralianStarlings/
cp *ACATGGAG-ACATGGAG* ../AustralianStarlings/
cp *GAGCTCTA-GAGCTCTA* ../AustralianStarlings/
cp *AGATCGTC-AGATCGTC* ../AustralianStarlings/
cp *GGCATTCT-GGCATTCT* ../AustralianStarlings/
cp *GAGCAATC-GAGCAATC* ../AustralianStarlings/
cp *GGTAACGT-GGTAACGT* ../AustralianStarlings/
cp *GTCCTTGA-GTCCTTGA* ../AustralianStarlings/

cp Starling_Collab_sample_map.xls ../AustralianStarlings/
cp md5s* ../AustralianStarlings/

# Remove lines in md5s file containing the EU and US starlings 
sed -i '/ACCGGTTA-ACCGGTTA\|AATTCCGG-AATTCCGG\|.../d' ./md5s.new2.txt
grep -c "ACCGGTTA-ACCGGTTA" md5s.new2.txt #test to see if removed
ACCGGTTA-ACCGGTTA
CTAGCTCA-CTAGCTCA
AATTCCGG-AATTCCGG
GGTACGAA-GGTACGAA
CACGTCTA-CACGTCTA
GATACCTG-GATACCTG
AGCGAGAT-AGCGAGAT
TGCCTCAA-TGCCTCAA
GGACTACT-GGACTACT
CGCTACAT-CGCTACAT
TTGGTGCA-TTGGTGCA
TCGCTATC-TCGCTATC
AGATACGG-AGATACGG
CAAGGTAC-CAAGGTAC
GTCCTGTT-GTCCTGTT
GAGAGTAC-GAGAGTAC

# What to do about different lanes.. merge them??
>> resume from here <<

2018-09-23--------------------------------------------------------------[SORT NEW AUS FILES] 

module load samtools/1.7

/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_formatAUS_data_reseq

# Copy the files I will osrt so I dont ruin backups 

cp gerald_H7H55CCXY_*_ACAGTTCG-ACAGTTCG.bam ../Starling_formatAUS_data_reseq
cp gerald_H72N2CCXY_*_ACAGTTCG-ACAGTTCG.bam ../Starling_formatAUS_data_reseq
cp gerald_*_AGATTGCG-AGATTGCG.bam ../Starling_formatAUS_data_reseq
cp gerald_*_CAATGCGA-CAATGCGA.bam ../Starling_formatAUS_data_reseq
cp gerald_*_CTAGCAGT-CTAGCAGT.bam ../Starling_formatAUS_data_reseq
cp gerald_*_GTGAATGG-GTGAATGG.bam ../Starling_formatAUS_data_reseq
cp gerald_*_TCTAGTCC-TCTAGTCC.bam ../Starling_formatAUS_data_reseq

# sort -n is sorting by read name

# samtools sort -n gerald_H7H55CCXY_5_GGACTACT-GGACTACT.bam -o 5_GGACTACT-GGACTACT.sort.bam

samtools sort -n gerald_H72N2CCXY_1_ACAGTTCG-ACAGTTCG.bam -o 1_ACAGTTCG-ACAGTTCG.sort.bam
samtools sort -n gerald_H72N2CCXY_1_AGATTGCG-AGATTGCG.bam -o 1_AGATTGCG-AGATTGCG.sort.bam
samtools sort -n gerald_H72N2CCXY_1_CAATGCGA-CAATGCGA.bam -o 1_CAATGCGA-CAATGCGA.sort.bam
samtools sort -n gerald_H72N2CCXY_1_CTAGCAGT-CTAGCAGT.bam -o 1_CTAGCAGT-CTAGCAGT.sort.bam
samtools sort -n gerald_H72N2CCXY_1_GTGAATGG-GTGAATGG.bam -o 1_GTGAATGG-GTGAATGG.sort.bam
samtools sort -n gerald_H72N2CCXY_1_TCTAGTCC-TCTAGTCC.bam -o 1_TCTAGTCC-TCTAGTCC.sort.bam

samtools sort -n gerald_H72N2CCXY_2_ACAGTTCG-ACAGTTCG.bam -o 2_ACAGTTCG-ACAGTTCG.sort.bam
samtools sort -n gerald_H72N2CCXY_2_AGATTGCG-AGATTGCG.bam -o 2_AGATTGCG-AGATTGCG.sort.bam
samtools sort -n gerald_H72N2CCXY_2_CAATGCGA-CAATGCGA.bam -o 2_CAATGCGA-CAATGCGA.sort.bam
samtools sort -n gerald_H72N2CCXY_2_CTAGCAGT-CTAGCAGT.bam -o 2_CTAGCAGT-CTAGCAGT.sort.bam
samtools sort -n gerald_H72N2CCXY_2_GTGAATGG-GTGAATGG.bam -o 2_GTGAATGG-GTGAATGG.sort.bam
samtools sort -n gerald_H72N2CCXY_2_TCTAGTCC-TCTAGTCC.bam -o 2_TCTAGTCC-TCTAGTCC.sort.bam

samtools sort -n gerald_H7H55CCXY_5_ACAGTTCG-ACAGTTCG.bam -o 5_ACAGTTCG-ACAGTTCG.sort.bam
samtools sort -n gerald_H7H55CCXY_5_AGATTGCG-AGATTGCG.bam -o 5_AGATTGCG-AGATTGCG.sort.bam
samtools sort -n gerald_H7H55CCXY_5_CAATGCGA-CAATGCGA.bam -o 5_CAATGCGA-CAATGCGA.sort.bam
samtools sort -n gerald_H7H55CCXY_5_CTAGCAGT-CTAGCAGT.bam -o 5_CTAGCAGT-CTAGCAGT.sort.bam
samtools sort -n gerald_H7H55CCXY_5_GTGAATGG-GTGAATGG.bam -o 5_GTGAATGG-GTGAATGG.sort.bam
samtools sort -n gerald_H7H55CCXY_5_TCTAGTCC-TCTAGTCC.bam -o 5_TCTAGTCC-TCTAGTCC.sort.bam

samtools sort -n gerald_H7H55CCXY_6_ACAGTTCG-ACAGTTCG.bam -o 6_ACAGTTCG-ACAGTTCG.sort.bam
samtools sort -n gerald_H7H55CCXY_6_AGATTGCG-AGATTGCG.bam -o 6_AGATTGCG-AGATTGCG.sort.bam
samtools sort -n gerald_H7H55CCXY_6_CAATGCGA-CAATGCGA.bam -o 6_CAATGCGA-CAATGCGA.sort.bam
samtools sort -n gerald_H7H55CCXY_6_CTAGCAGT-CTAGCAGT.bam -o 6_CTAGCAGT-CTAGCAGT.sort.bam
samtools sort -n gerald_H7H55CCXY_6_GTGAATGG-GTGAATGG.bam -o 6_GTGAATGG-GTGAATGG.sort.bam
samtools sort -n gerald_H7H55CCXY_6_TCTAGTCC-TCTAGTCC.bam -o 6_TCTAGTCC-TCTAGTCC.sort.bam

samtools sort -n gerald_H7H55CCXY_7_ACAGTTCG-ACAGTTCG.bam -o 7_ACAGTTCG-ACAGTTCG.sort.bam
samtools sort -n gerald_H7H55CCXY_7_AGATTGCG-AGATTGCG.bam -o 7_AGATTGCG-AGATTGCG.sort.bam
samtools sort -n gerald_H7H55CCXY_7_CAATGCGA-CAATGCGA.bam -o 7_CAATGCGA-CAATGCGA.sort.bam
samtools sort -n gerald_H7H55CCXY_7_CTAGCAGT-CTAGCAGT.bam -o 7_CTAGCAGT-CTAGCAGT.sort.bam
samtools sort -n gerald_H7H55CCXY_7_GTGAATGG-GTGAATGG.bam -o 7_GTGAATGG-GTGAATGG.sort.bam
samtools sort -n gerald_H7H55CCXY_7_TCTAGTCC-TCTAGTCC.bam -o 7_TCTAGTCC-TCTAGTCC.sort.bam

samtools sort -n gerald_H7H55CCXY_8_ACAGTTCG-ACAGTTCG.bam -o 8_ACAGTTCG-ACAGTTCG.sort.bam
samtools sort -n gerald_H7H55CCXY_8_AGATTGCG-AGATTGCG.bam -o 8_AGATTGCG-AGATTGCG.sort.bam
samtools sort -n gerald_H7H55CCXY_8_CAATGCGA-CAATGCGA.bam -o 8_CAATGCGA-CAATGCGA.sort.bam
samtools sort -n gerald_H7H55CCXY_8_CTAGCAGT-CTAGCAGT.bam -o 8_CTAGCAGT-CTAGCAGT.sort.bam
samtools sort -n gerald_H7H55CCXY_8_GTGAATGG-GTGAATGG.bam -o 8_GTGAATGG-GTGAATGG.sort.bam
samtools sort -n gerald_H7H55CCXY_8_TCTAGTCC-TCTAGTCC.bam -o 8_TCTAGTCC-TCTAGTCC.sort.bam

# actual extraction from .bam to .fq
# keep r1 and r2 in separate files 
# syntax is bamtofastq -i *.bam -fq *.r1.fq -fq2 *.r2.fq

bedtools bamtofastq -i 1_ACAGTTCG-ACAGTTCG.sort.bam -fq 1_ACAGTTCG-ACAGTTCG.r1.fq -fq2 1_ACAGTTCG-ACAGTTCG.r2.fq
bedtools bamtofastq -i 1_AGATTGCG-AGATTGCG.sort.bam -fq 1_AGATTGCG-AGATTGCG.r1.fq -fq2 1_AGATTGCG-AGATTGCG.r2.fq
bedtools bamtofastq -i 1_CAATGCGA-CAATGCGA.sort.bam -fq 1_CAATGCGA-CAATGCGA.r1.fq -fq2 1_CAATGCGA-CAATGCGA.r2.fq
bedtools bamtofastq -i 1_CTAGCAGT-CTAGCAGT.sort.bam -fq 1_CTAGCAGT-CTAGCAGT.r1.fq -fq2 1_CTAGCAGT-CTAGCAGT.r2.fq
bedtools bamtofastq -i 1_GTGAATGG-GTGAATGG.sort.bam -fq 1_GTGAATGG-GTGAATGG.r1.fq -fq2 1_GTGAATGG-GTGAATGG.r2.fq
bedtools bamtofastq -i 1_TCTAGTCC-TCTAGTCC.sort.bam -fq 1_TCTAGTCC-TCTAGTCC.r1.fq -fq2 1_TCTAGTCC-TCTAGTCC.r2.fq

bedtools bamtofastq -i 2_ACAGTTCG-ACAGTTCG.sort.bam -fq 2_ACAGTTCG-ACAGTTCG.r1.fq -fq2 2_ACAGTTCG-ACAGTTCG.r2.fq
bedtools bamtofastq -i 2_AGATTGCG-AGATTGCG.sort.bam -fq 2_AGATTGCG-AGATTGCG.r1.fq -fq2 2_AGATTGCG-AGATTGCG.r2.fq
bedtools bamtofastq -i 2_CAATGCGA-CAATGCGA.sort.bam -fq 2_CAATGCGA-CAATGCGA.r1.fq -fq2 2_CAATGCGA-CAATGCGA.r2.fq
bedtools bamtofastq -i 2_CTAGCAGT-CTAGCAGT.sort.bam -fq 2_CTAGCAGT-CTAGCAGT.r1.fq -fq2 2_CTAGCAGT-CTAGCAGT.r2.fq
bedtools bamtofastq -i 2_GTGAATGG-GTGAATGG.sort.bam -fq 2_GTGAATGG-GTGAATGG.r1.fq -fq2 2_GTGAATGG-GTGAATGG.r2.fq
bedtools bamtofastq -i 2_TCTAGTCC-TCTAGTCC.sort.bam -fq 2_TCTAGTCC-TCTAGTCC.r1.fq -fq2 2_TCTAGTCC-TCTAGTCC.r2.fq

bedtools bamtofastq -i 5_ACAGTTCG-ACAGTTCG.sort.bam -fq 5_ACAGTTCG-ACAGTTCG.r1.fq -fq2 5_ACAGTTCG-ACAGTTCG.r2.fq
bedtools bamtofastq -i 5_AGATTGCG-AGATTGCG.sort.bam -fq 5_AGATTGCG-AGATTGCG.r1.fq -fq2 5_AGATTGCG-AGATTGCG.r2.fq
bedtools bamtofastq -i 5_CAATGCGA-CAATGCGA.sort.bam -fq 5_CAATGCGA-CAATGCGA.r1.fq -fq2 5_CAATGCGA-CAATGCGA.r2.fq
bedtools bamtofastq -i 5_CTAGCAGT-CTAGCAGT.sort.bam -fq 5_CTAGCAGT-CTAGCAGT.r1.fq -fq2 5_CTAGCAGT-CTAGCAGT.r2.fq
bedtools bamtofastq -i 5_GTGAATGG-GTGAATGG.sort.bam -fq 5_GTGAATGG-GTGAATGG.r1.fq -fq2 5_GTGAATGG-GTGAATGG.r2.fq
bedtools bamtofastq -i 5_TCTAGTCC-TCTAGTCC.sort.bam -fq 5_TCTAGTCC-TCTAGTCC.r1.fq -fq2 5_TCTAGTCC-TCTAGTCC.r2.fq

bedtools bamtofastq -i 6_ACAGTTCG-ACAGTTCG.sort.bam -fq 6_ACAGTTCG-ACAGTTCG.r1.fq -fq2 6_ACAGTTCG-ACAGTTCG.r2.fq
bedtools bamtofastq -i 6_AGATTGCG-AGATTGCG.sort.bam -fq 6_AGATTGCG-AGATTGCG.r1.fq -fq2 6_AGATTGCG-AGATTGCG.r2.fq
bedtools bamtofastq -i 6_CAATGCGA-CAATGCGA.sort.bam -fq 6_CAATGCGA-CAATGCGA.r1.fq -fq2 6_CAATGCGA-CAATGCGA.r2.fq
bedtools bamtofastq -i 6_CTAGCAGT-CTAGCAGT.sort.bam -fq 6_CTAGCAGT-CTAGCAGT.r1.fq -fq2 6_CTAGCAGT-CTAGCAGT.r2.fq
bedtools bamtofastq -i 6_GTGAATGG-GTGAATGG.sort.bam -fq 6_GTGAATGG-GTGAATGG.r1.fq -fq2 6_GTGAATGG-GTGAATGG.r2.fq
bedtools bamtofastq -i 6_TCTAGTCC-TCTAGTCC.sort.bam -fq 6_TCTAGTCC-TCTAGTCC.r1.fq -fq2 6_TCTAGTCC-TCTAGTCC.r2.fq

bedtools bamtofastq -i 7_ACAGTTCG-ACAGTTCG.sort.bam -fq 7_ACAGTTCG-ACAGTTCG.r1.fq -fq2 7_ACAGTTCG-ACAGTTCG.r2.fq
bedtools bamtofastq -i 7_AGATTGCG-AGATTGCG.sort.bam -fq 7_AGATTGCG-AGATTGCG.r1.fq -fq2 7_AGATTGCG-AGATTGCG.r2.fq
bedtools bamtofastq -i 7_CAATGCGA-CAATGCGA.sort.bam -fq 7_CAATGCGA-CAATGCGA.r1.fq -fq2 7_CAATGCGA-CAATGCGA.r2.fq
bedtools bamtofastq -i 7_CTAGCAGT-CTAGCAGT.sort.bam -fq 7_CTAGCAGT-CTAGCAGT.r1.fq -fq2 7_CTAGCAGT-CTAGCAGT.r2.fq
bedtools bamtofastq -i 7_GTGAATGG-GTGAATGG.sort.bam -fq 7_GTGAATGG-GTGAATGG.r1.fq -fq2 7_GTGAATGG-GTGAATGG.r2.fq
bedtools bamtofastq -i 7_TCTAGTCC-TCTAGTCC.sort.bam -fq 7_TCTAGTCC-TCTAGTCC.r1.fq -fq2 7_TCTAGTCC-TCTAGTCC.r2.fq

bedtools bamtofastq -i 8_ACAGTTCG-ACAGTTCG.sort.bam -fq 8_ACAGTTCG-ACAGTTCG.r1.fq -fq2 8_ACAGTTCG-ACAGTTCG.r2.fq
bedtools bamtofastq -i 8_AGATTGCG-AGATTGCG.sort.bam -fq 8_AGATTGCG-AGATTGCG.r1.fq -fq2 8_AGATTGCG-AGATTGCG.r2.fq
bedtools bamtofastq -i 8_CAATGCGA-CAATGCGA.sort.bam -fq 8_CAATGCGA-CAATGCGA.r1.fq -fq2 8_CAATGCGA-CAATGCGA.r2.fq
bedtools bamtofastq -i 8_CTAGCAGT-CTAGCAGT.sort.bam -fq 8_CTAGCAGT-CTAGCAGT.r1.fq -fq2 8_CTAGCAGT-CTAGCAGT.r2.fq
bedtools bamtofastq -i 8_GTGAATGG-GTGAATGG.sort.bam -fq 8_GTGAATGG-GTGAATGG.r1.fq -fq2 8_GTGAATGG-GTGAATGG.r2.fq
bedtools bamtofastq -i 8_TCTAGTCC-TCTAGTCC.sort.bam -fq 8_TCTAGTCC-TCTAGTCC.r1.fq -fq2 8_TCTAGTCC-TCTAGTCC.r2.fq

# check that extracting .bam worked

head -8 1_ACAGTTCG-ACAGTTCG.r1.fq
head -8 1_ACAGTTCG-ACAGTTCG.r2.fq

# concatenate end1 and end2 files so all individuals in same file 
# 2 for every individual (input is 6 files)
# example: cat *.r1.fq > uk1.1.fq

cp *.fq/home/nrh44/EUST_RESEQ_2017/rawFASTAfiles /workdir/nrh44
cp /home/nrh44/EUST_RESEQ_2017/cat.sh

cat 1_ACAGTTCG-ACAGTTCG.r1.fq 2_ACAGTTCG-ACAGTTCG.r1.fq 5_ACAGTTCG-ACAGTTCG.r1.fq 6_ACAGTTCG-ACAGTTCG.r1.fq 7_ACAGTTCG-ACAGTTCG.r1.fq 8_ACAGTTCG-ACAGTTCG.r1.fq > au9.1.fq
cat 1_ACAGTTCG-ACAGTTCG.r2.fq 2_ACAGTTCG-ACAGTTCG.r2.fq 5_ACAGTTCG-ACAGTTCG.r2.fq 6_ACAGTTCG-ACAGTTCG.r2.fq 7_ACAGTTCG-ACAGTTCG.r2.fq 8_ACAGTTCG-ACAGTTCG.r2.fq > au9.2.fq
cat 1_AGATTGCG-AGATTGCG.r1.fq 2_AGATTGCG-AGATTGCG.r1.fq 5_AGATTGCG-AGATTGCG.r1.fq 6_AGATTGCG-AGATTGCG.r1.fq 7_AGATTGCG-AGATTGCG.r1.fq 8_AGATTGCG-AGATTGCG.r1.fq > au10.1.fq
cat 1_AGATTGCG-AGATTGCG.r2.fq 2_AGATTGCG-AGATTGCG.r2.fq 5_AGATTGCG-AGATTGCG.r2.fq 6_AGATTGCG-AGATTGCG.r2.fq 7_AGATTGCG-AGATTGCG.r2.fq 8_AGATTGCG-AGATTGCG.r2.fq > au10.2.fq

cat 1_CAATGCGA-CAATGCGA.r1.fq 2_CAATGCGA-CAATGCGA.r1.fq 5_CAATGCGA-CAATGCGA.r1.fq 6_CAATGCGA-CAATGCGA.r1.fq 7_CAATGCGA-CAATGCGA.r1.fq 8_CAATGCGA-CAATGCGA.r1.fq > au11.1.fq
cat 1_CAATGCGA-CAATGCGA.r2.fq 2_CAATGCGA-CAATGCGA.r2.fq 5_CAATGCGA-CAATGCGA.r2.fq 6_CAATGCGA-CAATGCGA.r2.fq 7_CAATGCGA-CAATGCGA.r2.fq 8_CAATGCGA-CAATGCGA.r2.fq > au11.2.fq
cat 1_CTAGCAGT-CTAGCAGT.r1.fq 2_CTAGCAGT-CTAGCAGT.r1.fq 5_CTAGCAGT-CTAGCAGT.r1.fq 6_CTAGCAGT-CTAGCAGT.r1.fq 7_CTAGCAGT-CTAGCAGT.r1.fq 8_CTAGCAGT-CTAGCAGT.r1.fq > au12.1.fq
cat 1_CTAGCAGT-CTAGCAGT.r2.fq 2_CTAGCAGT-CTAGCAGT.r2.fq 5_CTAGCAGT-CTAGCAGT.r2.fq 6_CTAGCAGT-CTAGCAGT.r2.fq 7_CTAGCAGT-CTAGCAGT.r2.fq 8_CTAGCAGT-CTAGCAGT.r2.fq > au12.2.fq

cat 1_GTGAATGG-GTGAATGG.r1.fq 2_GTGAATGG-GTGAATGG.r1.fq 5_GTGAATGG-GTGAATGG.r1.fq 6_GTGAATGG-GTGAATGG.r1.fq 7_GTGAATGG-GTGAATGG.r1.fq 8_GTGAATGG-GTGAATGG.r1.fq > au13.1.fq
cat 1_GTGAATGG-GTGAATGG.r2.fq 2_GTGAATGG-GTGAATGG.r2.fq 5_GTGAATGG-GTGAATGG.r2.fq 6_GTGAATGG-GTGAATGG.r2.fq 7_GTGAATGG-GTGAATGG.r2.fq 8_GTGAATGG-GTGAATGG.r2.fq > au13.2.fq
cat 1_TCTAGTCC-TCTAGTCC.r1.fq 2_TCTAGTCC-TCTAGTCC.r1.fq 5_TCTAGTCC-TCTAGTCC.r1.fq 6_TCTAGTCC-TCTAGTCC.r1.fq 7_TCTAGTCC-TCTAGTCC.r1.fq 8_TCTAGTCC-TCTAGTCC.r1.fq > au14.1.fq
cat 1_TCTAGTCC-TCTAGTCC.r2.fq 2_TCTAGTCC-TCTAGTCC.r2.fq 5_TCTAGTCC-TCTAGTCC.r2.fq 6_TCTAGTCC-TCTAGTCC.r2.fq 7_TCTAGTCC-TCTAGTCC.r2.fq 8_TCTAGTCC-TCTAGTCC.r2.fq > au14.2.fq


cp au*.fq FASTAfiles

# quality check with FastQC

mkdir /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC

fastqc au9.1.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC

fastqc au9.2.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au10.1.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au10.2.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au11.1.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au11.2.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au12.1.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au12.2.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au13.1.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au13.2.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au14.1.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC
fastqc au14.2.fq --outdir=/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_fastQC

# AdapterRemoval
# adapters 1 and 2 default settings

/share/apps/adapterremoval/2.2.2/bin/AdapterRemoval --file1 au9.1.fq --file2 au9.2.fq --basename output_paired --trimns --trimqualities --collapse


/share/apps/adapterremoval/2.2.2/bin/AdapterRemoval --file1 au9.1.fq --file2 au9.2.fq --basename au9 --trimns --trimqualities --collapse
/share/apps/adapterremoval/2.2.2/bin/AdapterRemoval --file1 au10.1.fq --file2 au10.2.fq --basename au10 --trimns --trimqualities --collapse
/share/apps/adapterremoval/2.2.2/bin/AdapterRemoval --file1 au11.1.fq --file2 au11.2.fq --basename au11 --trimns --trimqualities --collapse
/share/apps/adapterremoval/2.2.2/bin/AdapterRemoval --file1 au12.1.fq --file2 au12.2.fq --basename au12 --trimns --trimqualities --collapse
/share/apps/adapterremoval/2.2.2/bin/AdapterRemoval --file1 au13.1.fq --file2 au13.2.fq --basename au13 --trimns --trimqualities --collapse
/share/apps/adapterremoval/2.2.2/bin/AdapterRemoval --file1 au14.1.fq --file2 au14.2.fq --basename au14 --trimns --trimqualities --collapse

rm au*.*.fq

2018-11-01--------------------------------------------------------------[MAPPING]

# Reference genome info
# assembly downloaded from Genbank (filename = GCA_001447265.1_Sturnus_vulgaris-1.0_genomic.fna)
# renamed to Svulgaris_genomic.fna

# index the reference genome, -f means fasta input
module load bowtie/2.3.2

cd /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_formatAUS_data_reseq/
/share/apps/bowtie/2.3.2/bowtie2-build -f Svulgaris_genomic.fna Svulgaris

# use bowtie to align paired-end reads to reference
# -p to run on parallel threads (EX: 16 threads on medium machine)
# -I and -X set min and max alignment lengths (if more similar, runs faster)

bowtie2 -p 16 --phred33 --very-sensitive-local -x STAR -I 149 -X 900 --rg-id uk1 --rg SM:uk1 -1 /workdir/nrh44/uk1.pair1.truncated -2 /workdir/nrh44/uk1.pair2.truncated -U /workdir/nrh44/uk1.collapsed,/workdir/nrh44/uk1.collapsed.truncated,/workdir/nrh44/uk1.singleton.truncated -S ./uk1.sam
samtools view -bS uk1.sam > uk1.bam
samtools sort uk1.bam -o uk1_sort.bam
rm uk1.sam
rm uk1.bam

cd /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_formatAUS_data_reseq/

bowtie2 -p 16 --phred33 --very-sensitive-local -x Svulgaris -I 149 -X 900 --rg-id au9 --rg SM:au9 -1 au9.pair1.truncated -2 au9.pair2.truncated -U au9.collapsed,au9.collapsed.truncated,au9.singleton.truncated -S ./au9.sam
bowtie2 -p 10 --phred33 --very-sensitive-local -x Svulgaris -I 149 -X 900 --rg-id au10 --rg SM:au10 -1 au10.pair1.truncated -2 au10.pair2.truncated -U au10.collapsed,au10.collapsed.truncated,au10.singleton.truncated -S ./au10.sam
bowtie2 -p 10 --phred33 --very-sensitive-local -x Svulgaris -I 149 -X 900 --rg-id au11 --rg SM:au11 -1 au11.pair1.truncated -2 au11.pair2.truncated -U au11.collapsed,au11.collapsed.truncated,au11.singleton.truncated -S ./au11.sam
bowtie2 -p 10 --phred33 --very-sensitive-local -x Svulgaris -I 149 -X 900 --rg-id au12 --rg SM:au12 -1 au12.pair1.truncated -2 au12.pair2.truncated -U au12.collapsed,au12.collapsed.truncated,au12.singleton.truncated -S ./au12.sam
bowtie2 -p 10 --phred33 --very-sensitive-local -x Svulgaris -I 149 -X 900 --rg-id au13 --rg SM:au13 -1 au13.pair1.truncated -2 au13.pair2.truncated -U au13.collapsed,au13.collapsed.truncated,au13.singleton.truncated -S ./au13.sam
bowtie2 -p 10 --phred33 --very-sensitive-local -x Svulgaris -I 149 -X 900 --rg-id au14 --rg SM:au14 -1 au14.pair1.truncated -2 au14.pair2.truncated -U au14.collapsed,au14.collapsed.truncated,au14.singleton.truncated -S ./au14.sam

module load samtools/1.7

samtools view -bS au9.sam > au9.bam
samtools sort au9.bam -o au9_sort.bam

samtools view -bS au10.sam > au10.bam
samtools sort au10.bam -o au10_sort.bam

samtools view -bS au11.sam > au11.bam
samtools sort au11.bam -o au11_sort.bam

samtools view -bS au12.sam > au12.bam
samtools sort au12.bam -o au12_sort.bam

samtools view -bS au13.sam > au13.bam
samtools sort au13.bam -o au13_sort.bam

samtools view -bS au14.sam > au14.bam
samtools sort au14.bam -o au14_sort.bam

rm au9.sam
rm au9.bam

rm au10.sam
rm au10.bam

rm au11.sam
rm au11.bam

rm au12.sam
rm au12.bam

rm au13.sam
rm au13.bam

rm au14.sam
rm au14.bam

rm au*.truncated
rm au*.discarded
rm au*.collapsed
rm au*.settings

# qualimap on the command line
# increase RAM for medium machine

module load qualimap/2.2.1



/share/apps/qualimap/2.2.1/qualimap.jar bamqc -bam au9_sort.bam -outdir au9_sort --java-mem-size=128G
/share/apps/qualimap/2.2.1/qualimap.jar bamqc -bam uk1_sort.bam -outdir au10_sort --java-mem-size=128G
/share/apps/qualimap/2.2.1/qualimap.jar bamqc -bam uk1_sort.bam -outdir au11_sort --java-mem-size=128G
/share/apps/qualimap/2.2.1/qualimap.jar bamqc -bam uk1_sort.bam -outdir au12_sort --java-mem-size=128G
/share/apps/qualimap/2.2.1/qualimap.jar bamqc -bam uk1_sort.bam -outdir au13_sort --java-mem-size=128G
/share/apps/qualimap/2.2.1/qualimap.jar bamqc -bam uk1_sort.bam -outdir au14_sort --java-mem-size=128G





2018-11-06--------------------------------------------------------------[Variant calling]


# Variant Calling - HaplotypeCaller
# bam files from mapping script above are indexed and sorted already
# note that -Xmx below is a Java Virtual Machine command to specify memory (-Xmx48g is 48 GB)

# prepare the genome for GATK: index it (fai and dict files)
# make dict file (sequence dictionary of the contig names)
module load samtools/1.7
module load picard/2.18.4
module load java/8u91
or
java/8u45

# test if picard tools works 
java -jar picard.jar -h 

java -Xmx48g -jar picard.jar CreateSequenceDictionary R= Svulgaris_genomic.fna O= Svulgaris_genomic.dict
# make fai index file to allow random access to fasta files
samtools faidx Svulgaris_genomic.fna

cd /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_format_data_reseq

cd /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_formatAUS_data_reseq/

# add read group information (variantredgroup_script)
# use samtools view -H sample.bam | grep '@RG' 
# samtools command above will print required fields for the AddOrReplaceReadGroups below
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au1_sort.bam OUTPUT=au1_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=TCTAGGAG RGSM=au1_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au2_sort.bam OUTPUT=au2_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=ACATGGAG RGSM=au2_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au3_sort.bam OUTPUT=au3_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=GAGCTCTA RGSM=au3_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au4_sort.bam OUTPUT=au4_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=AGATCGTC RGSM=au4_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au5_sort.bam OUTPUT=au5_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=GGCATTCT RGSM=au5_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au6_sort.bam OUTPUT=au6_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=GAGCAATC RGSM=au6_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au7_sort.bam OUTPUT=au7_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=GGTAACGT RGSM=au7_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au8_sort.bam OUTPUT=au8_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=GTCCTTGA RGSM=au8_sort


java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au9_sort.bam OUTPUT=au9_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=ACAGTTCG RGSM=au9_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au10_sort.bam OUTPUT=au10_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=AGATTGCG RGSM=au10_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au11_sort.bam OUTPUT=au11_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=CAATGCGA RGSM=au11_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au12_sort.bam OUTPUT=au12_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=CTAGCAGT RGSM=au12_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au13_sort.bam OUTPUT=au13_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=GTGAATGG RGSM=au13_sort
java -Xmx48g -jar picard.jar AddOrReplaceReadGroups INPUT=au14_sort.bam OUTPUT=au14_sortRG.bam RGID=1 RGLB=lib1 RGPL=illumina RGPU=TCTAGTCC RGSM=au14_sort

# mark duplicates (variantduplicate_script)
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au1_sortRG.bam OUTPUT=au1_sortRGmark.bam METRICS_FILE=au1_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au2_sortRG.bam OUTPUT=au2_sortRGmark.bam METRICS_FILE=au2_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au3_sortRG.bam OUTPUT=au3_sortRGmark.bam METRICS_FILE=au3_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au4_sortRG.bam OUTPUT=au4_sortRGmark.bam METRICS_FILE=au4_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au5_sortRG.bam OUTPUT=au5_sortRGmark.bam METRICS_FILE=au5_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au6_sortRG.bam OUTPUT=au6_sortRGmark.bam METRICS_FILE=au6_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au7_sortRG.bam OUTPUT=au7_sortRGmark.bam METRICS_FILE=au7_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au8_sortRG.bam OUTPUT=au8_sortRGmark.bam METRICS_FILE=au8_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000

java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au9_sortRG.bam OUTPUT=au9_sortRGmark.bam METRICS_FILE=au9_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au10_sortRG.bam OUTPUT=au10_sortRGmark.bam METRICS_FILE=au10_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au11_sortRG.bam OUTPUT=au11_sortRGmark.bam METRICS_FILE=au11_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au12_sortRG.bam OUTPUT=au12_sortRGmark.bam METRICS_FILE=au12_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au13_sortRG.bam OUTPUT=au13_sortRGmark.bam METRICS_FILE=au13_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000
java -Xmx48g -jar picard.jar MarkDuplicates INPUT=au14_sortRG.bam OUTPUT=au14_sortRGmark.bam METRICS_FILE=au14_sort.metrics.txt MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000

# since running HaplotypeCaller, don't need to realign or fix mates unless there is an error in ValidateSamFile (variantvalidate_script)
java -Xmx48g -jar picard.jar ValidateSamFile I=au1_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au2_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au3_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au4_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au5_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au6_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au7_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au8_sortRGmark.bam MODE=SUMMARY

java -Xmx48g -jar picard.jar ValidateSamFile I=au9_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au10_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au11_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au12_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au13_sortRGmark.bam MODE=SUMMARY
java -Xmx48g -jar picard.jar ValidateSamFile I=au14_sortRGmark.bam MODE=SUMMARY

# index .bam files for HaplotypeCaller (variantindex_script)
java -Xmx48g -jar picard.jar BuildBamIndex I=au1_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au2_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au3_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au4_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au5_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au6_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au7_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au8_sortRGmark.bam

java -Xmx48g -jar picard.jar BuildBamIndex I=au9_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au10_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au11_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au12_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au13_sortRGmark.bam
java -Xmx48g -jar picard.jar BuildBamIndex I=au14_sortRGmark.bam

# Variant Calling with HaplotypeCaller (variantcalling_script)
# run in GVCF mode to speed things up
# default presets with discovery mode (no alleles passed), emit confidence phred of 10, call confidence phred 30
module load samtools/1.7
module load java/8u91
module load gatk/4.0.4.0
module load picard/2.18.4



java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au1_sortRGmark.bam -o au1.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au2_sortRGmark.bam -o au2.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au3_sortRGmark.bam -o au3.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au4_sortRGmark.bam -o au4.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au5_sortRGmark.bam -o au5.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au6_sortRGmark.bam -o au6.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au7_sortRGmark.bam -o au7.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au8_sortRGmark.bam -o au8.g.vcf

java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au9_sortRGmark.bam -o au9.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au10_sortRGmark.bam -o au10.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au11_sortRGmark.bam -o au11.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au12_sortRGmark.bam -o au12.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au13_sortRGmark.bam -o au13.g.vcf
java -Xmx8g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R Svulgaris_genomic.fna -nct 6 -mmq 10 --emitRefConfidence GVCF -I au14_sortRGmark.bam -o au14.g.vcf



# then combine individual GVCF files into joint VCF
module load samtools/1.7
module load picard/2.18.4
module load java/8u91
module load gatk/4.0.4.0

cd /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data

alias java='java -Xmx48g'  
export _JAVA_OPTIONS="-Xmx48g"
java -XshowSettings:vm 

java -Xmx48g -Xms48g  -jar GenomeAnalysisTK.jar -T GenotypeGVCFs -R Svulgaris_genomic.fna \
--variant au1.g.vcf \
--variant au2.g.vcf \
--variant au3.g.vcf \
--variant au4.g.vcf \
--variant au5.g.vcf \
--variant au6.g.vcf \
--variant au7.g.vcf \
--variant au8.g.vcf \
--variant au9.g.vcf \
--variant au10.g.vcf \
--variant au11.g.vcf \
--variant au12.g.vcf \
--variant au13.g.vcf \
--variant au14.g.vcf \
-o AUstarlings.vcf



2018-11-12--------------------------------------------------------------[Filtering]

java -Xmx48g -jar GenomeAnalysisTK.jar -T VariantFiltration -R Svulgaris_genomic.fna \
--variant AUstarlings.vcf -o AUstarlings_filtered.vcf \
--filterExpression "QD<2.0||FS>60.0||MQ<40.0||SOR>3.0" --filterName "first_snp_filter"

# try filtering one at a time and label in GATK to pull out which filter is hitting data hardest

### filters you should always use:
# QD is quality/depth of non-reference reads (best practices: filter out below 2 because fail VQSR)
# FS is probability that there is strand bias (filter above 55-60 because fail VQSR)
# SOR is strand odds ratio, also calculates strand bias (filter above 3)
# MQ is the root-mean-square mapping quality, includes standard deviation and thus variation in data (if mapping quality is good, then MQ around 60)

### filters that may or may not apply in your data:
# MQRankSum compares the mapping quality of reads carrying an alternative allele to the reference reads, want to see value around 0, this "hard filter" is particularly tough to call
# ReadPosRankSum indicates how close the variant site is to the ends of reads (if close to end, more likely that it's a sequencing error)
module load vcftools/0.1.14

vcftools --vcf AUstarlings_filtered.vcf --max-missing-count 4 --maf 0.1 --min-meanDP 2 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --recode --out AUstarlings_maf01.vcf

# Maf filter; depth filter; missing data filter (over total individuals)
--maf 0.1
--min-meanDP 2
--max-meanDP 50 #Avoid repetitive areas
--max-missing-count 4 #about 20% missing data

KQ
 
grep -c "^KQ" AUstarlings_maf025.vcf.recode.vcf

# After filtering, 9,729,222 SNPs


vcftools --vcf AUstarlings_filtered.vcf --max-missing-count 4 --maf 0.05 --min-meanDP 2 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --recode --out AUstarlings_maf005.vcf
# filter with less stringent MAF of 5%
# kept 15,035,392 SNPs

vcftools --vcf AUstarlings_filtered.vcf --max-missing-count 4 --maf 0.01 --min-meanDP 2 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --recode --out AUstarlings_maf01.vcf
# filter with less stringent MAF of 1%
# kept 9,729,222 SNPs

vcftools --vcf AUstarlings_filtered.vcf --max-missing-count 4 --maf 0.25 --min-meanDP 2 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --recode --out AUstarlings_maf025X.vcf
# filter with more stringent MAF
# After filtering, 4898824 SNPs

vcftools --vcf AUstarlings_filtered.vcf --max-missing-count 4 --maf 0.25 --min-meanDP 5 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --recode --out AUstarlings_maf025.vcf

# more stringent MAF and SNP present in at least 5 individuals
# After filtering, 4,467,936 SNPs according to structure

# calculate SNP density to inspect variation across genome (prep for LD filtering)
vcftools --vcf AUstarlings_maf025.vcf.recode.vcf --SNPdensity 50000 --out AUstarlings_maf025_50000
vcftools --vcf AUstarlings_maf025.vcf.recode.vcf --SNPdensity 10000 --out AUstarlings_maf025_10000

grep -c "^KQ" AUstarlings_maf025_10000.snpden
grep -c "^KQ" AUstarlings_maf025_50000.snpden

vcftools --vcf AUstarlings_maf025.vcf --singletons --out AUstarlings_maf025
vcftools --vcf AUstarlings_maf025.vcf --hist-indel-len --out AUstarlings_maf025

# keep only one SNP per 50kb
vcftools --vcf AUstarlings_maf025.vcf --thin 50000 --out AUstarlings_maf025_test
grep -c "^KQ" AUstarlings_maf025.vcf


# remove uk2 weird relatedness and doesn't cluster, us3 outlier
# more stringent MAF and SNP present in at least 5 individuals
# After filtering, 4,467,936 SNPs according to structure

# calculate SNP density to inspect variation across genome (prep for LD filtering)
vcftools --vcf AUstarlings_maf01.vcf.recode.vcf --SNPdensity 50000 --out EUSTreseq_maf01_50000.snpden
vcftools --vcf AUstarlings_maf01.vcf.recode.vcf --SNPdensity 10000 --out EUSTreseq_maf01_10000.snpden

vcftools --vcf AUstarlings_maf01.vcf.recode.vcf --singletons
vcftools --vcf AUstarlings_maf01.vcf.recode.vcf --hist-indel-len

# keep only one SNP per 50kb
vcftools --vcf AUstarlings_maf01.vcf.recode.vcf --thin 50000 --out EUSTreseq_maf01_thin.snpden
vcftools --vcf AUstarlings_maf01.vcf.recode.vcf --thin 50000


2018-11-13--------------------------------------------------------------[POPGEN basics]


vcftools --vcf AUstarlings_maf025.vcf --relatedness &> relatedness.log &
vcftools --vcf AUstarlings_maf025.vcf --depth -c > EUSTreseq_depthsummary.txt &> depth.log &
vcftools --vcf AUstarlings_maf025.vcf --het &> het.log &

vcftools --vcf AUstarlings_filtered.vcf --TajimaD 25000 &> TajimaD25kb.log &
vcftools --vcf AUstarlings_filtered.vcf --window-pi 25000 &> windowpi25kb.log &


# sliding window scans a la Petra
vcftools --vcf AUstarlings_filtered.vcf --fst-window-size 50000 --fst-window-step 10000 --out AUstarlings.fstwindow10kb &> fstwindow10kb.log &
vcftools --vcf AUstarlings_filtered.vcf --window-pi 50000 --window-pi-step 10000 --out AUstarlings.windowpi10kb &> windowpi10kb.log &
vcftools --vcf AUstarlings_filtered.vcf --TajimaD 1000 --out AUstarlings.TajimaD.1kb &> TajimaD1kb.log &

# need a chromosome for LROH? not run yet.
vcftools --vcf AUstarlings_filtered.vcf --LROH &> LROH.log &


# Fst calculations
TCTAGGAG-TCTAGGAG au1 SVAF-NL006-NL006
ACATGGAG-ACATGGAG au2 SVAF-NL020-NL020
GAGCTCTA-GAGCTCTA au3 SVAF-NM019-NM019
AGATCGTC-AGATCGTC au4 SVAF-NM020-NM020
GGCATTCT-GGCATTCT au5 SVAF-SM110-SM110
GAGCAATC-GAGCAATC au6 SVAF-SM123-SM123
GGTAACGT-GGTAACGT au7 SVAF-VW006-VW006
GTCCTTGA-GTCCTTGA au8 SVAF-VW012-VW012
ACAGTTCG-ACAGTTCG au9 SVAF-WM728-WM728
CAATGCGA-CAATGCGA au11 SVAF-WM275-WM275
AGATTGCG-AGATTGCG au10 SVAF-NH005-NH005
GTGAATGG-GTGAATGG au13 SVAF-NH008-NH008
CTAGCAGT-CTAGCAGT au12 SVAF-WC021-WC021
TCTAGTCC-TCTAGTCC au14 SVAF-ND014-ND014


vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popND --weir-fst-pop popNH --out ND_v_NH
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popND --weir-fst-pop popNL --out ND_v_NL
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popND --weir-fst-pop popNM --out ND_v_NM
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popND --weir-fst-pop popSM --out ND_v_SM
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popND --weir-fst-pop popVW --out ND_v_VW
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popND --weir-fst-pop popWC --out ND_v_WC
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popND --weir-fst-pop popWM --out ND_v_WM

vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNH --weir-fst-pop popNL --out NH_v_NL
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNH --weir-fst-pop popNM --out NH_v_NM
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNH --weir-fst-pop popSM --out NH_v_SM
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNH --weir-fst-pop popVW --out NH_v_VW
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNH --weir-fst-pop popWC --out NH_v_WC
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNH --weir-fst-pop popWM --out NH_v_WM

vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNL --weir-fst-pop popNM --out NL_v_NM
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNL --weir-fst-pop popSM --out NL_v_SM
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNL --weir-fst-pop popVW --out NL_v_VW
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNL --weir-fst-pop popWC --out NL_v_WC
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNL --weir-fst-pop popWM --out NL_v_WM

vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNM --weir-fst-pop popSM --out NM_v_SM
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNM --weir-fst-pop popVW --out NM_v_VW
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNM --weir-fst-pop popWC --out NM_v_WC
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popNM --weir-fst-pop popWM --out NM_v_WM

vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popSM --weir-fst-pop popVW --out SM_v_VW
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popSM --weir-fst-pop popWC --out SM_v_WC
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popSM --weir-fst-pop popWM --out SM_v_WM

vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popVW --weir-fst-pop popWC --out VW_v_WC
vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popVW --weir-fst-pop popWM --out VW_v_WM

vcftools --vcf AUstarlings_maf001.vcf.recode.vcf --weir-fst-pop popWC --weir-fst-pop popWM --out WC_v_WM

# Run populations for fstats, phi-stats, prepare for STRUCTURE
/share/apps/stacks/2.2/bin/populations -V /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/AUstarlings_maf01.vcf -O /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks2 -M /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/populations.txt -t 15 --p_value_cutoff 0.05 --phylip --structure --fstats --write_single_snp

grep -v "^#" /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks/AUstarlings_maf01.p.structure > /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks/AUstarlings_maf01.p.structure_copy
sed 1d /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks/AUstarlings_maf01.p.structure_copy > /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks/AUstarlings_maf01.str

grep -v "^#" /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks025/AUstarlings_maf025.p.structure > /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks025/AUstarlings_maf025.p.structure_copy
sed 1d /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks025/AUstarlings_maf025.p.structure_copy > /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks025/AUstarlings_maf025.str

grep -c "^KQ" AUstarlings_maf025.str

awk '{print NF}' AUstarlings_maf025.str | sort -nu | tail -n 1

#### reformatting for other analyses
# make plink file 
module load vcftools/0.1.14

vcftools --vcf AUstarlings_maf001.vcf --out AUstarlings_maf001.plink --plink

vcftools --vcf AUstarlings_maf01.vcf --out AUstarlings_maf01.plink --plink

vcftools --vcf AUstarlings_maf025.vcf --out AUstarlings_maf025.plink --plink

# to get into .bed .bim .fam
module load plink/1.07

plink --file AUstarlings_maf01.plink --make-bed --noweb --out AUstarlings_maf01

plink --file AUstarlings_maf001.plink --make-bed --noweb --out AUstarlings_maf001

plink --file AUstarlings_maf025.plink --make-bed --noweb --out AUstarlings_maf025

2018-11-14--------------------------------------------------------------[FastStructure]

module load git/2.7.1
module load gsl/2.1
module load python/2.7.15

cd /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/stacks001/

python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 1 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K1.log & 
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 2 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K2.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 3 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K3.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 4 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K4.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 5 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K5.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 6 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K6.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 7 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K7.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 8 --input=AUstarlings_maf01 --output=AUstarlings_maf01_out &> fastSTRUCTURE.K8.log &

python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 1 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K1.log & 
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 2 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K2.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 3 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K3.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 4 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K4.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 5 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K5.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 6 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K6.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 7 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K7.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 8 --input=AUstarlings_maf025 --output=AUstarlings_maf025_out &> fastSTRUCTURE.K8.log &

python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 1 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K1.log & 
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 2 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K2.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 3 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K3.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 4 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K4.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 5 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K5.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 6 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K6.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 7 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K7.log &
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/structure.py -K 8 --input=AUstarlings_maf001 --output=AUstarlings_maf001_out &> fastSTRUCTURE.K8.log &

#more efficient script alternative
#for K in 1 2 3 4 5 6 7 8 9 10;
#do python /home/dselech/bin/fastStructure/structure.py -K $K --input=/home/dselech/trumbo/populations_filter_nonsw/set1/populations --format=str --prior=simple --output=/home/dselech/trumbo/faststructure_nonsw/set1/populations --full
#done
#python /home/dselech/bin/fastStructure/chooseK.py --input=/home/dselech/trumbo/faststructure_nonsw/set1/populations

# to determine which K fits best
python chooseK.py --input=AUstarlings_maf01_out

python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/chooseK.py --input=AUstarlings_maf025_out

# Model complexity that maximizes marginal likelihood = 1
# Model components used to explain structure in data = 3

# to visualize
python /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure2/fastStructure/distruct.py -K 1 --input=AUstarlings_maf01_out --output=AUstarlings_maf01_out1_distruct.svg

#or jump to R script 

2018-11-16--------------------------------------------------------------[ENV EXPLORE]

module load R/3.5.1

cd /srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/environment/

vcftools --vcf AUstarlings_filtered.vcf --max-missing-count 0 --maf 0.01 --min-meanDP 2 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --recode --out AUstarlings_maf01_nomiss.vcf

vcftools --vcf AUstarlings_maf01_nomiss.vcf --thin 50000 --recode --out AUstarlings_maf01_nomiss_thin.vcf

vcftools --vcf AUstarlings_maf01_nomiss_thin.vcf --012 --out AUstarlings_maf01_nomiss

vcftools --vcf AUstarlings_maf01_nomiss.vcf --012 --out AUstarlings_maf01_nomiss


# https://github.com/simonhmartin/genomics_general 

python parseVCF.py -i AUstarlings_filtered.vcf  --skipIndels --minQual 30 --gtf flag=DP min=5 | gzip > AUstarlings_filtered.geno.gz

python popgenWindows.py -w 10000 -m 300 -g AUstarlings_filtered2.geno.gz -o AUstarlings_window10kb_300_state.csv.gz -f phased \
-p NSW1 au1_sort,au3_sort,au4_sort,au12_sort -p NSW2 au2_sort,au10_sort,au14_sort -p VIC au7_sort,au8_sort \
-p SA au5_sort,au6_sort -p WA au9_sort,au11_sort \
--popsFile populations.txt --addWindowID

#using structure outputs to determine which populations are objectivity and subjectivity , help add clarity
new pops:

au1_sort        NSW1
au2_sort        NSW2
au3_sort        NSW1
au4_sort        NSW1
au5_sort        SA
au6_sort        SA
au7_sort        VIC
au8_sort        VIC
au9_sort        WA
au11_sort       WA
au10_sort       NSW2
au13_sort       WA
au12_sort       NSW1
au14_sort       NSW2

# -----------R
module load R/3.5.1
R

setwd("/srv/scratch/z5188231/AustralianStarlings-Sept18/Starling_combine_data/environment")

div <- read.csv("AUstarlings_window10kb_300_state.csv", sep=",")

div <- data.frame(div)

#select outliers
div.outliers <- div[which(div$Fst_NSW1_NSW2 > 0.05 | div$Fst_NSW1_VIC > 0.05 | div$Fst_NSW1_SA > 0.05 | div$Fst_NSW1_WA > 0.05 | div$Fst_NSW2_VIC > 0.05 | div$Fst_NSW2_SA > 0.05| div$Fst_NSW2_WA > 0.05 | div$Fst_VIC_SA > 0.05 | div$Fst_VIC_WA > 0.05 | div$Fst_SA_WA > 0.05),] # 0.05 is threshold

write.csv(div.outliers, "AUstarlings_window10kb_300_state_outliers.csv")

# copy columns 2 and 3 from .csv output above to make bed file, check column headers

div.outliers.2column <- div.outliers[,2:4]
div.outliers.2column <- data.frame(div.outliers.2column)
write.csv(div.outliers.2column, "AUstarlings_window10kb_300_state_outliers_2column.csv")
# manually removed the first column because fuck this. final file AUstarlings_window10kb_300_state_outliers_3column.bed - make sure tab deliminated

# -------NO MORE R

# then go back to cluster and run these lines 
vcftools --vcf AUstarlings.vcf --bed AUstarlings_window10kb_300_state_outliers_2column.bed --recode --out AUstarlings_outliers
vcftools --vcf AUstarlings_outliers2.vcf --max-missing 1 --recode --out AUstarlings_outliers2.nomiss
vcftools --vcf AUstarlings_outliers2.nomiss.vcf --012 --out AUstarlings_outliers2_012.nomiss
  



#Select a sample and restrict the output vcf to a set of intervals:     
module load java/8u91

alias java='java -Xmx48g'  
export _JAVA_OPTIONS="-Xmx48g"
java -XshowSettings:vm 

java -Xmx48g -jar GenomeAnalysisTK.jar \
	-R Svulgaris_genomic.fna \
	-T SelectVariants \
	--variant AUstarlings.vcf \
	-o AUstarlings_outliers.vcf \
	-L AUstarlings_window50kb_300_state_outliers_3column.bed

  java -Xmx48g -jar GenomeAnalysisTK.jar -T VariantFiltration -R Svulgaris_genomic.fna \
--variant AUstarlings.vcf -o AUstarlings_filtered.vcf \
--filterExpression "QD<2.0||FS>60.0||MQ<40.0||SOR>3.0" --filterName "first_snp_filter"

  # for a simple first run of RDA, all you need to do is add .csv to the extension and the code should run (no column or row names)
  # to add in row/column names and actually get predictors, I only used row names in column 1 that exactly match the sample order in the VCF above
  # I use vim to add names, but it makes me nervous every time because it’s so easy to mess up… file’s just too big :( 
  


I didn’t filter the input SNPs by MAF or anything else before looking for outliers. Bayescan is great but will probably take many weeks to run… it’s slow and that’s why I’m not using it, also it’s really just spitting out posterior probabilities of FST estimates in a clunky software without using contextual information in the genome (and I don’t trust it v much for starlings since they’re so low divergence)
I used a simple one-liner in R to get SNPs with an Fst > 5 SD above mean genome-wide FST
Then I made a BED file with all the outlier windows (which is a simple text file, screenshot of first few lines attached!)
Finally, I made a new VCF file including only positions covered by this BED file

So I copied in the genetic script (below), and then realized it probably has to do with your environment file: have you pulled the bioclim values for the lat/long coordinates and stored them in pred? You mentioned that you’re running the data file of the lat/long coords—which is the only “environmental” input to R, but within R you can then pull the bioclim explanatory variables (in the PREP block of the starlingGEA.R code, which I’m re-attaching since I’ve updated it and I think you may be working from the RADseq version I used).



#below working in regular katana. submit as script????


EUSTreseq.window50kb.300.csv







2018-09-27--------------------------------------------------------------[FastStructure]

# You can retrieve the source code for fastStructure using wget by doing the following:
wget --no-check-certificate https://github.com/rajanil/fastStructure/archive/master.tar.gz

# Unzip fastStructure
tar xzvf master.tar.gz

# Dependencies to install: numpty, Scipy, Cython, GNU Scientific Library (GSL)

#already on katana
module load git/2.7.1
module load gsl/2.1


module load python/2.7.15 #contains NumPy, SciPy, and Cython

https://www.hpc.science.unsw.edu.au/about/python


# BUILDING PYTHON EXTENSION
# 1. identify the path to the library files libgsl.so, libgslcblas.so, and header file gsl/gsl_sf_psi.h (GSL)
# 2. add below lines to your .bashrc file on your home directory.
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/share/apps/gsl/2.1/lib
export CFLAGS="-I/share/apps/gsl/2.1/include"
export LDFLAGS="-L/share/apps/gsl/2.1/lib"


# run to set up environmental variables
# ????Do I need to do this each time?
source ~/.bashrc

# To build library extensions, you can do the following:
cd /srv/scratch/z5188231/AustralianStarlings-Sept18/FastStructure/vars
python setup.py build_ext --inplace

# To compile the main cython scripts, you can do the following:
cd fastStructure
python setup.py build_ext --inplace

# testdata 
python structure.py -K 3 --input=test/testdata --output=test/testoutput_simple --full --seed=100











