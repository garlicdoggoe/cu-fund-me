// This lesson tackles about:
//      - Getting funds from user
//      - Widthrawing funds as the contract owner
//      - Set a minimum funding value in USD 

// SPDX-License-Identifier: MIT

import { PriceConverter } from "./PriceConverter.sol";

pragma solidity ^0.8.19;

contract FundMe {
    using PriceConverter for uint256; // needed to use the library for uint256

    uint256 public minimumUsd = 5e18; // since getConversionRate returns a value with 18 decimal places, we need to e18

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    
    // This function allows for sending $
    // and have a minimum $ for sending
    function fund() public payable {
         // msg.value already gets passed as a parameter in the method 
         // just take note, when using 2 or more parameters, just use the 2nd onwards as parameters in the given method
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't sent enough ETH!");
        // 1e18 WEI = 1 ETH also add when the condition is not met
        // sample output will be 1000000000000000000
        funders.push(msg.sender); // sender is a global variable that points to someone who hac interacted with the contract
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    // function widthraw() public {}
}