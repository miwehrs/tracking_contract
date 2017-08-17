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

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	event Transfer(address indexed _from, address indexed _to);

	function component(string componentType, string id) {
		HighValuePart.componentType = componentType;
		HighValuePart.id = id;
		HighValuePart.creator = msg.sender;
	}

	/**
	 * Transfer component from owner to other address
	 * @param  address receiver
	 * @return bool success
	 */
	function transferComponent(address receiver) onlyOwner returns(bool success) {
		uint count = 0;

		while (owners[count]) {
			count++;
		}
		owners[count] = msg.sender;
		owner = msg.sender;
		Transfer(msg.sender, receiver);

		return true;
	}

	/**
	 * Return history of owners
	 * @return mapping History of addresses that owned the component
	 */
	function checkPrevOwners() returns(mapping(uint => address)) {
		return owners;
	}

	/**
	 * Return creator of component
	 * @return address creator
	 */
	function checkCreator() returns(address) {
		return HighValuePart.creator;
	}

	/**
	 * Return type of component
	 * @return string type
	 */
	function getType() returns(string) {
		return HighValuePart.componentType;
	}

	/**
	 * Return id of component
	 * @return uint256 identification number
	 */
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
