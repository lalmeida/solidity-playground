//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Ownable.sol";

contract Destroyable is Ownable {

    /**
     * Destroy this contract, sending any remaining funds to the owner.
     */
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

}