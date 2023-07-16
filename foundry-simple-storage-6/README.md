Using foundry and anvil local test net to deploy smart contracts

To initialize foundry project
    + forge init
    + forge compile --> to compile project
+ anvil
    > to run local testnet node 

+ To deploy contract on local testnet
    Use CLI
        + forge create SimpleStorage --interactive
    Use script
        + write script under /script
        + forge script script/DeploySimpleStorage.s.sol

+ To deploy on any network
    Use CLI
        + forge create SimpleStorage --rpc-url http://x.x.x.x:xxxx --broadcast --interactive
    Use script
        + forge script script/DeploySimpleStorage.s.sol --rpc-url http://x.x.x.x:xxxx --broadcast --private-key 0xxxxxxx

        - We can place private key in the .env folder to access it as a environment variable (use for testing only)
        - use `source .env` to use defined env variables in .env file
        - make sure to add .env in gitignore

        - it is recommended to use keystore files to include private key

        - We can use third-party services like thirdweb to deploy contract without exposing private key

+ Interacting with contract
    + Use cast cli
        + transaction
            cast send <address> "store(uint256)" --rpc-url $RPC_URL --private-key $PRIVATE_KEY 
        + calling (view functions)
            cast call <address> "retrieve()"
        
    + using script