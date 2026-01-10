#!/bin/bash
#SBATCH -N1 --ntasks-per-node=1 --cpus-per-task=8 --mem=100GB
#SBATCH --time=02:00:00
#SBATCH --job-name FeatureCounts
#SBATCH --partition=
#SBATCH --output=FeatureCounts.out
#SBATCH --error=FeatureCounts.err
##SBATCH --account=YOUR_ACCOUNT

GTF="genome/GCF_014621545.1_ASM1462154v1_genomic.gtf"
BAM_DIR="results/STAR_mapping"
OUTDIR="results/featurecounts_results"
THREADS=8


# If you use conda, keep this:
source ~/miniconda3/etc/profile.d/conda.sh
conda activate /path/to/your/conda/envs/subread

mkdir -p "$OUTDIR"

featureCounts -p --countReadPairs -t CDS -g locus_tag \
  -a "$GTF" \
  -T "$THREADS" \
  -o "$OUTDIR/viral.gene.featurecounts.txt" \
  "$BAM_DIR"/*.bam
