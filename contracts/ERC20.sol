pragma solidity ^0.7.0;

import "./IERC20.sol."


///@title ERC20 implementation.

/**
@dev This follows the OpenZeppelin implementation, in where the tokens have to be created by the {_mint} function and not in the constructor

 */
contract ERC20 is IERC20 {
    //track the token balances of each account
    mapping(address => uint256) private _balances;

    //accounts approved to withdraw from a given account.
    //Also contains the sum allowed to withdrawl 
    mapping (address  => mapping(address => uint)) private allowed;

    uint256 public totalSuply;
    string public name;
    string public symbol;

 /**
 @dev sets value for the name and the symbol of the token
 the total suply is especified by the {_mint} function
  */ 

  constructor(string memory _name, string memory _symbol){
        name = name_;
        symbol = symbol_;
  }

    /**
    @dev returns the number of decimals.

    usually is 18 to imitate the the ether. 

    in this example im going to put in 36 just for fun and expleriment

    this function can be overwrited by the creator of the token
     */
    function decimals() public virtual view returns(uint8){
        return 36;
    }

    ///@notice show the balance of tokens of an specific account
    ///@param account the account who we wants to see the balance
    function balanceOf(address account) public view virtual override returns(uint256){
        return balances[account];
    }


    ///@notice implements the trnasfer funciton
    ///@dev this implementation use callback functions 
    function transfer(address recipient, uint256 amount) public virtual override returns(bool){
        _transfer(_msgSender(), recipient, amount);
        return true;
    }


    ///@dev retrives the account (spender) which can transfer from the "owner" account
    function allowance(address owner, address spender) public view virtual override returns(uint256){
        return allowed[owner][spender];
    }

    ///@dev approve an account "spender" to spend tokens from the "owner" 
    function approve(address spender, uint256 amount) public virtual override returns(bool){
        _approve(_msgSender(), spender, amount);
        return true
    }




}