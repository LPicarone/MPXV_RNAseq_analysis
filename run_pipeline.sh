#!/bin/bash
set -e

echo "Submitting pipeline jobs..."

sbatch scripts/01_fastqc.slurm.sh
sbatch scripts/02_trimming.slurm.sh
sbatch scripts/03_star_mapping.slurm.sh
sbatch scripts/04_featurecounts.slurm.sh

echo "Done."
