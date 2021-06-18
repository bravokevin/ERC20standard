pragma solidity ^0.7.0;


///@dev interface for the ERC20 implementation. Following the EIP20

contract IERC20 {

    /**
    * FUNCTIONS THAT MUST BE IMPLEMENTEDT
    */

    //Returns the total token suply
    function totalSuply() public view returns(uint256){}


    //Returns the total balance of the "_owner" account
    function balanceOf(address _owner) public view returns (uint256 balance){}
    
    // Transfers _value amount of tokens to address _to

    ///@dev must fire the transfer event. Throws if the essage caller’s account balance does not have enough tokens to spend.
    function transfer(address _to, uint256 _value) returns(bool succes){}


    //Transfers _value amount of tokens from address _from to address _to

    ///@dev must fire transfer event. The _from account first has to authorize to do this operation
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){}


    //allows to withdraw from the owner account multiple times, until the amount was reached. 

    function approve(address _spender, uint256 _value) public returns (bool success){}

    //Returns the amount which _spender is still allowed to withdraw from _owner.
    function allowance(address _owner, address _spender ) public view returns (uint256 remaining){}


    /**
    * EVENTS
     */

    //Trigger when token is transfer, including creatinos of tokens.
    ///@dev also have to be trigger when transfer 0 values
    event Transfer(addresss indexed _owner, address indexed _spender, uint256 _value);
    
    //Trigger in a succesfull call of "approve" function >>
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}