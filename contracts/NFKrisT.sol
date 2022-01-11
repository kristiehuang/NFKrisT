//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFKrisT is ERC721, Ownable {
    uint public maxPurchaseCount = 5;
    uint256 public TOTAL_SUPPLY = 100;
    uint256 public tokenCounter;
    uint256 public constant mintPrice = 80000000000000000; //0.08 ETH

    // Mapping of user address -> user's owned NFKrisT tokens
    mapping (address => uint256[]) internal ownerToTokenIds;

    constructor() ERC721("NFKrisT", "KRIS") {
        tokenCounter = 0;
    }

    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function mintNFKrisT(uint numberOfTokens) public payable {
        require(numberOfTokens <= maxPurchaseCount, "Can only mint 5 tokens at a time");
        require(tokenCounter + numberOfTokens <= TOTAL_SUPPLY, "Purchase would exceed max supply of NFTs");
        require(ownerToTokenIds[msg.sender].length + numberOfTokens <= 10, "Can only mint 10 tokens per address");
        require(mintPrice * numberOfTokens <= msg.value, "Ether value sent is not correct");

        for(uint i = 0; i < numberOfTokens; i++) {
            
            if (tokenCounter < TOTAL_SUPPLY) {
                uint256 newItemId = tokenCounter;
                if (ownerToTokenIds[msg.sender].length == 0) {
                    ownerToTokenIds[msg.sender] = [newItemId];
                } else {
                    ownerToTokenIds[msg.sender].push(newItemId); // assuming intialized as empty aray
                }
                _safeMint(msg.sender, newItemId);
                tokenCounter = tokenCounter + 1;
            }
        }
    }

    function getTokensForAddress() view public returns (uint256[] memory) {
        return ownerToTokenIds[msg.sender];
    }
}
