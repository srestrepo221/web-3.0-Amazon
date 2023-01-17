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

	mapping(uint => Item) public items;

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
	) public {

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
	}

	// Buy products

	// Withdraw funds
}
