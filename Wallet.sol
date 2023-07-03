// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
contract Wallet {
    address payable public owner;
    event Withdraw(address indexed account, uint amount);
    event Deposit(address indexed account, uint amount);
    constructor() {
        owner = payable(msg.sender);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "This is only call by owner...");
        _;
    }
    function getbalance() external view returns (uint balance) {
        return address(this).balance;
    }
    function withdraw(uint amount) external onlyOwner {
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
    fallback() external payable {}
}