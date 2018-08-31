module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
    networks: {
        dev: {
            host:"localhost",
            port:7545,
            network_id: "*",
            gas:6000000
        }
    }
};
