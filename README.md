# Miscellaneous vsc4 scripts

Here is a collection of scripts I used on the vsc4 and vsc5:
- `job_RAW.sh`: Blueprint for starting a slurm job by compiling NIRVANA and other miscellaneous operations.
- `scr_caivs`: Interactive script to run CAIVS data conversion.
- `scr_check_progress.sh`: Interactive script to check the end of a nirvana.log file.
- `get_results.sh`: Interactive script to generate a temporary folder for CAIVS transformations while simulation is still running.
- `scr_monitoring.sh`: Monitors all processes running under my user-id on vsc4 (updates every second until cancelled).
- `scr_nodeusage.sh`: Monitors all processes running from the users on the Star/Planet group nodes (not continuous).

  The folder `vsc5_jobscript_templates` stores templates for starting slurm jobs for:
  - JexoSim
  - TauREx (CUDA-bound)
