// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Test {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

contract create2 {
    event dep(address addr);

    function deploy(bytes32 _salt) external {
        Test t1 = new Test{salt: bytes32(_salt)}(msg.sender);
        emit dep(address(t1));
    }

    function getAddress(bytes memory byteCode, uint _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(byteCode)
            )
        );
        return address(uint160(uint(hash)));
    }
    function getByteCode(address _owner) public view returns (bytes memory) {
        bytes memory byteCode = type(Test).creationCode;
        return abi.encodePacked(byteCode, abi.encode(_owner));
    }
}
