// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

///@title ERC20 implementation.

/**
@dev This follows the OpenZeppelin implementation, in where the tokens have to be created by the {_mint} function and not in the constructor

 */
contract Bravo is IERC20 {
    //track the token balances of each account
    mapping(address => uint256) private _balances;

    //accounts approved to withdraw from a given account.
    //Also contains the sum _allowed to withdrawl
    mapping(address => mapping(address => uint256)) private _allowed;

    uint256 public override totalSuply;
    string public name;
    string public symbol;

    /**
 @dev sets value for the name and the symbol of the token
 the total suply is especified by the {_mint} function
  */

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    /**
    @dev returns the number of decimals.

    usually is 18 to imitate the the ether. 

    in this example im going to put in 36 just for fun and expleriment

    this function can be overwrited by the creator of the token
     */
    function decimals() public view virtual returns (uint8) {
        return 36;
    }

    ///@notice show the balance of tokens of an specific account
    ///@param account the account who we wants to see the balance
    function balanceOf(address account)
        public
        view
        virtual
        override
        returns (uint256)
    {
        return _balances[account];
    }

    ///@notice implements the trnasfer funciton
    ///@dev this implementation use callback functions
    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    /**@dev retrives the account (spender) which can transfer from the "owner" account. giv information about the actual account that can use {transferFrom}
    @return the remaining number of tokens that the spender is _allowed to spend
    */

    function allowance(address owner, address spender)
        public
        view
        virtual
        override
        returns (uint256)
    {
        return _allowed[owner][spender];
    }

    /**@dev approve an account "spender" to spend tokens from the "owner" (msg.sender)
    @return a boolean value indicating tha the operation was succesfull
    */
    function approve(address spender, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        _approve(msg.sender, spender, amount);
        return true;
    }

    /**
    @dev allows others person to spend an specific amount of tokens of the "sender"

    This functions its only _allowed to be called in the case that the owner of the tokens allows to the "recipient" tho spend their monney
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowed[sender][msg.sender];

        require(
            currentAllowance >= amount,
            "transfer amount exceeds allowances"
        );

        unchecked {
            _approve(sender, msg.sender, currentAllowance - amount);
        }

        return true;
    }

    /**
    Allows the owner of the token increase the amount that the other account can spend
     */
    function increaseAllowance(address spender, uint256 addedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            msg.sender,
            spender,
         _allowed[msg.sender][spender] + addedValue
        );
        return true;
    }

    /**
     * @notice  Decrease the amount of token that other account can spend from the owner of the token
     * @param substractedValue the value that the owner of the token wants to subtract of the avalible allowance.
     */
    function decreaseAllowance(address spender, uint256 substractedValue)
        public
        virtual
        returns (bool)
    {
        uint256 currentAllowance =  _allowed[msg.sender][spender];
        require(
            currentAllowance >= substractedValue,
            "decreased amount below zero"
        );

        unchecked {
            _approve(msg.sender, spender, currentAllowance - substractedValue);
        }

        return true;
    }


    /**
    @notice internal function, the equivalent of {transfer}
    @dev can be used to implement other functionalites behind the {transfer} */
    function _transfer (
        address sender,
        address recipient, 
        uint256 amount
    ) internal  {
        require(sender != address(0), "you cannot transfer from a zero address");
        require(recipient != address(0), "you cannot transfer to a zero address");

        ///this is a hook (Must check the hook concept)
        _beforeTokenTransfer(sender, recipient, amount);
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, " transfer amount exceeds balance");

        unchecked {
            _balances[sender] = senderBalance - amount;
        }

        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
        //another hook
        _afterTokenTransfer(sender, recipient, amount);
    }

    /**
    @dev creates 'amount' of tokens and assins it to ;account', this increase the total suply
     */

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "you cannot mint to a zero address");
        
        //here we put a zero address because those tokens are not being sending from anywere, we are creating it
        _beforeTokenTransfer(address(0), account, amount);

        totalSuply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        //here the same, we dont have a 'sender' account
        _afterTokenTransfer(address(0), account, amount);

    }

    /**@dev destru=oys 'amount' tokens from 'account', this reduce the total supply*/
    function _burn(address account, uint256 amount) internal virtual {

        require(account != address(0), "you cannot burn from a zero address");

        /**the use of address(0) in these hooks comes bacause we are 
        not sending tokens to other account, we want to destroy so we sent it to a zero address*/

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "you dont have enugh tokens to burn");
        unchecked {
            _balances[account] = accountBalance - amount;
        }

        totalSuply -= amount;

        emit Transfer(account, address(0), amount);


        _afterTokenTransfer(account, address(0), amount);
    }

        /**
        @notice Sets `amount` as the allowance of `spender` over the `owner` s tokens. 
        @dev this is an internal function that can be used to add other behaviors. is the equivalence to the {aprove} function
        
        */

        function _approve (
            address owner,
            address spender, 
            uint256 amount
        ) internal virtual {
            require(owner != address(0), "you cannot approve from a zero address");
            require(spender != address(0), "you cannot approve to a zero address");

            _allowed[owner][spender] = amount;
            emit Approval(owner, spender, amount);
        }

        /**@dev hook that is called before any transacction that have to be with transfer token (burn and mint included) */
        function _beforeTokenTransfer(
            address from, 
            address to, 
            uint256 amount
        ) internal virtual {}


        /**
        @dev hook that is called after any transaction that have to be with transfer tokens (including mint and burn)
         */
        function _afterTokenTransfer(
            address from,
            address to,
            uint256 amount
        ) internal virtual {}
}
