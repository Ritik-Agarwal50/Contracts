// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Ownable {
    address public owner;
    event Ownershiptransfer(address indexed previousOwner, address indexed newOwner);
    constructor(){
        owner == msg.sender;

    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function currentOwner() public view returns(address){
        return owner;
    }

    function transferOwner(address newOwner) public onlyOwner{
        require(newOwner != address(0) , "The new owner address is not valid..");
        owner = newOwner;
        emit Ownershiptransfer(msg.sender, owner);
    }
}