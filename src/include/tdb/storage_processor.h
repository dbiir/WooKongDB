/*-------------------------------------------------------------------------
 *
 * storage_processor.h
 *	  the request and the relational function about storage connect to session
 *
 * Copyright (c) 2019-Present, TDSQL
 *
 * src/include/tdb/storage_processor.h
 *
 *-------------------------------------------------------------------------
 */

#ifndef STORAGE_PROCESSOR_H
#define STORAGE_PROCESSOR_H

#include "tdb/kvengine.h"
#include "tdb/tdbkvam.h"
#include "tdb/session_processor.h"
#include "utils/hsearch.h"
#include "tdb/storage_param.h"

#define USE_THREAD_CONTEXT true
#define MAX_STORAGE_THREADS 512
#define KV_RETRAT_TIMEOUT (0.05)
#define KV_MAX_RERECEIVE_NUM (20)
#define STORAGE_RETRAT_TIMEOUT (0.05)
/*
 * handle storage
 * 1. LIST_MQ_HANDLE
 * 2. NUM_ARRARY
 * 3. THREAD_CONNECT
 */
#define HANDLE_STORAGE (1)

typedef struct KVScanDescData
{
	Dataslice keyslice[SCAN_REQUEST_NUM];
	Dataslice valueslice[SCAN_REQUEST_NUM];
    Oid rangeid[SCAN_REQUEST_NUM];
	KVEngineIteratorInterface *engine_it;
	Relation fake_rel;
	unsigned int kv_count;
	Size res_size;
	Dataslice next_key;	/* Is used by ROCKSDB_SCAN */
	uint64_t cts;
	uint64_t nts;
} KVScanDescData;
typedef KVScanDescData* KVScanDesc;

typedef struct ThreadJobData
{
	int pid;
	KVEngineMQHandle handle;
	RequestHeader *req;
}ThreadJobData;
typedef ThreadJobData* ThreadJob;

extern KVEngineInterface *engine;
extern KVEngineInterface *log_engine;
extern __thread KVScanDesc RouteCheckScanDesc;
extern __thread KVEngineMQHandle current_handle;
extern ResponseHeader* kvengine_process_get_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_put_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_delete_direct_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_scan_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_put_rts_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_multi_get_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_delete_one_tuple_all_index(RequestHeader* req);
extern ResponseHeader* kvengine_process_detach(RequestHeader* req);
extern ResponseHeader* kvengine_process_delete_normal_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_update_req(RequestHeader* req);
extern ResponseHeader* kvengine_process_abort(RequestHeader* req);
extern ResponseHeader* kvengine_process_commit(RequestHeader* req);
extern ResponseHeader* kvengine_process_prepare(RequestHeader* req);
extern ResponseHeader* kvengine_process_clear(RequestHeader* req);
extern void store_kv(KVScanDesc desc, Dataslice key, Dataslice value, Oid rangeid);
extern void free_kv_desc(KVScanDesc desc);
extern ResponseHeader* kvengine_pgprocess_commit(RequestHeader* req);
extern ResponseHeader* kvengine_pgprocess_abort(RequestHeader* req);

extern bool StorageStartRule(Datum main_arg);
extern void storage_main(Datum main_arg);

/* two transaction common use */
extern KVScanDesc init_kv_scan(bool isforward);
extern ScanResponse* make_scan_res(KVScanDesc desc, int type);
extern ScanResponse* finish_kv_scan(KVScanDesc desc, int type);
extern void get_key_interval_from_scan_req(ScanWithKeyRequest* scan_req, TupleKeySlice* start_key, TupleKeySlice* end_key, TupleKeySlice *os_key, TupleKeySlice *oe_key);
extern bool checkRouteVisible(TupleKeySlice key);

#endif
