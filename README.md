# Live Demo https://marry-soul.vercel.app/

# Quick start
Project name - MarrySoul
1. Link to working code in a public repo - Steps to check the Unstoppable Domain integration - https://marry-soul.vercel.app/
2. Clone the Repo
3. cd MarrySoul
4. npm install
5. npm start
6. Go to http://localhost:3000/
6. Recorded video demo of the integration - https://www.loom.com/share/7ccbae89d9094f159324900cc1ef8498
7. Person of contact in case there are any questions - Vishal Pachpor (Email - vishalpatil080502@gmail.com )
8. Discord ID - vishalpatil01#5005
9. UnstoppableDomain registered account email address - vishalpatil080502@gmail.com
10. Code where UnstoppableDomain is used - 

// #web3 #NFT #dApp



# Quick start
1. git clone https://github.com/VISHAL-143x/MarrySoul; /https://github.com/shabbiryk/MarrySoul
2. Copy  a .env file  `>cp -a env.example  .env` and fill with your own parameters.
3. Get an NFT.Storage API key https://nft.storage/ and add this to the .env
4. Add your sepolia blockchain server api and url to the .env file (ive used alchemy here, though moralis & infura are also awesome)
5. Install packages `>npm install`
6. Deploy the solidity contract to the sepolia testnet using hardhat '>npx hardhat run scripts/deploy.js --network sepolia`
7. Add your contract address to the .env file
8. Run your front end in dev mode `>npm start` OR deploy with Fleek https://fleek.co/



## Setup from scratch instead:

> npx create-react-app my-app-name
> cd my-app-name
> npm install --save-dev hardhat
> npx hardhat (to get a sample project - choose basic project so we get all the folders. Choose no to gitignore and y to dependencies)

install dependencies:

> npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers @nomiclabs/hardhat-etherscan @openzeppelin/contracts
> npm install ethers dotenv

Tasks - development of contract

> add .env to the .gitignore file
> rm ./contracts/Greeter.sol
> rm ./scripts/sample-script.js

> touch ./contracts/SoulToken.sol
> touch ./scripts/run.js
> touch ./scripts/deploy.js

Write solidity contract
Write run.js and test your contract

> npx hardhat run scripts/run.js

Sign up for etherscan / get an API key & add it to hardhat.config
networks: {
sepolia: {
url: process.env.MORALIS_SEPOLIA_API_URL,
accounts: [process.env.METAMASK_SEPOLIA_PRIVATE_KEY],
},
},
etherscan: {
// Your API key for Etherscan
// Obtain one at https://etherscan.io/
apiKey: process.env.ETHERSCAN_API_KEY,
}
### Resources

- Read the IPFS best practice guide for NFT's https://docs.ipfs.io/how-to/mint-nfts-with-ipfs/#a-short-introduction-to-nfts
- See the NFT.School guide https://nftschool.dev/
- Public Gateway status checker: https://ipfs.github.io/public-gateway-checker/
- Faucets for sepolia eth: https://faucets.chain.link/sepolia



### About

MarrySoul is a permissionless soulbound token issuance/attestation protocol that enables people to bring relationships on-chain. 


**Future Plan**



We decided to take it further and launch it on mainnet and L2  with a better design and complete implementation, which

1) enables people to revoke their SBT;

2) enable people to search, issue, and attest with **ENS** integration;

3) link to various DID services like Proof of Humanity and brightID.




We believe a decentralized society will be formed from the grassroots, with the help and support of the individuals.



**Thank you!**



