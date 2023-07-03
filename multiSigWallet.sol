// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
contract multiSigWallet{

    //this will create transaction
    event deposit(address indexed sender , uint amount);

    //this will submit the traansaction to owners
    event submit(uint indexed txId);

    //owner will approve for transaction
    event approval(address indexed owner, uint indexed txId);

    //if owner change there mind they can revoke the decisons
    event revoke(address indexed owner,uint indexed txId);

    //This will show which transaction is executed by the oweners 
    event executed(address indexed owner ,uint indexed txId);


    //this will transaction structure
     struct tx{
        address to,
        uint amount,
        bool executed,
        bytes data,
        uint noOfConfirmation
     };


     //this will make owner array
    address[] public owners;


    //this maaping will do if msg.sender is true than it will executed else it will false
    mapping (address => bool)public isOwner;


    //This will store the number of approval required
    uint public required;


    //this will store each of the transacction
    Transaction[] public transactions;

    //it see if  txId=>owner=>bool. this will indicated wheather tx is approved by owner or not.
    mapping(uint=>mapping(address=>bool)) public approved;


    //it will check if there is enough owner and the number of require approval
    constructor(address[] memory _owners,uint _require){

        //this is checking the length of owner is greater than 0.
        require(_owners.length>0,"Owners are required");

        //this checking is require is greater than 0 and less than owners length.
        require(_require > 0 && _require <= _owners.length,"invalid require number of owner..." );
        //in this we are checking the adress index 0 should not have same address
        //and there cannot be any duplicate address(owner).

        for(uint i; i<_owners.length;i++){
            address owner = _owners[i]
            require(owner != address[0],"Invalid owner");
            require(!isOwner[owner],"Duplicate owner is not allowed");
            //if owner is true we will push it into the address of owners array
             isOwner[owner] = true;
             owners.push(owner);
        }
        //this will store the number of approval require froom constructor
        required=_require

    }

    receive() external payable{
        emit deposit(msg.sender,msg.value);
    }  

    modifier onlyOwner {
        require(isOwner[msg.sender],"not owner");
        _;
    }

    modifier txExist(uint _txId){
        require(_txId < transactions.length,"tx does not exist...");
        _;
    }

    modifier notExecuted(uint _txId){
        require(!transactions[_txId].executed,"tx is already executed");
        _;
    }

    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender], "tx is already approved");
        _;  
    }

    function submit(address _to,uint _value,bytes calldata _data ) public onlyOwner{
        transactions.push(Transaction({
            to: _to,
            amount: _value,
            data :_data,
            executed: false,
            noOfConfirmation: 0
        }));
        emit submit(transactions.length-1);
    }
    function approve(uint _txId) external onlyOwner txExist(_txId) notExecuted(_txId) notApproved(_txId){

        Transaction storage transaction = transactions[_txId];
        transactions.noOfConfirmation +=1;
        approved[_txId][msg.sender]= true;
        emit approval(msg.sender,_txId);
    } 

    function execute(uint _txId) external txExist(_txId) notExecuted(_txId) {
        Transaction storage transaction = transactions[_txId];
        require(transactions.noOfConfirmation >= required , " can not execute..");
        transaction.executed = true;
        emit executed(msg.sender,_txId);
    }

    function revoke(uint _txId) external onlyOwner notExecuted(_txId) txExist(_txId){
        Transaction storage transaction = transactions[_txId];
        require(approved[_txId][msg.sender],"tx not approved...");
        transaction.executed -=1;
        approved[_txId][msg.sender] = false;


        emit revoke(msg.sender,_txId);
    }

    function getOwner() public view returns(address[] memory){
        return owner;
    }

    function getTransaction(uint _txId) public view returns(
        address to,
        uint amount,
        bool executed,
        bytes data,
        uint noOfConfirmation
    ){
        Transaction storage transaction = transactions[_txId];
        return(
            transaction.to,
            transaction.amount,
            transaction.executed,
            transaction.data,
            transaction.noOfConfirmation
        );
    }
}