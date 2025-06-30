//Lottery Contract

//SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <=0.9.0;

/*
5 user (struct) .....  name , accountNo, balance = 10000, lotteryNo 
virtual acc 
allocation name , accNo , balance , lotteryNo
entry fee per user  1000    (and add in virtual acc)
check account >entry  +-
input lucky number
20% for virtual acc and 80 % as reward
virtual acc > reward  +-
display (lottery no , amount and name)
*/


contract lottery
{
    
    struct User
    {
        string name;
        address accountNo;
        uint balance ;
        uint lotteryNo;
    }

    
    address public owner;
    uint public entryFee = 1000;

    mapping(address => uint) public virtualBal ;

    User[5] public participant;

    constructor(){
        owner = msg.sender ;
        virtualBal[msg.sender] = 0;

        participant[0] = User("rahul" , 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 , 1000 , 1111);
        participant[1] = User("abhay" , 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB , 1000 , 2222);
        participant[2] = User("amit" , 0x17F6AD8Ef982297579C203069C1DbfFE4348c372 , 1000 , 3333);
        participant[3] = User("deepesh" , 0x617F2E2fD72FD9D5503197092aC168c91465E7f2 , 1000 , 4444);
        participant[4] = User("abhishek" , 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c , 1000 , 5555);
    }

    function setEntry() public
    {
        for(uint i =0 ; i < participant.length;i++){
            require(participant[i].balance >= entryFee, "insuffiecient");
            participant[i].balance -= entryFee;
            virtualBal[owner] += entryFee;
        }
    }


     function getALLEntry() public view returns (string[] memory names , uint[] memory lotteryNos)
    {
        names = new string[](participant.length);
        lotteryNos= new uint[](participant.length);
        for(uint i =0 ; i < participant.length;i++){
            names[i]=participant[i].name;
            lotteryNos[i]= participant[i].lotteryNo;
        }
        
    }

    bool public rewardGiven;
    uint public luckyNum = 5555;
    uint public reward = (virtualBal[owner]*80)/100;
    function setWinner() public
    {
        require(!rewardGiven, "Reward already distributed");
        require(virtualBal[owner] >= participant.length * entryFee, "Insufficient virtual balance");
        for(uint i =0 ; i < participant.length;i++)
        {
            if( participant[i].lotteryNo == luckyNum)
            {
                virtualBal[owner] -=  reward ;
                 participant[i].balance += reward;
                 rewardGiven = true;
            }

        }

    }


    function winner() public view returns(string memory){
        for(uint i =0 ; i < participant.length;i++)
        {
            if( participant[i].lotteryNo == luckyNum)
            {
                return participant[i].name ;
            }
        }
        return "no winner";
    }



}












 
