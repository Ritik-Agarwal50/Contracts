// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract whitelist {
    uint8 public maxWhitedAddress;
    mapping(address => bool) public whitelistedAddresses;

    uint8 public numAddressesWhitelisted;

    constructor(uint8 _maxWhitelistedAddresses) {
        maxWhitedAddress = _maxWhitelistedAddresses;
    }

    function addAdressToWhitelist() public {
        require(
            !whitelistedAddresses[msg.sender],
            "sender is already whitelisted"
        );

        require(
            numAddressesWhitelisted < maxWhitedAddress,
            "more address cant be addes"
        );

        whitelistedAddresses[msg.sender] = true;
        numAddressesWhitelisted += 1;
    }

    function checkAddress(address user) public view returns (bool) {
        return whitelistedAddresses[user];
    }
}
