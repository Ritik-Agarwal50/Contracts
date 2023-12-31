// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

//verify

//root hash

//test merkle tree

contract MerkleProof {
    function verify(
        bytes[] memory proof,
        bytes32 root,
        bytes32 leaf,
        uint index
    ) public pure returns (bool) {
        bytes32 hash = leaf;
        for (uint i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }

            index = index / 2;
        }
        return hash == root;
    }
}

// contract TestMerkleProof is MerkleProof{

//     bytes32[] public  hashes;
//     string [4] memory trans = [
//         "ritik" -> "god",
//         "bob" -> "noob",
//         "dave" -> "pro",
//         "carol" -> "ok"
//     ];

//     for(uint i =0 ; i<trans.length ; i++){
//         hashes.push(keccak256(abi.encodePacked(trans[i])));
//     }

//     uint n = trans.length;

//     uint offset = 0;

//     while (n > 0) {
//         for(uint i = 0 ;i<n-1 ;i+=2){
//             hashes.push(keccak256(abi.encodePacked(hashes[offset+1] , hashes[offset+ i+1])));

//         }
//         offset += n;
//         n=n/2;
//     }

//     function getRoot() public view returns(bytes32){
//         return hashes[hashes.length-1];
//     }
// }
