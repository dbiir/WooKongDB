#!/bin/tclsh
puts "SETTING CONFIGURATION"

global complete
proc wait_to_complete {} {
    global complete
    set complete [vucomplete]
    if {!$complete} {
        after 1000 wait_to_complete
    } else {
        exit
    }
}

dbset db pg
dbset bm TPC-C
diset connection pg_host 127.0.0.1
diset connection pg_port 15432

diset tpcc pg_count_ware 128
diset tpcc pg_num_vu 64
diset tpcc pg_superuser gpadmin
diset tpcc pg_superuserpass gpadmin
diset tpcc pg_defaultdbase template1
diset tpcc pg_user tpccheap
diset tpcc pg_pass tpccheap
diset tpcc pg_dbase tpccheap
vuset logtotemp 1
vuset unique 1
diset tpcc pg_rampup 1
diset tpcc pg_duration 1
buildschema

wait_to_complete
vudestroy
