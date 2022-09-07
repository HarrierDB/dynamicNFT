// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

//0x8F6b4D09Af5a52FE6d137947b03b25CdDEE01245

contract ChainBattles is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    struct stats {
        uint256 Level;
        uint256 Speed;
        uint256 Strength;
        uint256 Life;
    }


    mapping (uint256 => stats) public tokenIdToLevels;

    constructor() ERC721("ChainBattles", "CB") {}

    function generateCharacter(uint256 tokenId) public returns(string memory){

    bytes memory svg = abi.encodePacked(
    '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
    '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
    '<rect width="100%" height="100%" fill="black" />',
    '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',"Warrior",'</text>',
    '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Levels: ",getLevels(tokenId),'</text>',
    '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "Speed: ",getSpeed(tokenId),'</text>',
    '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">', "Strength: ",getStrength(tokenId),'</text>',
    '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">', "Life: ",getLife(tokenId),'</text>',
    '</svg>'
    );
    return string(
    abi.encodePacked(
    "data:image/svg+xml;base64,",
    Base64.encode(svg)
    )
    );
    }

    function getLevels(uint256 tokenId) public view returns (string memory) {
        return tokenIdToLevels[tokenId].Level.toString();
    }
    function getSpeed(uint256 tokenId) public view returns (string memory) {
        return tokenIdToLevels[tokenId].Speed.toString();
    }
    function getStrength(uint256 tokenId) public view returns (string memory) {
        return tokenIdToLevels[tokenId].Strength.toString();
    }
    function getLife(uint256 tokenId) public view returns (string memory) {
        return tokenIdToLevels[tokenId].Life.toString();
    }

    function getTokenURI(uint256 tokenId) public returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
            '"name": "Chain Battles #', tokenId.toString(), '",',
            '"description": "Battles on chain",',
            '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdToLevels[newItemId] = stats(0, random(20), random(50), random(100));
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing token");
        require(ownerOf(tokenId) == msg.sender, "You must own this token to train it");

        uint256 currentLevel = tokenIdToLevels[tokenId].Level;
        tokenIdToLevels[tokenId].Level = currentLevel + 1;
        uint256 currentSpeed = tokenIdToLevels[tokenId].Speed;
        tokenIdToLevels[tokenId].Speed = currentSpeed + 10;
        uint256 currentStrength = tokenIdToLevels[tokenId].Strength;
        tokenIdToLevels[tokenId].Strength = currentStrength + 40;
        uint256 currentLife = tokenIdToLevels[tokenId].Speed;
        tokenIdToLevels[tokenId].Life = currentLife + 100;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }

    function random(uint256 number) public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,
            msg.sender))) % number;
    }

}
