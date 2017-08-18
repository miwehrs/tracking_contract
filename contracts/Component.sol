pragma solidity ^0.4.2;

contract Component {

	struct HighValuePart {
		string componentType;
		uint256 id;
		address creator;
		address owner;
		mapping (uint => address) ownerHistory;
	}
	uint numComponents;

	mapping (uint => HighValuePart) components;

	event Transfer(uint componentId, address indexed _from, address indexed _to);

	/**
	 * Create new component
	 * @param  componentType High-value part type
	 * @param  compId        High-value part ID
	 * @return componentId   Component's ID in mapping components
	 */
	function createComponent(string componentType, string compId) returns(uint componentId) {
		componentId = numComponents++;
		components[componentId] = HighValuePart(componentType, compId, msg.sender, msg.sender);
		components[componentId].ownerHistory[0] = msg.sender;

		return componentId;
	}

	/**
	 * Transfer component from owner to other address
	 * @param  compId  Component's ID
	 * @param  address receiver
	 * @return bool    success
	 */
	function transferComponent(uint compId, address receiver) returns(bool success) {
		uint ownerTemp = 0;

		// Address could own component twice in history
		while (components[compId].ownerHistory[ownerTemp]) {
			ownerTemp++;
		}
		if (components[compId].owner == msg.sender) {
			components[compId].ownerHistory[ownerTemp] = receiver;
			components[compId].owner = receiver;

			return true;
		}

		return false;
	}

	/**
	 * Return componenets belonging to an address
	 * @param  compId  Component's ID
	 * @return mapping List of components
	 */
	function getComponents() returns(mapping(uint => HighValuePart)) {
		address requester = msg.sender;
		mapping (uint => HighValuePart) reqComponents;
		uint counter = 0;
		for (uint i = 0; i < numComponents; i++) {
			if (components[i].owner == requester) {
				reqComponents[counter] = components[i];
				counter++;
			}
		}

		return reqComponents;
	}

	/**
	 * Return history of owners
	 * @param  compId  Component's ID
	 * @return mapping History of addresses that owned the component
	 */
	function getPrevOwners(compId) returns(mapping(uint => address)) {
		return components[compId].ownerHistory;
	}

	/**
	 * Return creator of component
	 * @param  compId  Component's ID
	 * @return address creator
	 */
	function getCreator(compId) returns(address) {
		return components[compId].creator;
	}

	/**
	 * Return type of component
	 * @param  compId Component's ID
	 * @return string type
	 */
	function getType(compId) returns(string) {
		return components[compId].componentType;
	}

	/**
	 * Return id of component
	 * @param  compId  Component's ID
	 * @return uint256 identification number
	 */
	function getId(compId) returns(uint256) {
		return components[compId].id;
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
