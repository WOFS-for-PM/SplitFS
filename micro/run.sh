#!/usr/bin/env bash
cur_dir=`readlink -f .`
splitfs_dir=`readlink -f ../splitfs`
export LEDGER_YCSB=1
export LEDGER_DATAJ=1
export LEDGER_POSIX=0
cd $splitfs_dir; make clean; make; # Compile SplitFS
export LD_LIBRARY_PATH=$splitfs_dir
export NVP_TREE_FILE=$splitfs_dir/bin/nvp_nvp.tree


cd $cur_dir
sudo bash dax_config.sh
pwd
LD_PRELOAD=$splitfs_dir/libnvp.so ./rw_expt write seq 4096
rm -rf /mnt/pmem0/*