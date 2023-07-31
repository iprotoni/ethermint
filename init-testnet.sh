#!/bin/sh

# create a random Namespace ID for your rollup to post blocks to
NAMESPACE_ID=$(openssl rand -hex 10)
echo $NAMESPACE_ID

# query the DA Layer start height, in this case we are querying
# an RPC endpoint provided by Celestia Labs. The RPC endpoint is
# to allow users to interact with Celestia's core network by querying
# the node's state and broadcasting transactions on the Celestia
# network. This is for Arabica, if using another network, change the RPC.
DA_BLOCK_HEIGHT=$(curl https://rpc-arabica-9.consensus.celestia-arabica.com/block |jq -r '.result.block.header.height')
echo $DA_BLOCK_HEIGHT

# export the Celestia light node's auth token to allow you to submit
# PayForBlobs to Celestia's data availability network
# this is for Arabica, if using another network, change the network name
export AUTH_TOKEN=$(celestia light auth write --p2p.network arabica)
echo $AUTH_TOKEN

# start the chain
ethermintd start --rollkit.aggregator true --rollkit.da_layer celestia --rollkit.da_config='{"base_url":"http://localhost:26658","timeout":60000000000,"fee":600000,"gas_limit":6000000,"auth_token":"'$AUTH_TOKEN'"}' --rollkit.namespace_id $NAMESPACE_ID --rollkit.da_start_height $DA_BLOCK_HEIGHT