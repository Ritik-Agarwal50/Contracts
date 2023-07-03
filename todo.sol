// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
contract todo{
    struct Todo{
        string task;
        bool completed;
    }   
    event taskAdd(string task);
    event taskComplete(string task);
    event updateTask(uint index, string task);

    Todo[] public todos;

    function create(string calldata _task) external {
        todos.push(Todo({
            task: _task,
            completed:false
        }));
        emit taskAdd(_task);
    }

    function complete(uint _index) external{
        Todo memory todo = todos[_index];
        todo.completed= true;
        emit taskComplete(todo.task);
    }

    function update(uint _index , string calldata _task) external{
        todos[_index].task=_task;
        emit updateTask(_index,_task);
    }
    function get(uint _index) external view returns(string memory , bool){
        Todo memory todo = todos[_index];
        return(todo.task,todo.completed);
    }
}