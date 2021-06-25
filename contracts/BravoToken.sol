// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract BravoToken is ERC20 {
    constructor() ERC20 ("Bravo", "BRV"){}

    function mint(uint256 amount) external {
        _mint(msg.sender, amount);
    }

    function burn(address account, uint256 amount) external {
        _burn(account, amount);
    }
}