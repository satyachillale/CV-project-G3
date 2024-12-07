#!/bin/bash

## change the last two digits to your team id
#SBATCH --account=csci_ga_2572_002-2024sp-18

## change the partition number to use different number of GPUs
##SBATCH --partition=n1s8-v100-1
##SBATCH --gres=gpu:v100:1
##SBATCH --cpus-per-task=8

#SBATCH --partition=n1s16-v100-2
#SBATCH --gres=gpu:v100:2
#SBATCH --cpus-per-task=16

##SBATCH --partition=n1c24m128-v100-4
##SBATCH --gres=gpu:4
##SBATCH --cpus-per-task=24

#SBATCH --time=10:00:00
#SBATCH --output=cvprojectg3_%j.out
#SBATCH --error=cvprojectg3_%j.err
#SBATCH --exclusive
#SBATCH --requeue

singularity exec --nv \
            --bind /scratch/sc9960/cv_project/g3-variant/code/CV-project-G3 \
            --overlay /scratch/sc9960/cv_project/g3-variant/singularity-image/g3-gg.ext3 \
            /scratch/work/public/singularity/cuda12.1.1-cudnn8.9.0-devel-ubuntu22.04.2.sif \
            /bin/bash -c "source /ext3/env.sh; accelerate launch --multi_gpu --num_processes 2 run_G3.py"