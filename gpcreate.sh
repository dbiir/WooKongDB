#!/usr/bin/env bash


gptmp=$GPCOMPILE
echo 'We are going to create gpdb group from the code under '$gptmp','

echo 'Deploying demo cluster...'
#gpdeletesystem -f
rm -rf $GPMASTER
rm -rf /tmp/.s.PGSQL.*
for seg in gp-seg1 gp-seg2 gp-seg3
do
    ssh $seg rm -rf $GPPRIMARYHOME/gpseg*
    ssh $seg rm -rf /tmp/.s.PGSQL.*
done

gpinitsystem -c $GPINIT/gpinitsystem_config -a
source $gptmp/gpAux/gpdemo/gpdemo-env.sh
echo 'Demo cluster has been deployed and started.'


exit 0

