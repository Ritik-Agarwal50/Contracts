// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract mynft is ERC721 {
    uint rate = 0.1 ether;
    uint supply = 20;

    uint minted = 0;

    constructor() ERC721("NFT", "NNN") {
        _mint(msg.sender, 1);
    }

    function mint() public payable {
        require(minted + 1 <= supply, "Suppy is full");
        require(msg.value >= rate, "price is less");
        _mint(msg.sender, 1);
        minted += 1;
    }

    // modifier onlyOwner() {
    //     require(owner == msg.sender);
    //     _;
    // }

    function withdraw() public {
        address _owner = msg.sender;
        uint amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "failed");
    }

    receive() external payable {}

    fallback() external payable {}
}
