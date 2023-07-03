// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Iterable {
    address[] public keys;
    mapping(address => uint) public balanceOf;
    mapping(address => bool) public inserted;

    function set(address _keys, uint _val) external {
        balanceOf[_keys] = _val;

        if (!inserted[_keys]) {
            inserted[_keys] = true;
            keys.push(_keys);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function firstKey() external view returns (uint) {
        return balanceOf[keys[0]];
    }

    function lastKey() view externl returns (uint) {
        return balanceOf[keys[keys.length - 1]];
    }

    function getRandomValue(uint _i) external view returns (uint) {
        return balanceOf[keys[_i]];
    }
}
