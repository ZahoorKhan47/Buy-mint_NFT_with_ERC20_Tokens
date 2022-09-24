// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721, ERC721URIStorage, Ownable {


    // Struct
    struct nftinfo {
        string metaDataHash;
    }

    // Veriables
    IERC20 public tokenAddress;
    string public baseURI;
    uint256 public price = 5 ;

    // Mapping
    mapping(uint256 => nftinfo) public NftData;

    constructor(address _tokenaddress) ERC721("Zedon", "ZDT") {
        tokenAddress = IERC20(_tokenaddress);
        baseURI = "https://gateway.pinata.cloud/ipfs/";
    }
    // Event
    event MintedNft(address _address,uint256 tokenId,uint256 price);

    // Custom Errors

    // Miniting Funciton
    function mintNft(
        uint256 tokenId,
        string memory _metadataHash
    ) public {
        
        
        
        tokenAddress.transferFrom(msg.sender, owner(), price);
        _safeMint(msg.sender, tokenId);
        NftData[tokenId] = nftinfo( _metadataHash);
        emit MintedNft(msg.sender,tokenId,price);

       
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    baseURI,
                    NftData[tokenId].metaDataHash
                )
            );
    }
}