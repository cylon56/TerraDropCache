pragma solidity ^0.4.17;

contract Cache {
    
    address public owner;
    address public admin;
    uint public fundsBalance;
    bytes32 secretHash;
    
    bool public activeStatus = true;

    event CacheClaimed(address claimant, uint amount);
    event StatusChanged(bool newStatus);
    event FundsAdded(uint amountAdded, uint newBalance);
    event Withdrawal(uint amount);
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function Cache(address _owner, string secret)
        public
    {
        owner = _owner;
        admin = msg.sender;
        secretHash = keccak256(secret);
    }
    
    //fallback function for accepting Ether
    function ()
        public
        onlyOwner
        payable 
    {
        require(activeStatus);
        FundsAdded(msg.value, this.balance);
    }
        
    function claimCache (string secret)
        public
        returns (bool)
    {
        require(activeStatus);
        require(this.balance != 0);
        require(keccak256(secret) == secretHash);

        CacheClaimed(msg.sender, this.balance);
        assert(msg.sender.send(this.balance));
        
        return true;
    }
    
    function changeSecret(string newSecret)
        public
        onlyOwner
        returns (bool)
    {
        secretHash = keccak256(newSecret);
        return true;
    }
    
    
    function changeStatus(bool newStatus)
        public
        onlyOwner
        returns (bool)
    {
        require(newStatus != activeStatus);
        StatusChanged(newStatus);
        activeStatus = newStatus;
    }
    
    function withdraw()
        public
        onlyOwner
        returns (bool)
    {
        require(this.balance != 0);
        Withdrawal(this.balance);
        owner.transfer(this.balance);
        return true;
    }
    
}
