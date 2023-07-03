// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/erc1155/erc1155.sol";
import "@openzeppelin/contracts/access.Ownable.sol"

contract MyNFT is ERC1155,Ownable{
    bool public _paused;
    string _baseTokenURI;

    uint rate = 0.1 ethers;
    uint supply = 1000;
    uint minted = 0;

    modifier onlyWhenNotPaused() {
        require(!_paused,"contract is paused");
        _;
    }
    constructor(string memory baseURI) ERC1155(baseURI){
        _baseTokenURI = baseURI;
    }

    function mint() external payable{
        require(minted+1 <= supply , "Exceed max supply");
        require(msg.value >= rate,"not enough ether");
        _mint(msg.sender , 1 ,1 "");
        minted += 1;
    }

    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    function withdraw() public onlyOwner{
        address owner = owner();
        uint amount = address(this).balance;
        (bool sent ,) = _owner.call{value : amount}("");
        require(sent ," Failed to transfer");
    }

    receive() external payable{}

    fallback() external payable{}

}