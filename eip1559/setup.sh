#!/bin/sh
set -e
source common/variables
source common/functions

mkdir -p $OUT_DIR

sh $RUN_GETH_INIT_SCRIPT 1
sh $RUN_GETH_INIT_SCRIPT 2
sh $RUN_GETH_IMPORT_ACCOUNT_SCRIPT 1 1
sh $RUN_GETH_IMPORT_ACCOUNT_SCRIPT 1 2
sh $RUN_GETH_IMPORT_ACCOUNT_SCRIPT 2 1
sh $RUN_GETH_IMPORT_ACCOUNT_SCRIPT 2 2

STATIC_NODES_1_OUT=$(gethStaticNodesOut 1)
STATIC_NODES_2_OUT=$(gethStaticNodesOut 2)
cp $EIP1559_STATIC_NODES $STATIC_NODES_1_OUT
cp $EIP1559_STATIC_NODES $STATIC_NODES_2_OUT


BESU_NODE_KEY_1=$(besuNodeKeyFile 1)
BESU_DATA_DIR_1=$(besuDataDir 1)
mkdir -p $BESU_DATA_DIR_1
cp $EIP1559_BESU_NODE_WHITELIST "$BESU_DATA_DIR_1/permissions_config.toml"
cp $BESU_NODE_KEY_1 "$BESU_DATA_DIR_1/key"
cp $EIP1559_STATIC_NODES "$BESU_DATA_DIR_1/static-nodes.json"
