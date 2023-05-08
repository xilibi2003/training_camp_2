//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// fork from https://github.com/monokh/looneyswap

contract MiniSwapPool is ERC20 {
    address public token0;
    address public token1;

    // Reserve of token 0
    uint public reserve0;

    // Reserve of token 1
    uint public reserve1;

    uint public constant INITIAL_SUPPLY = 10**5;

    constructor(address _token0, address _token1) ERC20("LooneyLiquidityProvider", "LP") {
        token0 = _token0;
        token1 = _token1;
    }

    /**
    * Adds liquidity to the pool.
    * 1. Transfer tokens to pool
    * 2. Emit LP tokens
    * 3. Update reserves
    */
    function add(uint amount0, uint amount1) public {
        assert(IERC20(token0).transferFrom(msg.sender, address(this), amount0));
        assert(IERC20(token1).transferFrom(msg.sender, address(this), amount1));

        uint reserve0After = reserve0 + amount0;
        uint reserve1After = reserve1 + amount1;

        if (reserve0 == 0 && reserve1 == 0) {
            _mint(msg.sender, INITIAL_SUPPLY);
        } else {
            uint currentSupply = totalSupply();

            uint newSupplyGivenReserve0Ratio = reserve0After * currentSupply / reserve0;
            uint newSupplyGivenReserve1Ratio = reserve1After * currentSupply / reserve1;
            uint newSupply = Math.min(newSupplyGivenReserve0Ratio, newSupplyGivenReserve1Ratio);
            _mint(msg.sender, newSupply - currentSupply);
        }

        reserve0 = reserve0After;
        reserve1 = reserve1After;
    }

    /**
    * Removes liquidity from the pool.
    * 1. Transfer LP tokens to pool
    * 2. Burn the LP tokens
    * 3. Update reserves
    */
    function remove(uint liquidity) public {
        assert(transfer(address(this), liquidity));

        uint currentSupply = totalSupply();

        // 10 lp token  ; total 100;
        uint amount0 = liquidity * reserve0 / currentSupply;
        uint amount1 = liquidity * reserve1 / currentSupply;

        _burn(address(this), liquidity);

        assert(IERC20(token0).transfer(msg.sender, amount0));
        assert(IERC20(token1).transfer(msg.sender, amount1));
        reserve0 = reserve0 - amount0;
        reserve1 = reserve1 - amount1;
    }

    /**
    * Uses x * y = k formula to calculate output amount.
    * 1. Calculate new reserve on both sides
    * 2. Derive output amount
    */
    function getAmountOut (uint amountIn, address fromToken) public view returns (uint amountOut, uint _reserve0, uint _reserve1) {
        uint newReserve0;
        uint newReserve1;
        uint k = reserve0 * reserve1;

        // x (reserve0) * y (reserve1) = k (constant)
        // (reserve0 + amountIn) * (reserve1 - amountOut) = k
        // (reserve1 - amountOut) = k / (reserve0 + amount)
        // newReserve1 = k / (newReserve0)
        // amountOut = newReserve1 - reserve1

        if (fromToken == token0) {
            newReserve0 = amountIn + reserve0;
            newReserve1 = k / newReserve0;
            amountOut = reserve1 - newReserve1;
        } else {
            newReserve1 = amountIn + reserve1;
            newReserve0 = k / newReserve1;
            amountOut = reserve0 - newReserve0;
        }

        _reserve0 = newReserve0;
        _reserve1 = newReserve1;
    }

    /**
    * Swap to a minimum of `minAmountOut`
    * 1. Calculate new reserve on both sides
    * 2. Derive output amount
    * 3. Check output against minimum requested
    * 4. Update reserves
    */
    function swap(uint amountIn, uint minAmountOut, address fromToken, address toToken, address to) public {
        require(amountIn > 0 && minAmountOut > 0, 'Amount invalid');
        require(fromToken == token0 || fromToken == token1, 'From token invalid');
        require(toToken == token0 || toToken == token1, 'To token invalid');
        require(fromToken != toToken, 'From and to tokens should not match');

        (uint amountOut, uint newReserve0, uint newReserve1) = getAmountOut(amountIn, fromToken);

        require(amountOut >= minAmountOut, 'Slipped... on a banana');

        assert(IERC20(fromToken).transferFrom(msg.sender, address(this), amountIn));
        assert(IERC20(toToken).transfer(to, amountOut));

        reserve0 = newReserve0;
        reserve1 = newReserve1;
    }
}
