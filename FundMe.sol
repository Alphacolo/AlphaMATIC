// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

<<<<<<< HEAD
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    // getRoundData and latestRoundData should both raise "No data present"
    // if they do not have data to report, instead of returning unset values
    // which could be misinterpreted as actual reported values.
    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

contract FundMe {
    mapping(address => uint256) public addresstoAmountFunded;

    function fund() public payable {
        addresstoAmountFunded[msg.sender] += msg.value;
        //what is the eth ->usd conversion rate
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );

        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );
        (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = priFeed.latestRoundData();
        return uint256(answer);
    }
=======
contract FundMe{
    using SafeMathChainlink for uint256;
    
    mapping(address => uint256) public addresstoAmountFunded;
    address[] public funders;
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
  function fund() public payable {
        
        uint256 minimumUSD = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        addresstoAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
       
   }
   
  function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        return priceFeed.version();
    }

   
    function getPrice() public view returns(uint256){
       AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
       (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
        
        
   }
   function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice=getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1000000000000000000 ;
        return ethAmountInUSD;
   }
   
   modifier onlyOwner{
       require(msg.sender == owner);
       _;
   }
   
   function withdraw() payable public {
       msg.sender.transfer(address (this).balance);
       
       for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
           address funder = funders[funderIndex];
           addresstoAmountFunded[funder] = 0;
       }
       
       funders = new address[](0);
   }
>>>>>>> db8f6352844e0612180a32e7eae703e85cb1282b
}
