#!/bin/bash -x
#PBS -N 25M
#PBS -l nodes=1:ppn=16
#PBS -l walltime=24:00:00
#PBS -V
#PBS -m abe
#PBS -M jwschwab@ucsc.edu

if [ -n "${PBS_O_WORKDIR}" ]; then
   cd ${PBS_O_WORKDIR}
   module load mesasdk/20190315
   export MESA_DIR=/pfs/jschwab/mesa-svn-test
   export OMP_NUM_THREADS=16
fi

# rebuild MESA
./clean
./mk

# link 
ln -sf inlist_rHEAD inlist_case

# run MESA and record
./rn > rn.out
grep "WARNING (ELM)" > elm.warn

# link
ln -sf inlist_cubicX inlist_case

# run MESA
./rn

