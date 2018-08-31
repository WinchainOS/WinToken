pragma solidity ^0.4.21;

import "./StandardToken.sol";
import "./Ownable.sol";
import "./SafeMathLib.sol";

contract Winchain is StandardToken, Ownable {
    using SafeMathLib for uint256;

    uint256 INTERVAL_TIME = 63072000;//Two years
    uint256 public deadlineToFreedTeamPool;//the deadline to freed the win pool of team
    string public name = "Winchain";
    string public symbol = "WIN";
    uint256 public decimals = 18;
    uint256 public INITIAL_SUPPLY = (210) * (10 ** 8) * (10 ** 18);//210

    // WIN which is freezed for the second stage
    uint256 winPoolForSecondStage;
    // WIN which is freezed for the third stage
    uint256 winPoolForThirdStage;
    // WIN which is freezed in order to reward team
    uint256 winPoolToTeam;
    // WIN which is freezed for community incentives, business corporation, developer ecosystem
    uint256 winPoolToWinSystem;

    event Freed(address indexed owner, uint256 value);

    function Winchain(){
        totalSupply = INITIAL_SUPPLY;
        deadlineToFreedTeamPool = INTERVAL_TIME.add(block.timestamp);

        uint256 peerSupply = totalSupply.div(100);
        //the first stage 15% + community operation 15%
        balances[msg.sender] = peerSupply.mul(30);
        //the second stage 15%
        winPoolForSecondStage = peerSupply.mul(15);
        //the third stage 20%
        winPoolForThirdStage = peerSupply.mul(20);
        //team 15%
        winPoolToTeam = peerSupply.mul(15);
        //community incentives and developer ecosystem 20%
        winPoolToWinSystem = peerSupply.mul(20);

    }

    //===================================================================
    //
    function balanceWinPoolForSecondStage() public constant returns (uint256 remaining) {
        return winPoolForSecondStage;
    }

    function freedWinPoolForSecondStage() onlyOwner returns (bool success) {
        require(winPoolForSecondStage > 0);
        require(balances[msg.sender].add(winPoolForSecondStage) >= balances[msg.sender]
        && balances[msg.sender].add(winPoolForSecondStage) >= winPoolForSecondStage);

        balances[msg.sender] = balances[msg.sender].add(winPoolForSecondStage);
        Freed(msg.sender, winPoolForSecondStage);
        winPoolForSecondStage = 0;
        return true;
    }
    //
    function balanceWinPoolForThirdStage() public constant returns (uint256 remaining) {
        return winPoolForThirdStage;
    }

    function freedWinPoolForThirdStage() onlyOwner returns (bool success) {
        require(winPoolForThirdStage > 0);
        require(balances[msg.sender].add(winPoolForThirdStage) >= balances[msg.sender]
        && balances[msg.sender].add(winPoolForThirdStage) >= winPoolForThirdStage);

        balances[msg.sender] = balances[msg.sender].add(winPoolForThirdStage);
        Freed(msg.sender, winPoolForThirdStage);
        winPoolForThirdStage = 0;
        return true;
    }
    //
    function balanceWinPoolToTeam() public constant returns (uint256 remaining) {
        return winPoolToTeam;
    }

    function freedWinPoolToTeam() onlyOwner returns (bool success) {
        require(winPoolToTeam > 0);
        require(balances[msg.sender].add(winPoolToTeam) >= balances[msg.sender]
        && balances[msg.sender].add(winPoolToTeam) >= winPoolToTeam);

        require(block.timestamp >= deadlineToFreedTeamPool);

        balances[msg.sender] = balances[msg.sender].add(winPoolToTeam);
        Freed(msg.sender, winPoolToTeam);
        winPoolToTeam = 0;
        return true;
    }
    //
    function balanceWinPoolToWinSystem() public constant returns (uint256 remaining) {
        return winPoolToWinSystem;
    }

    function freedWinPoolToWinSystem() onlyOwner returns (bool success) {
        require(winPoolToWinSystem > 0);
        require(balances[msg.sender].add(winPoolToWinSystem) >= balances[msg.sender]
        && balances[msg.sender].add(winPoolToWinSystem) >= winPoolToWinSystem);

        balances[msg.sender] = balances[msg.sender].add(winPoolToWinSystem);
        Freed(msg.sender, winPoolToWinSystem);
        winPoolToWinSystem = 0;
        return true;
    }

    function() public payable {
        revert();
    }

}
