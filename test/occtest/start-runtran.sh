#focc
sed -i 's/export PGDATABASE=template1/export PGDATABASE=tpcbocc/' ~/.bash_profile
source ~/.bash_profile

number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /home/gpadmin/tpcb-occ-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -n >> /home/gpadmin/tpcb-res-focc.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
    sleep 30
done
gpstop -M immediate -a -r 

#bocc
sed -i 's/export PGDATABASE=tpcbocc/export PGDATABASE=tpcbbocc/' ~/.bash_profile
source ~/.bash_profile

number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /home/gpadmin/tpcb-bocc-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -n >> /home/gpadmin/tpcb-res-bocc.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
    sleep 30
done
gpstop -M immediate -a -r 

#rucc
sed -i 's/export PGDATABASE=tpcbbocc/export PGDATABASE=tpcbrucc/' ~/.bash_profile
source ~/.bash_profile

number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /home/gpadmin/tpcb-rucc-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -n >> /home/gpadmin/tpcb-res-rucc.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
    sleep 30
done
gpstop -M immediate -a -r 

#
sed -i 's/export PGDATABASE=tpcbrucc/export PGDATABASE=template1/' ~/.bash_profile
source ~/.bash_profile
