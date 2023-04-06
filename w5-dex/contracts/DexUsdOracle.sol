//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol';

import "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import './libs/FixedPoint.sol';
import './libs/UniswapV2OracleLibrary.sol';


interface IUSDOracle {
  // Must 8 dec, same as chainlink decimals.
  function getPrice(address token) external view returns (uint256);
}


contract DexUSDOracle is IUSDOracle, Ownable {
  using FixedPoint for *;
  uint public period;

  IUniswapV2Pair public pair;
  IUSDOracle public baseOracle;
  address public token0;
  address public token1;

  uint    public price0CumulativeLast1Period;
  uint    public price1CumulativeLast1Period;
  uint32  public blockTimestampLast1Period;
  FixedPoint.uq112x112 public price0Average1Period;
  FixedPoint.uq112x112 public price1Average1Period;

  event PeriodChanged(uint newPeriod);

  constructor(address _baseOracle, address _pair) {
      period = 30 minutes;

      baseOracle = IUSDOracle(_baseOracle);
      pair = IUniswapV2Pair(_pair);

      token0 = pair.token0();
      token1 = pair.token1();
      price0CumulativeLast1Period = pair.price0CumulativeLast(); // fetch the current accumulated price value (1 / 0)
      price1CumulativeLast1Period = pair.price1CumulativeLast(); // fetch the current accumulated price value (0 / 1)
      
      uint112 reserve0;
      uint112 reserve1;
      (reserve0, reserve1, blockTimestampLast1Period) = pair.getReserves();
      require(reserve0 != 0 && reserve1 != 0, 'NO_RESERVES'); // ensure that there's liquidity in the pair

      uint decimal0 = IERC20Metadata(token0).decimals();
      uint decimal1 = IERC20Metadata(token1).decimals();

      require(decimal0 == 18 && decimal1 == 18, 'MISMATCH_DEC');

  }

    function setPeriod(uint _period) external onlyOwner {
        period = _period;
        emit PeriodChanged(_period);
    }

    function update() external {
        (uint price0Cumulative, uint price1Cumulative, uint32 blockTimestamp) =
            UniswapV2OracleLibrary.currentCumulativePrices(address(pair));
        uint32 timeElapsed1Period = blockTimestamp - blockTimestampLast1Period; // overflow is desired

        // ensure that at least one full period has passed since the last update
        require(timeElapsed1Period >= period, 'PERIOD_NOT_ELAPSED');

        // overflow is desired, casting never truncates
        // cumulative price is in (uq112x112 price * seconds) units so we simply wrap it after division by time elapsed
        price0Average1Period = FixedPoint.uq112x112(uint224((price0Cumulative - price0CumulativeLast1Period) / timeElapsed1Period));
        price1Average1Period = FixedPoint.uq112x112(uint224((price1Cumulative - price1CumulativeLast1Period) / timeElapsed1Period));

        price0CumulativeLast1Period = price0Cumulative;
        price1CumulativeLast1Period = price1Cumulative;
        blockTimestampLast1Period = blockTimestamp;

    }

    function consult(address token, uint amountIn) external view returns (uint amountOut) {
        if (token == token0) {
            amountOut = price0Average1Period.mul(amountIn).decode144();
        } else {
            require(token == token1, 'INVALID_TOKEN');
            amountOut = price1Average1Period.mul(amountIn).decode144();
        }
    }


  // get latest price
  function getPrice(address token) external override view returns (uint256 price) {
      if (token == token0) {
          uint token1Price = baseOracle.getPrice(token1);
            price = price0Average1Period.mul(token1Price).decode144();
      } else {
          require(token == token1, 'INVALID_TOKEN');
          uint token0Price = baseOracle.getPrice(token0);
          price = price1Average1Period.mul(token0Price).decode144();
      }
      require(price != 0, "NO_PRICE");
  }

}
