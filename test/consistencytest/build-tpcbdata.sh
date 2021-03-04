#SSS
psql penguindb << EOF
    CREATE DATABASE tpcbsss;
    ALTER DATABASE tpcbSSS SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpcbSSS SET transam_mode = 'rucc';
    ALTER DATABASE tpcbSSS SET consistency_mode = 'default';
EOF
pgbench -i -s 100 -x storage_engine=rocksdb -n -d tpcbsss;

#SS
psql penguindb << EOF
    CREATE DATABASE tpcbss;
    ALTER DATABASE tpcbSS SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpcbSS SET transam_mode = 'rucc';
    ALTER DATABASE tpcbSS SET consistency_mode = 'sequence';
EOF
pgbench -i -s 100 -x storage_engine=rocksdb -n -d tpcbss;

#casual
psql penguindb << EOF
    CREATE DATABASE tpcbcasual;
    ALTER DATABASE tpcbcasual SET default_transaction_isolation = 'repeatable read';
    ALTER DATABASE tpcbcasual SET transam_mode = 'default';
    ALTER DATABASE tpcbcasual SET consistency_mode = 'causal';
EOF
pgbench -i -s 100 -x storage_engine=rocksdb -n -d tpcbcasual;