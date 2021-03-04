mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp_old.tcl

cp /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/occ/pgoltprucc.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/

mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltprucc.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl

psql penguindb << EOF
    ALTER DATABASE tpccrucc SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpccrucc SET transam_mode = 'occ';
EOF

echo "BASH SCRIPT BEFORE RUN.."
cd /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/
./hammerdbcli <<!>> /home/gpadmin/penguindb/gpdb/test/run-occ.output 2>&1
source /home/gpadmin/penguindb/gpdb/test/occtest/runvu_rucc256.tcl
!
echo "BASH SCRIPT AFTER RUN.."

gpstop -a -M immediate -r

# psql penguindb << EOF
#     ALTER DATABASE tpccrucc SET default_transaction_isolation = 'repeatable read';
#     ALTER DATABASE tpccrucc SET transam_mode = 'docc';
# EOF

# echo "BASH SCRIPT BEFORE RUN.."
# cd /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/
# ./hammerdbcli <<!>> /home/gpadmin/penguindb/gpdb/test/run-bocc.output 2>&1
# source /home/gpadmin/penguindb/gpdb/test/occtest/runvu_rucc256.tcl
# !
# echo "BASH SCRIPT AFTER RUN.."

# gpstop -a -M immediate -r

# psql penguindb << EOF
#     ALTER DATABASE tpccrucc SET default_transaction_isolation = 'repeatable read';
#     ALTER DATABASE tpccrucc SET transam_mode = 'rucc';
# EOF

# echo "BASH SCRIPT BEFORE RUN.."
# cd /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/
# ./hammerdbcli <<!>> /home/gpadmin/penguindb/gpdb/test/run-rucc.output 2>&1
# source /home/gpadmin/penguindb/gpdb/test/occtest/runvu_rucc256.tcl
# !
# echo "BASH SCRIPT AFTER RUN.."

# cd /home/gpadmin/penguindb/gpdb/test/heap_rocksdb
# rm -rf /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl
# mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp_old.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl
