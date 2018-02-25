pragma solidity ^0.4.17;

import "./Cache.sol";

contract TerraDrop {
    
    address public owner;
    address[] public deployedCaches;
    mapping(address => bool) caches;
    
    event CacheCreated(address newCache, address _owner);
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function TerraDrop ()
        public
    {
        owner = msg.sender;
    }
    
    function createCache(string secret)
        public
        payable
        returns (address)
    {
        address newCache = new Cache(msg.sender, secret);
        deployedCaches.push(newCache);
        CacheCreated(newCache, msg.sender);
        return newCache;
    }
    
    function changeStatus (address cacheAddress, bool status)
        public
        onlyOwner
    {
        require(caches[cacheAddress]);
        Cache cacheInstance = Cache(cacheAddress);
        assert(cacheInstance.changeStatus(status));
    }
    
    function changeAllStatus (bool newStatus)
        public
        onlyOwner
    {
        for(uint i = 0; i < deployedCaches.length; i++)
        {
             Cache cacheInstance = Cache(deployedCaches[i]);
             if(cacheInstance.activeStatus() != newStatus)
             {
                assert(cacheInstance.changeStatus(newStatus));
             }
        }
    }
    
}


