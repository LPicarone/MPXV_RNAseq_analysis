#!/bin/bash
#SBATCH -N1 --ntasks-per-node=1 --cpus-per-task=8 --mem=100GB
#SBATCH --time=06:00:00
#SBATCH --job-name STAR_mapping
#SBATCH --partition=partition
#SBATCH --output=star_mapping.out
#SBATCH --error=star_mapping.err
##SBATCH --account=YOUR_ACCOUNT

module load profile/bioinf
module load gnu/10.2.0--gcc--8.3.1
module load autoload star/2.7.9a

InputDir="data"
OutputDir="results/STAR_mapping"
index="genome/STAR_index_combined"
THREADS=8


mkdir -p "$OutputDir"

for file in "$InputDir/"*1_paired.fastq; do
    file_basename=$(basename "$file")
    file_prefix="${file_basename%*1_paired.fastq}"
    file2="$InputDir/${file_prefix}2_paired.fastq"

    STAR --runThreadN "$THREADS" \
      --genomeDir "$index" \
      --readFilesIn "$file" "$file2" \
      --outSAMtype BAM SortedByCoordinate \
      --outFileNamePrefix "$OutputDir/${file_prefix}" \
      --alignEndsProtrude 25 ConcordantPair
done
