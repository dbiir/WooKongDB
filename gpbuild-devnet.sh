#!/usr/bin/env bash


gpsrc=$HOME/gpdb
echo 'We are going to build gpdb from the source code under '$gpsrc','
echo 'If this is not correct, please set the right path for gpsrc in gpbuild.sh'
#gptmp=$HOME/penguindb/gpdb-tmp
gpbin=$HOME/penguindb/gpdb-bin


while getopts ":d:" opts; do
    case $opts in
        d) deploy=$OPTARG ;;
        ?) ;;
    esac
done


gpstate=$(gpstate | grep "Master instance")

if [[ $gpstate =~ "Active" ]]
then
  echo 'gp is running, try to stop it...'
  sleep 5
  gpstop -M immediate
fi


#rm -f $gptmp/gpAux/gpdemo/demo_cluster.sh
#rm -rf $gptmp/src
##rm -rf $gptmp/tdsqlcontrib
#rm -f $gptmp/GNUmakefile.in
#cp $gpsrc/gpAux/gpdemo/demo_cluster.sh $gptmp/gpAux/gpdemo/
#cp -r $gpsrc/src $gptmp/
##cp -r $gpsrc/tdsqlcontrib $gptmp/
#cp $gpsrc/GNUmakefile.in $gptmp/GNUmakefile.in
cd $gpsrc
./configure --prefix=$gpbin --with-perl --with-gssapi --with-python --with-libxml --with-includes=/usr/local/include --enable-debug --enable-cassert --disable-orca --without-zstd --enable-profile --enable-dtrace CFLAGS='-O0 -g'
#./configure --prefix=$gpbin --with-perl --with-gssapi --with-python --with-libxml --with-includes=/usr/local/include --enable-debug --enable-cassert --disable-orca --without-zstd CFLAGS='-O0 -g'
# echo 'LIBS += -lzstd -llz4 -lsnappy -lpthread -lprotobuf -lrocksdb' >> ./src/Makefile.global
sed -i 's/LIBS = -lbz2 -lxml2 -lrt -lgssapi_krb5 -lz -lreadline -lrt -lcrypt -ldl -lm  -lcurl/LIBS = -lbz2 -lxml2 -lrt -lgssapi_krb5 -lz -lreadline -lrt -lcrypt -ldl -lm  -lcurl  -lzstd -llz4 -lsnappy -lpthread -lprotobuf -lrocksdb/g' ./src/Makefile.global
# > ./src/Makefile.global.bk
#mv ./src/Makefile.global.bk ./src/Makefile.global
make -j4
make -j4 install
source $gpbin/greenplum_path.sh


if [ $deploy = "y" -o $deploy = "Y" ]
then
  echo 'Deploying demo cluster...'
  sleep 5
  make destroy-demo-cluster
  make create-demo-cluster
  source $gpsrc/gpAux/gpdemo/gpdemo-env.sh
  echo 'Demo cluster has been deployed and started.'
else
  echo 'gpdb has been built and installed, you may want to start it with: gpstart'
fi


exit 0

