// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)
pragma solidity ^0.8.0;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract ERC20 is IERC20{
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Test";
    string public symbol = "TEST";
    uint public decimals = 18;

    function transfer(address recipient,uint amount) external returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender,recipient,amount);
        return true;
    }
    function approve(address spender,uint amount) external returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }
    function transferFrom(address sender,address recipient,uint amount) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender,recipient,amount);
        return true;
    }

    function mint(uint amount) external{
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0),msg.sender,amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender,address(0),amount);
    }
}