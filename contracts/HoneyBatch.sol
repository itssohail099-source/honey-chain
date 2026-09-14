// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HoneyChain {
    struct Batch {
        string hiveId;
        uint256 weightKg;
        uint256 timestamp;
    }
    
    mapping(uint256 => Batch) public batches;
    uint256 public batchCount;

    function createBatch(string memory _hiveId, uint256 _weightKg) public returns (uint256) {
        batchCount++;
        batches[batchCount] = Batch(_hiveId, _weightKg, block.timestamp);
        return batchCount;
    }

    function verifyBatch(uint256 _batchId) public view returns (string memory, uint256, uint256) {
        Batch memory b = batches[_batchId];
        return (b.hiveId, b.weightKg, b.timestamp);
    }
}