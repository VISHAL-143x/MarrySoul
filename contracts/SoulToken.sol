// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SoulToken is ERC721URIStorage, Ownable, ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Propose {
        address from;
        address to;
        uint256 eventId;
        string tokenURI;
        bool acceptStatus;
        bool mutualMint;
        uint256 createAt;
        uint256 confirmAt;
    }

    mapping(bytes32 => Propose) public proposeInfo;
    mapping(address => bytes32[]) public proposeIdByAddr;
    event MakePropose(
        address indexed from,
        address indexed to,
        bytes32 proposeId,
        uint256 eventId
    );

    event TokenMinted(
        uint256 indexed tokenId,
        string indexed tokenURI
    );

    mapping(address => mapping(uint256 => bytes32)) public pendingConfirm;
    mapping(address => uint256) public pendingConfirmCount;
    mapping(address => mapping(bytes32 => uint256)) public pendingConfirmHashIndex;

    event Witness(uint256 tokenId, address withnessAddr);

    uint256 public fee;

//     modifier _isApprovedOrOwner {
//     require(msg.sender == owner, "Ownable: You are not the owner, Bye.");
//     _;
//   }


    constructor(uint256 _fee) ERC721("MarrySoul", "MSO") Ownable(msg.sender) {
        fee = _fee;
    }    
    

    function sendRequest(
        address _party,
        uint256 _eventId,
        bool _mutualMint,
        string memory _tokenURI
    ) public payable nonReentrant {
        require(!proposeExists(msg.sender, _party, _eventId), "An offer already exists.");
        require(msg.value == fee, "Please pay fee.");
        makePropose(_party, _eventId, _mutualMint, _tokenURI);
    }

    function sendBatchRequest(
        address[] memory _parties,
        uint256 _eventId,
        bool _mutualMint,
        string memory _tokenURI
    ) public payable nonReentrant {
        for (uint256 i = 0; i < _parties.length; i++) {
            address _party = _parties[i];
            require(!proposeExists(msg.sender, _party, _eventId), "An offer already exists.");
            require(msg.value == fee, "Please pay fee.");
            makePropose(_party, _eventId, _mutualMint, _tokenURI);
        }
    }

    function makePropose(
        address _party,
        uint256 _eventId,
        bool _mutualMint,
        string memory _tokenURI
    ) internal {
        bytes32 proposeHash = _hash(msg.sender, _party, _eventId);
        proposeInfo[proposeHash] = Propose(
            msg.sender,
            _party,
            block.number,
            _tokenURI,
            false,
            _mutualMint,
            block.timestamp,
            0
        );
        proposeIdByAddr[msg.sender].push(proposeHash);
        addPendingConfirmEnumeration(_party, proposeHash);
        emit MakePropose(msg.sender, _party, proposeHash, _eventId);
    }

    function addPendingConfirmEnumeration(address _party, bytes32 _proposeHash) internal {
        pendingConfirm[_party][pendingConfirmCount[_party]] = _proposeHash;
        pendingConfirmHashIndex[_party][_proposeHash] = pendingConfirmCount[_party];
        pendingConfirmCount[_party] += 1;
    }

    function removePendingConfirmEnumeration(address _party, bytes32 _proposeHash) internal {
        uint256 lastConfirmIndex = pendingConfirmCount[_party] - 1;
        uint256 confirmIndex = pendingConfirmHashIndex[_party][_proposeHash];

        if (confirmIndex != lastConfirmIndex) {
            bytes32 lastConfirmHash = pendingConfirm[_party][lastConfirmIndex];
            pendingConfirm[_party][confirmIndex] = lastConfirmHash;
            pendingConfirmHashIndex[_party][lastConfirmHash] = confirmIndex;
        }

        delete pendingConfirmHashIndex[_party][_proposeHash];
        delete pendingConfirm[_party][lastConfirmIndex];
        pendingConfirmCount[_party] -= 1;
    }

    function _hash(
        address _from,
        address _to,
        uint256 eventId
    ) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_from, _to, eventId));
    }

    function approvePropose(bytes32 _proposeHash) public nonReentrant {
        require(proposeHashExists(_proposeHash), "Propose not exists.");

        Propose storage p = proposeInfo[_proposeHash];

        require(!p.acceptStatus, "Already accept propose");
        p.acceptStatus = true;
        p.confirmAt = block.timestamp;
        removePendingConfirmEnumeration(msg.sender, _proposeHash);

        if (p.mutualMint) {
            awardToken(p.from, p.tokenURI);
        }
        awardToken(p.to, p.tokenURI);
    }

    function witness(uint256 tokenId) public nonReentrant {
        emit Witness(tokenId, msg.sender);
    }

    function pendingConfirmByIndex(address _party, uint256 index) public view returns (bytes32) {
        return pendingConfirm[_party][index];
    }

    function pendingConfirmIndexByHash(address _party, bytes32 _hashId) public view returns (uint256) {
        return pendingConfirmHashIndex[_party][_hashId];
    }

    function awardToken(address _party, string memory _tokenURI) private returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(_party, newItemId);
        _setTokenURI(newItemId, _tokenURI);

        emit TokenMinted(newItemId, _tokenURI);
        return newItemId;
    }

    function proposeExists(
        address _from,
        address _to,
        uint256 _eventId
    ) public view returns (bool) {
        bytes32 proposeHash = _hash(_from, _to, _eventId);
        return proposeInfo[proposeHash].from == _from;
    }

    function proposeHashExists(bytes32 _proposeHash) public view returns (bool) {
        return proposeInfo[_proposeHash].from != address(0);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 startTokenId
    ) internal {
        if (to == address(0)) {
            _beforeTokenTransfer(from, to, startTokenId);
        } else {
            require(from == address(0), "Cannot transfer soul bond token");
            _beforeTokenTransfer(from, to, startTokenId);
        }
    }


//     function burn(uint256 tokenId) external {
//         require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
//         _burn(tokenId);
//     }

//     function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) 
//     {
//     return (ownerOf(tokenId) == spender || getApproved(tokenId) == spender || isApprovedForAll(ownerOf(tokenId), spender));
// }




     function getproposeIdByAddr(address _addr) external view returns (bytes32[] memory){
        return proposeIdByAddr[_addr];
    }
    /// @notice withdraw the ether in the contract
    /// @dev
    /// @return
    function withdraw() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}