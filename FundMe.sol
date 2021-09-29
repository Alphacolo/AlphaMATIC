// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract FundMe{
  mapping(address => uint256) public addresstoAmountFunded;
  
  function fund() public payable {
      addresstoAmountFunded[msg.sender] += msg.value;
   }

}
