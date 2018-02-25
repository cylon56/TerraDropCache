const TerraDrop = artifacts.require("TerraDrop");
const Cache = artifacts.require("Cache");

contract('TerraDrop', async (accounts) => {

let terraDrop;
let secret = "123";
let cache1;
let cache2;
let cache3;

 beforeEach(async function() {
        terraDrop = await TerraDrop.new({
        	from: accounts[0]
        });
    });

  it("should deploy the cache", async () => {

     await terraDrop.createCache(secret);

     let cache = await terraDrop.deployedCaches(0);

     assert.ok(balance.valueOf(), 10000);
  });

})