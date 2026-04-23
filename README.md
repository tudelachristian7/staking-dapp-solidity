# 🧱 Staking DApp (Solidity + Foundry)

![Coverage](https://img.shields.io/badge/Coverage-100%25-brightgreen)
![Tests](https://img.shields.io/badge/Tests-14%20passing-success)
![CI](https://img.shields.io/badge/CI-passing-brightgreen)

A staking protocol built with **Solidity** and **Foundry**, featuring an ERC20 token, fixed staking logic, time-based rewards in Ether, and full test coverage with automated CI.

This project showcases **real-world smart contract development practices**, including secure contract design, testing strategies, and continuous integration workflows.

---

## 🚀 Overview

This repository implements a simple but complete staking system where:

* Users stake a fixed amount of ERC20 tokens
* Rewards are distributed in ETH after a defined time period
* The contract must be funded by the owner to pay rewards

The goal of this project is to demonstrate **core DeFi mechanics** in a clean, testable, and production-oriented way.

---

## 🏗️ Architecture

### 📄 `StakingToken.sol`

ERC20 token used for staking.

**Key characteristics:**

* Built using OpenZeppelin
* Users can mint tokens freely (for testing/demo purposes)

```solidity
function mint(uint256 amount_) external {
    _mint(msg.sender, amount_);
}
```

---

### 📄 `StakingApp.sol`

Core staking contract responsible for:

* Token deposits
* Withdrawals
* Reward distribution
* Owner configuration

---

## ⚙️ Staking Logic

### 🔐 Deposit

* Users must deposit a **fixed amount (10 tokens)**
* Only **one active stake per user**

```solidity
require(tokenAmountToDeposit_ == 10, "Incorrect Amount");
require(userBalance[msg.sender] == 0, "User already deposited");
```

---

### 💸 Withdraw

* Users can withdraw their tokens at any time
* Uses **CEI pattern (Checks → Effects → Interactions)**

---

### ⏱️ Claim Rewards

* Rewards are distributed in ETH
* Users must wait a defined staking period

```solidity
require(elapsed >= stakingPeriod, "Need to wait");
```

* Rewards are sent using a low-level call:

```solidity
(bool success,) = msg.sender.call{value: rewardPerPeriod}("");
```

---

### 🏦 Contract Funding

* The contract must hold ETH to distribute rewards
* Only the owner can fund it

```solidity
receive() external payable onlyOwner {}
```

---

## 🧪 Testing

This project includes a **comprehensive test suite using Foundry (Forge)**.

### ✅ Coverage: 100%

* Lines: 100%
* Statements: 100%
* Branches: 100%
* Functions: 100%

### 🔍 What is tested

#### Staking Logic

* Reject incorrect deposit amounts
* Prevent multiple deposits
* Track user balances correctly
* Store timestamps properly

#### Withdrawals

* Safe withdrawal without deposit
* Correct token return behavior

#### Rewards

* Revert if user is not staking
* Revert if staking period not met
* Revert if contract has no ETH
* Correct ETH reward distribution

#### Owner Features

* Only owner can update staking period
* Contract correctly receives ETH

---

## 🔄 CI / Automation

GitHub Actions is used to ensure code quality on every push:

* `forge fmt --check`
* `forge build`
* `forge test`

This guarantees that:

* Code is properly formatted
* Contracts compile correctly
* All tests pass before merging

---

## 🛠️ Tech Stack

* **Solidity** `^0.8.29`
* **Foundry (Forge)**
* **OpenZeppelin Contracts**
* **GitHub Actions (CI)**

---

## ▶️ How to Run

### Install dependencies

```bash
forge install
```

### Run tests

```bash
forge test
```

### Run coverage

```bash
forge coverage
```

---

## 📌 Design Decisions

### Fixed Staking Amount

Simplifies logic and avoids edge cases.

### Single Stake Per User

Prevents complexity in reward calculations.

### ETH Rewards

Simulates real-world DeFi reward mechanisms.

### Public Mint (Token)

Used for testing purposes only.

---

## ⚠️ Limitations

* No support for multiple staking positions
* No reward compounding
* No slashing mechanism
* No frontend integration
* No upgradeability

---

## 🔐 Security Considerations

* Uses CEI pattern for withdrawals
* Input validation via `require`
* Reward transfer may fail if contract lacks ETH
* No reentrancy guard (acceptable for this scope, not production-ready)

---

## 📈 Future Improvements

* Add multiple staking positions per user
* Implement APR-based rewards
* Add ERC20 reward token option
* Integrate frontend (React + Wagmi)
* Add ReentrancyGuard
* Add advanced testing (fuzz / invariant)

---

## 👨‍💻 Author

Developed as part of a Blockchain & DeFi learning journey, focusing on building solid foundations in smart contract development and testing.

---

## ⭐ Notes

This project is designed to demonstrate:

* Understanding of DeFi primitives
* Ability to write secure Solidity code
* Strong testing practices (100% coverage)
* Familiarity with modern Web3 tooling

---

