// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
    string private Name = "VedCoin";
    string private Symbol = "VED";
    address public owner;
    uint256 public totalSupplyValue;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this method");
        _;
    }

    //name
    function name() public view returns (string memory) {
        return Name;
    }

    //symbol
    function symbol() public view returns (string memory) {
        return Symbol;
    }

    //totalSupply
    function totalSupply() public view returns (uint256) {
        return totalSupplyValue;
    }

    //decimals
    function decimals() public pure returns (uint8) {
        return 8;
    }

    //account balance
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    //mint
    function mint(uint256 _amount) public onlyOwner {
        balances[owner] += _amount;
        totalSupplyValue += _amount;
    }

    //mintTo
    function mintTo(uint256 _amount, address _mintTo) public onlyOwner {
        balances[_mintTo] += _amount;
        totalSupplyValue += _amount;
    }

    //transfer
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balances[msg.sender] >= _value, "Balance less than amount");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    //burn
    function burn(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough amount");
        balances[msg.sender] -= _amount;
        totalSupplyValue -= _amount;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    //allowance
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        require(balances[msg.sender] >= _value, "Not enough amount");
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    //transferAllowance
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 allowance = allowances[_from][msg.sender];
        require(allowance >= _value, "Not enough amount");
        require(balances[msg.sender] >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        allowances[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
