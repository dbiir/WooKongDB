mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp_old.tcl

cp /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/heap_rocksdb/pgoltpheap.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/

mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltpheap.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl


echo "BASH SCRIPT BEFORE RUN.."
cd /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/
./hammerdbcli <<!>> /home/gpadmin/penguindb/gpdb/test/run-heap.output 2>&1
source /home/gpadmin/penguindb/gpdb/test/heap_rocksdb/runvu_heap256.tcl
!

echo "BASH SCRIPT AFTER RUN.."

cd /home/gpadmin/penguindb/gpdb/test/heap_rocksdb

rm -rf /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl

cp /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/heap_rocksdb/pgoltprocksdb.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/

mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltprocksdb.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl


echo "BASH SCRIPT BEFORE RUN.."
cd /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/
./hammerdbcli <<!>> /home/gpadmin/penguindb/gpdb/test/run-rocksdb.output 2>&1
source /home/gpadmin/penguindb/gpdb/test/heap_rocksdb/runvu_rocksdb256.tcl
!

echo "BASH SCRIPT AFTER RUN.."
cd /home/gpadmin/penguindb/gpdb/test/heap_rocksdb
rm -rf /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl
mv /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp_old.tcl /home/gpadmin/penguindb/gpdb/contrib/pgbench/HammerDB-3.1/src/postgresql/pgoltp.tcl
