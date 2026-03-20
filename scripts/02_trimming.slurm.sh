#!/bin/bash
#SBATCH -N1 --ntasks-per-node=1 --cpus-per-task=8 --mem=50GB
#SBATCH --time=09:00:00
#SBATCH --job-name trimming
#SBATCH --partition=partition
#SBATCH --output=trimm.out
#SBATCH --error=trimm.err
##SBATCH --account=YOUR_ACCOUNT

module load profile/bioinf
module load autoload trimmomatic/0.39

########## VARIABLES ##########
InputDir="data"
OutputDir="results/Trimmed_02"
THREADS=8
###########################################

mkdir -p "$OutputDir"

for file in "$InputDir/"*1_001.fastq.gz; do
    file_basename=$(basename "$file")
    file_prefix="${file_basename%*1_001.fastq.gz}"
    file2="$InputDir/${file_prefix}2_001.fastq.gz"

    java -jar $TRIMMOMATIC_HOME/bin/trimmomatic-0.39.jar PE \
      -phred33 -threads "$THREADS" \
      -trimlog "$OutputDir/${file_prefix}_trim.log" \
      "$file" "$file2" \
      "$OutputDir/${file_prefix}1_paired.fastq" "$OutputDir/${file_prefix}1_unpaired.fastq" \
      "$OutputDir/${file_prefix}2_paired.fastq" "$OutputDir/${file_prefix}2_unpaired.fastq" \
      ILLUMINACLIP:$TRIMM_ADAPTERS/NexteraPE-PE.fa:2:30:10 \
      HEADCROP:15 SLIDINGWINDOW:4:20 LEADING:20 TRAILING:20 \
      MINLEN:50 AVGQUAL:25
done
