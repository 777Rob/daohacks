// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract IClubFactory {
    event ClubCreated(
        address indexed nftCollection,
        address indexed club,
        uint256 clubCount
    );
}
