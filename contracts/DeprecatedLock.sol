// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Import the "Ownable" interface from OpenZeppelin, that implements
// the "onlyOwner" modifier we use to make sure only the contract
// owner can operate the smart-lock
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Simple Smart-Lock
 * @dev Very simple smart contract to manage the state of a smart-lock
 */
contract Lock is Ownable {
    /** Store the smart lock state */
    bool private _opened;
    
    /** Initialise the lock in a closed state */
    constructor (bool opened) { _opened = opened; }

    /** Opens the lock */  
    function open() public onlyOwner() { _opened = true; }

    /** Closes the lock */  
    function close() public onlyOwner() { _opened = false; }

    /** Returns true if the lock is open */  
    function isOpen() public view onlyOwner() returns (bool) { return _opened == true; }
}
