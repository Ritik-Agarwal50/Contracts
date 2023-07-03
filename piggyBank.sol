// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract piggyBank {
    address public owner;

    constructor() {
        owner == payable(msg.sender);
    }

    event deposit(uint amount);
    event withdraw(uint amount);

    receive() external payable {
        emit deposit(msg.value);
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "only owner can withdraw funds from PiggyBank"
        );
        _;
    }

    fallback() external payable {}

    function Withdraw(uint amount) external onlyOwner {
        payable(msg.sender).transfer(amount);
        emit withdraw(address(this).balance);
        selfdestruct(payable(owner));
    }
}
