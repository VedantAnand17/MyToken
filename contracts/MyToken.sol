// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
    string public Name = "VedCoin";
    address public owner;
    uint public totalSupply;
    mapping (address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this method");
        _;
    }

    //mint
    function mint(uint _amount) public onlyOwner {
        balances[owner] += _amount;
        totalSupply += _amount;
    }

    //mintTo
    function mintTo(uint _amount, address _mintTo) public onlyOwner {
        balances[_mintTo] += _amount;
        totalSupply += _amount;
    }

    //transfer
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount, "Balance less than amount");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }

    //burn
    function burn(uint _amount) public {
        require(balances[msg.sender] >= _amount , "Not enough amount");
        balances[msg.sender] -= _amount;
        totalSupply -= _amount;
    }
}