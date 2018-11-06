#!/bin/bash
 #SBATCH --mail-type=ALL 			# Mail events (NONE, BEGIN, END, FAIL, ALL)
 #SBATCH --mail-user=austin.kern@uconn.edu	# Your email address
 #SBATCH --ntasks=1				# Run a single serial task
 #SBATCH --cpus-per-task=1     # Number of cores to use
 #SBATCH --mem=2096mb				# Memory limit
 #SBATCH --time=2:00:00				# Time limit hh:mm:ss
 #SBATCH -e error_retest.log				# Standard error
 #SBATCH -o output_retest.log				# Standard output
 #SBATCH --job-name=retest		# Descriptive job name
 #SBATCH --partition=serial

 module load singularity

 cd /scratch/psyc5171/amk14002/hw-groupanalysis1
 singularity run /scratch/psyc5171/containers/burc-lite.img \
 /scratch/psyc5171/amk14002/hw-groupanalysis1/scripts/results.sh