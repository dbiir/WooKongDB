psql penguindb << EOF
    CREATE DATABASE tpcbrocksdb;
    ALTER DATABASE tpcbrocksdb SET default_transaction_isolation = 'repeatable read';
    CREATE DATABASE tpcbheap;
    ALTER DATABASE tpcbheap SET default_transaction_isolation = 'repeatable read';
EOF

pgbench -i -s 100 -x storage_engine=rocksdb -n -d tpcbrocksdb

pgbench -i -s 100 -n -d tpcbheap

