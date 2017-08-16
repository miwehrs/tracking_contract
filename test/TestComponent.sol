pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Component.sol";

contract TestComponent {

  function testInitialBalanceUsingDeployedContract() {
    Component comp = Component(DeployedAddresses.Component());

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 Component initially");
  }

  function testInitialBalanceWithNewComponent() {
    Component comp = new Component("Test Component", 123456);

    string expectedType = "Test Component";
    string expectedId = 123456;
    Assert.equal(comp.getType(tx.origin), expected, "Component type should be \'Test Component\'");
  }

}
