/*------------------------------------
 *
 * execKVScan.c
 *
 * by williamcliu
 *
 *------------------------------------
 */

#include "postgres.h"

#include "utils/snapmgr.h"
#include "executor/executor.h"
#include "nodes/execnodes.h"
#include "executor/nodeKVscan.h"
#include "tdb/tdbkvam.h"

#include "utils/guc.h"
#include "access/rwset.h"

TupleTableSlot*
KVScanNext(ScanState* scanState)
{
	Assert(IsA(scanState, SeqScanState) ||
		   IsA(scanState, DynamicSeqScanState));
	SeqScanState *node = (SeqScanState*)scanState;
    node->rks_ScanDesc->Scantype = scanState->ps.state->es_plannedstmt->commandType;
	kvengine_getnext(node->rks_ScanDesc, ForwardScanDirection, node->ss.ss_ScanTupleSlot);

	/* append key to read/write set */
	if (transam_mode == TRANSAM_MODE_NEW_OCC
		&& 0)
	{
		AppendKeyToReadWriteSet(node->ss.ss_ScanTupleSlot->PRIVATE_tts_key.len,
					(char *)node->ss.ss_ScanTupleSlot->PRIVATE_tts_key.data,
					scanState->ps.state->es_plannedstmt->commandType);

		AppendReadXidWithKey(node->ss.ss_ScanTupleSlot->PRIVATE_tts_key.len,
					(char *)node->ss.ss_ScanTupleSlot->PRIVATE_tts_key.data,
					scanState->ps.state->es_plannedstmt->commandType);
	}

	return node->ss.ss_ScanTupleSlot;
}

void
BeginScanKVRelation(ScanState* scanState)
{
	Assert(IsA(scanState, SeqScanState) ||
		   IsA(scanState, DynamicSeqScanState));
	SeqScanState *node = (SeqScanState*)scanState;

	node->rks_ScanDesc = kvengine_beginscan(scanState->ss_currentRelation,
										   scanState->ps.state->es_snapshot);
}

void
EndScanKVRelation(ScanState* scanState)
{
	Assert(IsA(scanState, SeqScanState) ||
		   IsA(scanState, DynamicSeqScanState));
	SeqScanState *node = (SeqScanState *)scanState;

	Assert(node->rks_ScanDesc != NULL);

	kvengine_endscan(node->rks_ScanDesc);
}

void
ReScanKVRelation(ScanState* scanState)
{
	Assert(IsA(scanState, SeqScanState) ||
		   IsA(scanState, DynamicSeqScanState));
	SeqScanState *node = (SeqScanState *)scanState;

	Assert(node->rks_ScanDesc != NULL);

	kvengine_rescan(node->rks_ScanDesc);
}
