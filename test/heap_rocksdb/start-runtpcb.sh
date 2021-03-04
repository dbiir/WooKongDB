psql penguindb << EOF
    ALTER DATABASE tpcbrocksdb SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpcbheap SET default_transaction_isolation = 'repeatable read';
EOF

sed -i 's/export PGDATABASE=template1/export PGDATABASE=tpcbrocksdb/' ~/.bash_profile
source ~/.bash_profile

number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /data1/gptest/tpcb-rocksdb-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -n >> /data1/gptest/tpcb-res-rocksdb.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
    sleep 30
done

gpstop -M immediate -a -r 

sed -i 's/export PGDATABASE=tpcbrocksdb/export PGDATABASE=tpcbheap/' ~/.bash_profile
source ~/.bash_profile

number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /data1/gptest/tpcb-heap-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -n -d tpcbheap >> /data1/gptest/tpcb-res-heap.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
    sleep 30
done

sed -i 's/export PGDATABASE=tpcbheap/export PGDATABASE=template1/' ~/.bash_profile
source ~/.bash_profile