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
		owner = msg.sender;
		startDate = block.timestamp;
	}
	
	function buyTicke() public payable returns(uint256){ 
		require(msg.value == ticketPrice);
		require(block.timestamp<startDate +(day*84600));
		owner.transfer(msg.sender/10);
        ticketCode++;
        invested +=(msg.value*90)/100;
        tickets[ticketCode]=Ticket(ticketCode,block.timestamp,msg.sender,false);
        emit buyTicket(msg.sender,msg.value,ticketCode);
        return ticketCode;
        
	}

    function startLottery() public{ 
        require(msg.sender==owner);
        require(block.timestamp<startDate +(day*84600));
        require(isLotteryDone==false);
        uint256 winnerIndex = random(ticketCode);
        tickets[winnerIndex].win = true;
        tickets[winnerIndex].member.transfer(invested);
        isLotteryDone = true;
        emit winner(tickets[winnerIndex].member,invested,winnerIndex);

    }
    function random(uint count) private view returns(uint){
       return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty)))% count;
    }
}