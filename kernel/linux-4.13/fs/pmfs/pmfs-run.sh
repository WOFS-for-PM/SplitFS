#!/bin/bash
WORKLOAD="/home/sekwon/strata/bench/filebench/rohan"
RESULTS="/home/sekwon/strata/bench/filebench/results"
FILEBENCH="/home/sekwon/filebench-rohan"

echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
sudo rm -rf /mnt/pmem0/*
sudo umount /mnt/pmem0
sudo insmod pmfs.ko
sudo mount -t pmfs -o init /dev/pmem0 /mnt/pmem0

#Fileserver
for i in {1..5}
do
    sudo ${FILEBENCH}/filebench -f ${WORKLOAD}/fileserver/fileserver${i}.f \
        >> ${RESULTS}/$1/pmfs/file_${i}.txt
    sudo rm -rf /mnt/pmem0/*
    sudo umount /mnt/pmem0
    sudo mount -t pmfs -o init /dev/pmem0 /mnt/pmem0
done

#Varmail
for i in {1..5}
do
    sudo ${FILEBENCH}/filebench -f ${WORKLOAD}/varmail/varmail${i}.f \
        >> ${RESULTS}/$1/pmfs/var_${i}.txt
    sudo rm -rf /mnt/pmem0/*
    sudo umount /mnt/pmem0
    sudo mount -t pmfs -o init /dev/pmem0 /mnt/pmem0
done

#Webserver_500
for i in {1..5}
do
    sudo ${FILEBENCH}/filebench -f ${WORKLOAD}/webserver/500/webserver${i}.f \
        >> ${RESULTS}/$1/pmfs/web_500_${i}.txt
    sudo rm -rf /mnt/pmem0/*
    sudo umount /mnt/pmem0
    sudo mount -t pmfs -o init /dev/pmem0 /mnt/pmem0
done

#Webserver_1000
#for i in {1..5}
#do
#    sudo ${FILEBENCH}/filebench -f ${WORKLOAD}/webserver/1000/webserver${i}.f \
#        >> ${RESULTS}/$1/pmfs/web_1000_${i}.txt
#    sudo rm -rf /mnt/pmem0/*
#    sudo umount /mnt/pmem0
#    sudo mount -t pmfs -o init /dev/pmem0 /mnt/pmem0
#done
