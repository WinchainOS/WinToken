// Config
const config = require('../truffle.js');

const Web3 = require('web3');

var SafeMathLib = artifacts.require("./SafeMathLib.sol");
var Winchain = artifacts.require("./Winchain.sol");

module.exports = function (deployer) {
    web3: Web3,
    deployer.link(SafeMathLib, Winchain);
    deployer.deploy(Winchain);
};