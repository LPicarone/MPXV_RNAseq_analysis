#!/bin/bash
#SBATCH -N1 --ntasks-per-node=1 --cpus-per-task=4 --mem=20GB
#SBATCH --time=01:30:00
#SBATCH --job-name fastqc
#SBATCH --partition=partition
#SBATCH --output=fastqc.out
#SBATCH --error=fastqc.err
##SBATCH --account=YOUR_ACCOUNT

module load profile/bioinf
module load autoload fastqc/0.11.9

########## VARIABLES (EDIT THESE) ##########
InputDir="data"
OutputDir="results/FastQC_01"
THREADS=4
###########################################

mkdir -p "$OutputDir"

# your original had "*fastqc.gz" but likely it's "*fastq.gz"
fastqc -o "$OutputDir" -t "$THREADS" --nogroup "$InputDir"/*.fastq.gz
