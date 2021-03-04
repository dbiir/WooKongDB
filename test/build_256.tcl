#!/bin/tclsh
puts "SETTING CONFIGURATION"

set i 1
set USERNAME [index $argv $i]
set i 2
set HOST [index $argv $i]
set i 3
set PORT [index $argv $i]
set i 4
set USEDATABASE [index $argv $i]

global complete
proc wait_to_complete {} {
global complete
set complete [vucomplete]
if {!$complete} {after 100000 wait_to_complete} else { exit }
}

dbset db pg
dbset bm TPC-C
diset connection pg_host $HOST
diset connection pg_port $PORT

diset tpcc pg_count_ware 128
diset tpcc pg_num_vu 64
diset tpcc pg_superuser $USERNAME
diset tpcc pg_superuserpass $USERNAME
diset tpcc pg_defaultdbase template1
diset tpcc pg_user $USEDATABASE
diset tpcc pg_pass $USEDATABASE
diset tpcc pg_dbase $USEDATABASE
vuset logtotemp 1
vuset unique 1
diset tpcc pg_rampup 2
diset tpcc pg_duration 3
buildschema

wait_to_complete
vudestroy