#echo host    all     all     0.0.0.0/0       trust >> /home/gpadmin/penguindb/gpdata/gpmaster/gpseg-1/pg_hba.conf

psql penguindb << EOF
    ALTER USER gpadmin WITH PASSWORD 'gpadmin';
    ALTER DATABASE penguindb SET default_transaction_isolation = 'repeatable read';
    DROP DATABASE tpccocc;
    DROP USER tpccocc;
EOF

mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp_old.tcl

cp /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/heap_rocksdb/pgoltpheap.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/

mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltpheap.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl

echo "BASH SCRIPT BEFORE BUILD.."
cd /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/
./hammerdbcli <<!
source /home/gpadmin/penguindb/gpdb/test/heap_rocksdb/build_heap256.tcl
!
echo "BASH SCRIPT AFTER BUILD.."

cd /home/gpadmin/penguindb/gpdb/test/heap_rocksdb

rm -rf /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl

cp /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/heap_rocksdb/pgoltprocksdb.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/

mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltprocksdb.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl

echo "BASH SCRIPT BEFORE BUILD.."
cd /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/
./hammerdbcli <<!
source /home/gpadmin/penguindb/gpdb/test/heap_rocksdb/build_rocksdb256.tcl
!
echo "BASH SCRIPT AFTER BUILD.."

cd /home/gpadmin/penguindb/gpdb/test/heap_rocksdb
rm -rf /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl
mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp_old.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl
