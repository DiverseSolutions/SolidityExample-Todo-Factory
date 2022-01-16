// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./Todos.sol";

contract TodosFactory {
    mapping(address => Todos) public todosFactory;
    uint addressLength;

    address owner;

    event AddedTodo(address todoOwner,address todo);
    event DeletedTodo(address todoOwner,address todo);

    constructor(){
        addressLength = 0;
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Not Owner Of Contract");
        _;
    }

    function createTodo() public {
        require(address(todosFactory[msg.sender]) == address(0),"You already have todo contract.");

        Todos _todo = new Todos(msg.sender);

        todosFactory[msg.sender] = _todo;

        addressLength += 1;

        emit AddedTodo(msg.sender,address(_todo));
    }

    function removeTodo(address _todosAddress) public onlyOwner {
        require(address(todosFactory[_todosAddress]) != address(0),"There isnt any todo on this address.");

        addressLength -= 1;

        delete todosFactory[_todosAddress];
    }


    function getTodosLength() public view returns ( uint ) {
        return addressLength;
    }

}