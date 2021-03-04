# ####tpcb
# #SSS
# sed -i 's/export PGDATABASE=template1/export PGDATABASE=tpcbsss/' ~/.bash_profile
# source ~/.bash_profile
# mkdir -p /home/gpadmin/data/con
# number_of_threads=(8 16 32 64 128 256 512)
# for var in ${number_of_threads[@]}
# do
#     dstat --output /home/gpadmin/data/con/tpcb-sss-$var-onpgbench.csv 2>&1 >/dev/null &
#     pgbench -c $var -j $var -r -T 60 -P 1 -n >> /home/gpadmin/data/con/tpcb-res-sss.txt
#     kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
# done
# gpstop -M immediate -a -r

#SS
# sed -i 's/export PGDATABASE=tpcbsss/export PGDATABASE=tpcbss/' ~/.bash_profile
# source ~/.bash_profile

# number_of_threads=(8 16 32 64 128 256 512)
# for var in ${number_of_threads[@]}
# do
#     dstat --output /home/gpadmin/data/con/tpcb-ss-$var-onpgbench.csv 2>&1 >/dev/null &
#     pgbench -c $var -j $var -r -T 60 -P 1 -n >> /home/gpadmin/data/con/tpcb-res-ss.txt
#     kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
#     sleep 30
# done
# gpstop -M immediate -a -r

# #casual
# sed -i 's/export PGDATABASE=tpcbss/export PGDATABASE=tpcbcasual/' ~/.bash_profile
# source ~/.bash_profile

# number_of_threads=(8 16 32 64 128 256 512)
# for var in ${number_of_threads[@]}
# do
#     dstat --output /home/gpadmin/data/con/tpcb-crr-$var-onpgbench.csv 2>&1 >/dev/null &
#     pgbench -c $var -j $var -r -T 60 -P 1 -n >> /home/gpadmin/data/con/tpcb-res-casual.txt
#     kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')

# done
# gpstop -M immediate -a -r

# sed -i 's/export PGDATABASE=tpcbcasual/export PGDATABASE=template1/' ~/.bash_profile
# source ~/.bash_profile

# ####select
# #SSS
# sed -i 's/export PGDATABASE=template1/export PGDATABASE=tpcbsss/' ~/.bash_profile
# source ~/.bash_profile
# mkdir -p /home/gpadmin/data/con
# number_of_threads=(8 16 32 64 128 256 512)
# for var in ${number_of_threads[@]}
# do
#     dstat --output /home/gpadmin/data/con/select-sss-$var-onpgbench.csv 2>&1 >/dev/null &
#     pgbench -c $var -j $var -r -T 60 -S -P 1 -n >> /home/gpadmin/data/con/select-res-sss.txt
#     kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')

# done
# gpstop -M immediate -a -r

#SS
# sed -i 's/export PGDATABASE=tpcbsss/export PGDATABASE=tpcbss/' ~/.bash_profile
# source ~/.bash_profile

# number_of_threads=(8 16 32 64 128 256 512)
# for var in ${number_of_threads[@]}
# do
#     dstat --output /home/gpadmin/data/con/select-ss-$var-onpgbench.csv 2>&1 >/dev/null &
#     pgbench -c $var -j $var -r -T 60 -S -P 1 -n >> /home/gpadmin/data/con/select-res-ss.txt
#     kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
# done
# gpstop -M immediate -a -r

# #casual
# sed -i 's/export PGDATABASE=tpcbss/export PGDATABASE=tpcbcasual/' ~/.bash_profile
# source ~/.bash_profile

# number_of_threads=(8 16 32 64 128 256 512)
# for var in ${number_of_threads[@]}
# do

#     dstat --output /home/gpadmin/data/con/select-crr-$var-onpgbench.csv 2>&1 >/dev/null &
#     pgbench -c $var -j $var -r -T 60 -S -P 1-n >> /home/gpadmin/data/con/select-res-casual.txt
#     kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')

# done
# gpstop -M immediate -a -r

# sed -i 's/export PGDATABASE=tpcbcasual/export PGDATABASE=template1/' ~/.bash_profile
# source ~/.bash_profile

####update
#SSS
sed -i 's/export PGDATABASE=template1/export PGDATABASE=tpcbsss/' ~/.bash_profile
source ~/.bash_profile
mkdir -p /home/gpadmin/data/con
number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /home/gpadmin/data/con/update-sss-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -P 1 -f ../../contrib/pgbench/sysbench/update-only.sql -n >> /home/gpadmin/data/con/update-res-sss.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
done
gpstop -M immediate -a -r

#SS
sed -i 's/export PGDATABASE=tpcbsss/export PGDATABASE=tpcbss/' ~/.bash_profile
source ~/.bash_profile

number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /home/gpadmin/data/con/update-ss-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -P 1 -f ../../contrib/pgbench/sysbench/update-only.sql -n >> /home/gpadmin/data/con/update-res-ss.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')
done
gpstop -M immediate -a -r

#casual
sed -i 's/export PGDATABASE=tpcbss/export PGDATABASE=tpcbcasual/' ~/.bash_profile
source ~/.bash_profile

number_of_threads=(8 16 32 64 128 256 512)
for var in ${number_of_threads[@]}
do
    dstat --output /home/gpadmin/data/con/update-crr-$var-onpgbench.csv 2>&1 >/dev/null &
    pgbench -c $var -j $var -r -T 60 -P 1 -f ../../contrib/pgbench/sysbench/update-only.sql -n >> /home/gpadmin/data/con/update-res-casual.txt
    kill -9 $(ps -aux | grep dstat | grep -v grep | grep -v bash | awk '{print $2}')

done
gpstop -M immediate -a -r

sed -i 's/export PGDATABASE=tpcbcasual/export PGDATABASE=template1/' ~/.bash_profile
source ~/.bash_profile
