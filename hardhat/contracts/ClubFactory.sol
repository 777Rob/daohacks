// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./Utils/Ownable.sol";
import "./ClubContract.sol";
import "./Utils/VRFv2Consumer.sol";
import "./Utils/VRFv2SubscriptionManager.sol";
import "./Interfaces/IERC721.sol";

abstract contract IClubFactory {
    event ClubCreated(
        address indexed nftCollection,
        address indexed club,
        uint256 clubCount
    );
}

contract ClubFactory is Ownable, VRFv2SubscriptionManager, IClubFactory {
    address[] public allClubs;
    uint256 public clubCount;
    mapping(address => address) public clubsMap;

    /*
    address of an Nft collection smart contract => deployed club smart contract address
     */

    constructor() {
        Ownable(msg.sender);
    }

    receive() external payable {}

    fallback() external payable {}

    function createClub(address _nftCollection)
        external
        returns (address club)
    {
        require(_nftCollection != address(0), "NftCollection: ZERO_ADDRESS");
        require(clubsMap[_nftCollection] == address(0), "Club: CLUB_EXISTS"); // single check is sufficient
        bytes memory bytecode = type(ClubContract).creationCode;
        bytes32 salt = keccak256(
            abi.encodePacked(_nftCollection, s_subscriptionId)
        );
        assembly {
            // addr := create2(amount, add(bytecode, 0x20), mload(bytecode), salt)
            club := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        require(club != address(0), "Create2: Failed on deploy");

        ClubContract(club).initialize(_nftCollection, s_subscriptionId);

        clubsMap[_nftCollection] = club;

        allClubs.push(club);
        clubCount += 1;

        COORDINATOR.addConsumer(s_subscriptionId, club);

        emit ClubCreated(_nftCollection, club, clubCount);
    }
}
