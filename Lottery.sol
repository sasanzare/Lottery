// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract Lottery{
    struct Ticket{
        uint256 id;
        uint256 createDateTime;
        address payable member;
        bool win; 
    }

    address payable public owner;
    mapping(uint256=>Ticket) public tickets;
    uint256 ticketPrice = 100;
    uint256 ticketCode = 0;
    uint256 invested = 0;
    uint256 public startDate;
    uint256 public day;
    bool isLotteryDone;

    event buyTicket(address indexed addr,uint256 amount,uint256 ticketCode);
    event winner(address indexed addr,uint256 amount,uint256 ticketCode);
    
    constructor(uint16 _day){
        day=_day;
    }

    function buyTicket() public payable returns(uint256){ 

    }

    function startLottery() public{ 

    }
    function random(uint count) private view returns(uint){

    }
}