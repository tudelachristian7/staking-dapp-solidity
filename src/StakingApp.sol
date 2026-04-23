// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


// Staking fixed amount. ej: 10 tokens
// Staking reward period. ej: 



contract StakingApp is Ownable {


// Variables
address public stakingToken;
uint256 public stakingPeriod;
uint256 public fixedStakingAmount;
uint256 public rewardPerPeriod;
mapping(address => uint256) public userBalance;
mapping(address => uint256) public elapsePeriod;

// Events
event ChangeStakingPeriod(uint256 newStakingPeriod_);
event DepositToken(address userAddress_, uint256 depositAmount_);
event WithdrawToken(address userAddress_, uint256 withdrawAmount_);
event EtherSent(uint256 amount_);

constructor(address stakingToken_, address owner_, uint256 stakingPeriod_,uint256 fixedStakingAmount_, uint256 rewardPerPeriod_ ) Ownable(owner_) {
    stakingToken = stakingToken_;
    stakingPeriod = stakingPeriod_;
    fixedStakingAmount = fixedStakingAmount_;
    rewardPerPeriod = rewardPerPeriod_;
}

// Functions

// External functions
// 1. Deposit
function depositTokens(uint256 tokenAmountToDeposit_) external {
    require(tokenAmountToDeposit_ == 10, "Incorrect Amount");
    require(userBalance[msg.sender] == 0, "User already deposited");

    IERC20(stakingToken).transferFrom(msg.sender, address(this), tokenAmountToDeposit_);
    userBalance[msg.sender] += tokenAmountToDeposit_;
    elapsePeriod[msg.sender] = block.timestamp;

    emit DepositToken(msg.sender, tokenAmountToDeposit_);
}


// 2. Withdraw   
function withdrawTokens() external { // CEI PATTERN
    uint256 userBalance_ = userBalance [msg.sender];
    userBalance[msg.sender] = 0;
    IERC20(stakingToken).transfer(msg.sender, userBalance_);

    emit WithdrawToken(msg.sender, userBalance_);
    
}
// 3. Claim rewards
function claimRewards() external {
   // 1. Ckeck balance
   require(userBalance[msg.sender] == fixedStakingAmount, "Not staking");

   // 2. Calculate reward amount
   uint256 elapsePeriod_ = block.timestamp - elapsePeriod[msg.sender];
   require(elapsePeriod_ >= stakingPeriod, "Need to wait");

   // 3. Update state
   elapsePeriod[msg.sender] = block.timestamp;

   // 4. Transfer rewards
   (bool success,) = msg.sender.call{value: rewardPerPeriod}("");
   require(success, "Transfer failed");




}


// Internal functions

receive () external payable onlyOwner {
    emit EtherSent(msg.value);


}




function changeStakingPeriod(uint256 newStakingPeriod_) external onlyOwner {
    stakingPeriod = newStakingPeriod_;
    emit ChangeStakingPeriod(newStakingPeriod_);
}


//UserA: 1 wei - 100 tokens (100 * 10^18 == 10^20 wei)

}