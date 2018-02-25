//var HDWalletProvider = require("truffle-hdwallet-provider");

var mnemonic = "apple social axis idea spoil humble sudden account eight original rookie tenant";

module.exports = {
  migrations_directory: "./migrations",
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/vw2OdLrX5r9yQZoTwS0V")
      },
      network_id: 3
    }   
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 500
    }
  } 
};