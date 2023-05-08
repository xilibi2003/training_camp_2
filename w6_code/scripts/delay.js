async function advanceTime(provider, time) {
  await provider.send('evm_increaseTime',[time]);
}

async function advanceBlock(provider) {
  await provider.send('evm_mine');
}

async function delay1Day(provider) {
  let day = 86400;
  await advanceTime(provider, day);
  await advanceBlock(provider);
}

module.exports = {
  advanceTime,
  advanceBlock,
  delay1Day
}

// module.exports = async function(callback) {
//   let day = 86400;
//   await advanceTime(day);
//   await advanceBlock();
//   console.log("delay done");
// }