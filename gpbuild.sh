#!/usr/bin/env bash


gpsrc=$GPSRC
echo 'We are going to build gpdb from the source code under '$gpsrc','
echo 'If this is not correct, please set the right path for gpsrc in gpbuild.sh'
gptmp=$GPCOMPILE
gpbin=$GPBIN


while getopts ":d:b:" opts; do
    case $opts in
        d) deploy=$OPTARG ;;
		b) debug=$OPTARG ;;
        ?) ;;
    esac
done


gpstate=$(gpstate | grep "Master instance")

if [[ $gpstate =~ "Active" ]]
then
  echo 'gp is running, try to stop it...'
  sleep 5
  gpstop -a
fi

if [ "$gpsrc"x = "$gptmp"x ]
then
	echo 'do not copy code from $gpsrc to $gptmp...'
else
	echo 'copy code from $gpsrc to $gptmp...'
	rm -f $gptmp/gpAux/gpdemo/demo_cluster.sh
	rm -rf $gptmp/src
	#rm -rf $gptmp/tdsqlcontrib
	rm -f $gptmp/GNUmakefile.in
	cp $gpsrc/gpAux/gpdemo/demo_cluster.sh $gptmp/gpAux/gpdemo/
	cp -r $gpsrc/src $gptmp/
	#cp -r $gpsrc/tdsqlcontrib $gptmp/
	cp $gpsrc/GNUmakefile.in $gptmp/GNUmakefile.in
	#cp $gpsrc/depends/paxosportconfigure $gptmp/depends
fi
cd $gptmp

if [ $debug = "y" -o $debug = "Y" ]
then
  echo "compile in debug mode."
  ./configure --prefix=$gpbin --with-perl --with-gssapi --with-python --with-libxml --with-includes=/usr/include --enable-debug --enable-cassert --disable-orca --without-zstd CFLAGS='-O0 -g' --enable-dtrace
else
  echo "compile in release mode."
  ./configure --prefix=$gpbin --with-perl --with-gssapi --with-python --with-libxml --with-includes=/usr/include --disable-cassert --disable-orca --disable-pxf --disable-gpfdisk --without-zstd CFLAGS='-O3' CXXFLAGS='-O3'
fi
# if you get a link error: undefined reference to dlopen, try the below command:
# ./configure --prefix=$gpbin --with-perl --with-python --with-libxml --disable-orca --disable-cassert --disable-pxf --disable-gpfdist CFLAGS='-O3 -fno-strict-aliasing -ldl' CXXFLAGS='-O3 -fno-strict-aliasing -ldl'
sed -i 's/LIBS = -lbz2 -lxml2 -lrt -lgssapi_krb5 -lz -lreadline -lrt -lcrypt -ldl -lm  -lcurl/LIBS = -lstdc++ -lprotobuf -lrocksdb -lbz2 -lxml2 -lrt -lgssapi_krb5 -lz -lreadline -lrt -lcrypt -ldl -lm -lcurl -lzstd -llz4 -lsnappy -lpthread/g' ./src/Makefile.global
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
  source $gptmp/gpAux/gpdemo/gpdemo-env.sh
  echo 'Demo cluster has been deployed and started.'
else
  echo 'gpdb has been built and installed, you may want to start it with: gpstart'
fi

exit 0
