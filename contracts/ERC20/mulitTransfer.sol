// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;
import "./IERC20.sol";

contract multiTransfer{
    /**
    * 批量转账函数
    * 每个地址转入数量 amount_
    * 被转账的地址是一个地址数组 accounts_
    * 注意这里转的是ETH而不是Token
    **/

    function multiTransferEHT(uint256 amount_,address[] memory accounts_) public payable{
        // payable 函数如果需要接受ETH就需要加上这个标识符声明 可以获取到 msg.value
        uint accountsNum = accounts_.length; // 需要转账的地址数量
        uint totalBalance = accountsNum * amount_; // 需要转账总量
        require(msg.value >= totalBalance,"You don't have enough ETH");
        for(uint i=0;i<accountsNum;i++){
            payable(accounts_[i]).transfer(amount_);
        }
    }

    /**
    * 批量转账Token
    * 每个地址转入数量 amount_
    * 接收转账地址是一个地址数组 accounts_
    * 代币的合约地址 contract_
    **/
    function multiTransferToken(uint amount_,address[] memory accounts_,address contract_) public {
        uint balance = IERC20(contract_).balanceOf(msg.sender); // 获取到合约调用者的余额
        uint total = amount_ * accounts_.length; // 本次交易需要的合约调用者的代币总量
        require(total >= balance,"You don't have enough Token");
        for(uint i=0; i<accounts_.length; i++){
            // 合约用户不能直接给目标账户发送Token，本质上是通过合约在中间转发
            IERC20(contract_).transferFrom(msg.sender,accounts_[i],amount_);
        }
        
    }
}
