const { ethers} = require("ethers");
require("dotenv").config({ path: __dirname + "/./../.env" });


const API_URL = process.env.ALCHEMY_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;
const CONTRACT_ABI = require("../artifacts/contracts/NFT.sol/NFT.json");


let customHttpProvider = new ethers.providers.JsonRpcProvider("https://eth-rinkeby.alchemyapi.io/v2/" + API_URL);

async function mintNft(tokenId, price,metadatahash) {
  let wallet = new ethers.Wallet(PRIVATE_KEY, customHttpProvider);

  let signer = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI.abi, wallet);

  const mintNft = await signer.mintNft(tokenId, price,metadatahash);

  console.log("NFT Minted");
  console.log(mintNft);
}

 mintNft(1,"sdagdfhfdgjhjhfgh"
);