pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Component.sol";

contract TestMetacoin {

  function testInitialBalanceUsingDeployedContract() {
    Component meta = Component(DeployedAddresses.Component());

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 Component initially");
  }

  function testInitialBalanceWithNewComponent() {
    Component meta = new Component();

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 Component initially");
  }

}
