#focc
psql penguindb << EOF
    CREATE DATABASE tpcbfocc;
    ALTER DATABASE tpcbfocc SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpcbfocc SET transam_mode = 'occ';
    ALTER DATABASE tpcbfocc SET consistency_mode = 'default';
EOF
pgbench -i -s 100 -x storage_engine=rocksdb -n -d tpcbocc

#bocc
psql penguindb << EOF
    CREATE DATABASE tpcbbocc;
    ALTER DATABASE tpcbbocc SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpcbbocc SET transam_mode = 'docc';
    ALTER DATABASE tpcbbocc SET consistency_mode = 'default';
    
EOF
pgbench -i -s 100 -x storage_engine=rocksdb -n -d tpcbbocc

#rucc
psql penguindb << EOF
    CREATE DATABASE tpcbrucc;
    ALTER DATABASE tpcbrucc SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpcbrucc SET transam_mode = 'rucc';
    ALTER DATABASE tpcbrucc SET transam_mode = 'sequence';
EOF
pgbench -i -s 100 -x storage_engine=rocksdb -n -d tpcbrucc
