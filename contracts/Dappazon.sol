// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
	
	//string public name;
	address public owner;

	struct Item {
		uint id;
		string name;
		string category;
		string image;
		uint cost;
		uint rating;
		uint stock;
	}

	struct Order {
		uint time;
		Item item;
	}

	mapping(uint => Item) public items;
	mapping(address => uint) public orderCount;
	mapping(address => mapping(uint => Order)) public orders;

	event Buy(address buyer, uint orderId, uint itemId);
	event List(string name, uint cost, uint quantity);

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	constructor(){
		//name = "Dappazon";
		owner = msg.sender; // person deploying the smart contract to the blockchain
	}

	// List products
	function listProducts(
		uint _id,
		string memory _name,
		string memory _category,
		string memory _image,
		uint _cost,
		uint _rating,
		uint _stock
	) public onlyOwner {

		// Create Item struct
		Item memory item = Item(
			_id,
			_name,
			_category,
			_image,
			_cost,
			_rating,
			_stock
		);

		// Save Item struct to blockchain
		items[_id] = item;

		// Emit an event
		emit List(_name, _cost, _stock);
	}

	// Buy products
	function buy(uint _id) public payable { // payble allows to recieve Crypto
		
		// Fetch item
		Item memory item = items[_id];

		// require enough ether to buy item
		require(msg.value <= item.cost);

		// require item is in stock
		require(item.stock > 0);
		// Create an order
		Order memory order = Order(block.timestamp, item);

		// Add order for user
		orderCount[msg.sender]++; // <-- Order ID
		orders[msg.sender][orderCount[msg.sender]] = order;

		// Subtract stock
		items[_id].stock = item.stock - 1;

		// Emit event
		emit Buy(msg.sender, orderCount[msg.sender], item.id);
	}

	// Withdraw funds
	function withdraw() public onlyOwner {
		(bool success, ) = owner.call{value: address(this).balance}("");
		require(success);
	}
}
