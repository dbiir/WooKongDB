#-------------------------------------------------------------------------
#
# Makefile--
#    Makefile for executor
#
# IDENTIFICATION
#    src/backend/executor/Makefile
#
#-------------------------------------------------------------------------

subdir = src/backend/executor
top_builddir = ../../..
include $(top_builddir)/src/Makefile.global
override CPPFLAGS := -I$(libpq_srcdir) $(CPPFLAGS)


OBJS = execAmi.o execCurrent.o execGrouping.o execJunk.o execMain.o \
       execProcnode.o execQual.o execScan.o execTuples.o \
       execUtils.o functions.o instrument.o nodeAppend.o nodeAgg.o \
       nodeBitmapAnd.o nodeBitmapOr.o \
       nodeBitmapHeapscan.o nodeBitmapIndexscan.o nodeHash.o \
       nodeHashjoin.o nodeIndexscan.o nodeIndexonlyscan.o \
       nodeLimit.o nodeLockRows.o \
       nodeMaterial.o nodeMergeAppend.o nodeMergejoin.o nodeModifyTable.o \
       nodeNestloop.o nodeFunctionscan.o nodeRecursiveunion.o nodeResult.o \
       nodeSeqscan.o nodeSetOp.o nodeSort.o nodeUnique.o \
       nodeValuesscan.o nodeCtescan.o nodeWorktablescan.o \
       nodeSubplan.o nodeSubqueryscan.o nodeTidscan.o \
       nodeForeignscan.o nodeWindowAgg.o tstoreReceiver.o spi.o

OBJS += nodeExternalscan.o \
       nodeDynamicIndexscan.o \
       nodeDynamicBitmapHeapscan.o \
       nodeDynamicBitmapIndexscan.o \
       nodeMotion.o \
       nodeRepeat.o \
       nodeShareInputScan.o \
       nodeTableFunction.o \
       nodeDynamicSeqscan.o \
       nodeSequence.o \
       nodeRowTrigger.o \
       nodeAssertOp.o \
       nodeSplitUpdate.o \
       nodeDML.o \
       execDML.o \
       nodePartitionSelector.o \
       execDynamicScan.o \
       execHHashagg.o execGpmon.o

OBJS += nodeKVScan.o

include $(top_srcdir)/src/backend/common.mk