var Counter = artifacts.require("Counter");

module.exports = async function(callback) {
  var counter = await Counter.deployed()

  await counter.count();
  let value = await counter.counter();

  console.log("current conter value:" + value);
}