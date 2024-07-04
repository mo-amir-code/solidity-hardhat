// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(bytes32 => uint256) public votesReceived;
    mapping(address => bool) public voters;

    bytes32[] public candidateList;

    constructor(bytes32[] memory _candidateNames) {
        candidateList = _candidateNames;
    }

    function vote(bytes32 candidate) public {
        require(validCandidate(candidate), "Invalid candidate");
        require(!voters[msg.sender], "Already voted");

        votesReceived[candidate] += 1;
        voters[msg.sender] = true;
    }

    function totalVotesFor(bytes32 candidate) public view returns (uint256) {
        require(validCandidate(candidate), "Invalid candidate");
        return votesReceived[candidate];
    }

    function validCandidate(bytes32 candidate) public view returns (bool) {
        for (uint256 i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}