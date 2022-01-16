// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.2;

struct Todo {
    string content;
    bool completed;        
}

contract Todos {

    Todo[] public todos;
    address public owner;

    event AddedTodo(string content);
    event DeletedTodo(string content);
    event ChangedTodoState(Todo _todo);

    constructor(address _owner){
        owner = _owner;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Not Owner Of Contract");
        _;
    }

    function createTodo(string memory _content) public onlyOwner returns( Todo memory ) {
        Todo memory _newTodo = Todo(_content,false);

        todos.push(_newTodo);
        emit AddedTodo(_content);

        return _newTodo;
    }

    function deleteTodo(uint _index) public onlyOwner {
        require(_index < todos.length, "index out of bound");

        string memory _content = todos[_index].content;

        for (uint i = _index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        todos.pop();

        emit DeletedTodo(_content);
    }


    function toggleTodo(uint _index) public onlyOwner {
        require(_index < todos.length, "index out of bound");

        Todo storage _todo = todos[_index];
        _todo.completed = !_todo.completed;

        emit ChangedTodoState(_todo);
    }

    function lengthOfTodo() view public onlyOwner returns(uint) {
        return todos.length;
    }

}