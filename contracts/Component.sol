pragma solidity ^0.4.2;

// import "./ConvertLib.sol";

contract Component {
	mapping (uint => address) owners;
	address owner;

	struct HighValuePart {
		string componentType;
		uint256 id;
		address creator;
	}

	event Transfer(address indexed _from, address indexed _to);

	function component(string componentType, string id) {
		HighValuePart.componentType = componentType;
		HighValuePart.id = id;
	}

	function transferComponent(address receiver) returns(bool success) {
		uint count = 0;

		while (owners[count]) {
			count++;
		}
		owners[count] = msg.sender;
		owner = msg.sender;
		Transfer(msg.sender, receiver);

		return true;
	}

	function checkPrevOwners() returns(mapping) {
		return owners;
	}

	function checkCreator() returns(address) {
		return HighValuePart.creator;
	}

	function getType() returns(string) {
		return HighValuePart.componentType;
	}

	function getId() returns(uint256) {
		return HighValuePart.id;
	}

/*
	function sendCoin(address receiver, uint amount) returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) returns(uint) {
		return balances[addr];
	}
*/
}
