#!/bin/sh

NAMESPACE_ID=$(openssl rand -hex 8)
echo $NAMESPACE_ID

DA_BLOCK_HEIGHT=$(curl http://localhost:26650/block |jq -r '.result.block.header.height')
echo $DA_BLOCK_HEIGHT

AUTH_TOKEN=""
echo $AUTH_TOKEN

ethermintd start --rollkit.aggregator true --rollkit.da_layer celestia --rollkit.da_config='{"base_url":"http://localhost:26658","timeout":60000000000,"fee":600000,"gas_limit":6000000,"auth_token":"'$AUTH_TOKEN'"}' --rollkit.namespace_id $NAMESPACE_ID --rollkit.da_start_height $DA_BLOCK_HEIGHT

# uncomment the next command if you are using lazy aggregation
# ethermintd start --rollkit.aggregator true --rollkit.da_layer celestia --rollkit.da_config='{"base_url":"http://localhost:26658","timeout":60000000000,"fee":600000,"gas_limit":6000000,"auth_token":"'$AUTH_TOKEN'"}' --rollkit.namespace_id $NAMESPACE_ID --rollkit.da_start_height $DA_BLOCK_HEIGHT --rollkit.lazy_aggregator