// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // get current price of ETH in terms of USD as a uint256
    function getPrice() internal view returns (uint256){
        // To access prices in a smart contract we first need:
        // Address ETH/USD: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (
            /*uint80 roundId*/, 
            int256 answer, // price in ETH in terms of USD should return something like 2000.00000000
            /*uint256 startedAt*/, 
            /*uint256 updatedAt*/, 
            /*uint80 answeredInRound*/
            ) = priceFeed.latestRoundData();
        return uint256(answer * 1e10); // make use of this to get the decimal points
    }

    // convert ETH into USD
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        // 1 ETH?
        // 2000_000000000000000000
        uint ethPrice = getPrice();
        // (2000_000000000000000000 * 1_000000000000000000) / 1e18
        // $2000 = 1 ETH 
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // USD * WEI
        return ethAmountInUsd; // returns a value with 18 decimals 
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}