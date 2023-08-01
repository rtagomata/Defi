    // SPDX-License-Identifier: MIT
    pragma solidity >0.6.0;
    pragma abicoder v2;

    import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
    import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

    contract SwapExamples {


        event safeTransferFrom(address owner, address sender);
        event safeApprove(address owner, address sender);
        event Constructed(address owner);
        event nonsenseemit(uint256 num);
        event paramInit(
            address tokenIn, 
            address tokenOut,
            uint24 poolFee,
            address recipient, 
            uint256 deadline, 
            uint256 amountIn,
            uint256 amountOutMin);
        ISwapRouter public swapRouter;
        constructor () {
            swapRouter = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
            emit Constructed(msg.sender);
        }

        address public constant DAI = 0xdc31Ee1784292379Fbb2964b3B9C4124D8F89C60;
        address public constant WETH9 = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;
        address public constant USDC = 0x2f3A40A3db8a7e3D09B0adfEfbCe4f6F81927557;
        uint256 nonsensevar;
        uint24 public constant poolFee = 3000;

        function nonsense () external
        {
            uint256 a = 1;
            uint256 b = 2;
            nonsensevar = a + b;
            emit nonsenseemit(nonsensevar);
                        TransferHelper.safeTransferFrom
            (
                WETH9, 
                msg.sender, 
                address(this), 
                100
            );
            
            emit safeApprove(msg.sender, address(this));

            TransferHelper.safeApprove(WETH9, address(swapRouter), 100);
        }

        function swapExactInputSingle(uint256 amountIn) 
            external 
        {
            
            emit safeTransferFrom(msg.sender, address(this));
            TransferHelper.safeTransferFrom
            (
                WETH9, 
                msg.sender, 
                address(this), 
                amountIn
            );
            // Approve the router to spend DAI.
            emit safeApprove(msg.sender, address(this));

            TransferHelper.safeApprove(WETH9, address(swapRouter), amountIn);
            // Naively set amountOutMinimum to 0. In production, use an oracle or other data source to choose a safer value for amountOutMinimum.
            // We also set the sqrtPriceLimitx96 to be 0 to ensure we swap our exact input amount.
            ISwapRouter.ExactInputSingleParams memory params =
                ISwapRouter.ExactInputSingleParams({
                    tokenIn: WETH9,
                    tokenOut: DAI,
                    fee: poolFee,
                    recipient: msg.sender,
                    deadline: block.timestamp,
                    amountIn: amountIn,
                    amountOutMinimum: 0,
                    sqrtPriceLimitX96: 0
                });
            emit paramInit(params.tokenIn, params.tokenOut, params.fee, params.recipient, params.deadline, params.amountIn, params.amountOutMinimum);
            // The call to `exactInputSingle` executes the swap.
        }


        function swapExactOutputSingle(uint256 amountOut, uint256 amountInMaximum) external returns (uint256 amountIn) {
            // Transfer the specified amount of DAI to this contract.
            TransferHelper.safeTransferFrom(WETH9, msg.sender, address(this), amountInMaximum);

            // Approve the router to spend the specifed `amountInMaximum` of DAI.
            // In production, you should choose the maximum amount to spend based on oracles or other data sources to acheive a better swap.
            TransferHelper.safeApprove(WETH9, address(swapRouter), amountInMaximum);

            ISwapRouter.ExactOutputSingleParams memory params =
                ISwapRouter.ExactOutputSingleParams({
                    tokenIn: WETH9,
                    tokenOut: DAI,
                    fee: poolFee,
                    recipient: msg.sender,
                    deadline: block.timestamp,
                    amountOut: amountOut,
                    amountInMaximum: amountInMaximum,
                    sqrtPriceLimitX96: 0
                });

            amountIn = swapRouter.exactOutputSingle(params);

            if (amountIn < amountInMaximum) {
                TransferHelper.safeApprove(WETH9, address(swapRouter), 0);
                TransferHelper.safeTransfer(WETH9, msg.sender, amountInMaximum - amountIn);
            }
        }
    }