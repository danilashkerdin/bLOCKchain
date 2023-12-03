// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Lock is Ownable(msg.sender) {

    /** Store the smart lock state */
    bool private _opened;

    /** Event lock should subscribe for */
    event OpenedEvent();
    event ClosedEvent();

    /** Access modes for users */
    enum Privileges { None, User, Admin }
    Privileges constant defaultPrivilege = Privileges.None;

    /** Users to privileges mapping */
    mapping(address => Privileges) private _customers;

    /** @dev Throws if called by any account other than the Customer. */
    modifier onlyCustomer() {
        _checkCustomer();
        _;
    }

    /** @dev Throws if the sender is not the Customer. */
    function _checkCustomer() internal view virtual {
        if ( (_customers[_msgSender()] != Privileges.Admin) && (_customers[_msgSender()] != Privileges.User) ) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /** @dev Throws if called by any account other than the Admin. */
    modifier onlyAdmin() {
        _checkAdmin();
        _;
    }

    /** @dev Throws if the sender is not the Admin. */
    function _checkAdmin() internal view virtual {
        if (_customers[_msgSender()] != Privileges.Admin) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    // Basic Lock methods
    
    /** Initialise the lock in a chosen state */
    constructor (bool opened) { _opened = opened; }

    /** Opens the lock */  
    function open() public onlyCustomer() { _opened = true; emit OpenedEvent(); }

    /** Closes the lock */  
    function close() public onlyCustomer() { _opened = false; emit ClosedEvent(); }

    /** Returns true if the lock is open */  
    function isOpen() public view onlyCustomer() returns (bool) { return _opened == true; }

    // Roles settings

    /** Add customer to customers mapping with privileges */
    function _addCustomer(address customerAddress, Privileges privilege) internal {
        _customers[customerAddress] = privilege;
    }

    /** Remove customer from customers mapping with privileges */
    function _removeCustomer(address customerAddress) internal {
        delete _customers[customerAddress];
    }

    /** Add admin to customers mapping with privileges */
    function addAdmin(address adminAddress) public onlyOwner() {
        _addCustomer(adminAddress, Privileges.Admin);
    }

    /** Remove admin from customers mapping with privileges */
    function removeAdmin(address adminAddress) public onlyOwner() {
        _removeCustomer(adminAddress);
    }

    /** Add user to customers mapping with privileges */
    function addUser(address userAddress) public onlyAdmin() {
        _addCustomer(userAddress, Privileges.User);
    }

    /** Remove user from customers mapping with privileges */
    function removeUser(address userAddress) public onlyAdmin() {
        _removeCustomer(userAddress);
    }

    function getPrivileges() public view returns (Privileges) {
        return _customers[msg.sender];
    }
}
