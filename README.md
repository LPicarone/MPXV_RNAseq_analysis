# MPXV_RNAseq_analysis
scripts for RNA-seq analysis of MPXV gene expression across time points and cell lines.

## Pipeline overview
The repository contains SLURM/bash scripts used for:
1) FastQC quality control
2) Trimmomatic trimming
3) STAR mapping (sorted BAM output)
4) featureCounts quantification

## Repository structure
- `scripts/`: SLURM job scripts for each step
- `run_pipeline.sh`: helper script to submit pipeline steps in order (optional)

## How to run
Edit the variables in each script (InputDir / OutputDir / index / GTF) and submit jobs on SLURM, e.g.:

```bash
sbatch scripts/01_fastqc.slurm.sh
sbatch scripts/02_trimming.slurm.sh
sbatch scripts/03_star_mapping.slurm.sh
sbatch scripts/04_featurecounts.slurm.sh
