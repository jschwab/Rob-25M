#!/bin/bash -x
#PBS -N 1M_pre_ms_to_wd
#PBS -l nodes=1:ppn=16
#PBS -l walltime=24:00:00
#PBS -V
#PBS -m abe
#PBS -M jwschwab@ucsc.edu

if [ -n "${PBS_O_WORKDIR}" ]; then
   cd ${PBS_O_WORKDIR}
   module load mesasdk/20190315
   export MESA_DIR=/pfs/jschwab/mesa-r11554
   export OMP_NUM_THREADS=16
fi

# rebuild MESA
./clean
./mk

# link 
ln -sf inlist_r11554 inlist_case

export MESA_CACHES_DIR=/dev/shm

# run MESA
./rn

# link 
ln -sf inlist_noELM inlist_case

# run MESA
./rn
