// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface IOptionAMMPool {
    function addLiquidity(
        uint256 amountOfA,
        uint256 amountOfB,
        address owner
    ) external;

    function removeLiquidity(uint256 amountOfA, uint256 amountOfB) external;

    function tradeExactAInput(
        uint256 exactAmountAIn,
        uint256 minAmountBOut,
        address owner,
        uint256 sigmaInitialGuess
    ) external returns (uint256);

    function tradeExactAOutput(
        uint256 exactAmountAOut,
        uint256 maxAmountBIn,
        address owner,
        uint256 sigmaInitialGuess
    ) external returns (uint256);

    function tradeExactBInput(
        uint256 exactAmountBIn,
        uint256 minAmountAOut,
        address owner,
        uint256 sigmaInitialGuess
    ) external returns (uint256);

    function tradeExactBOutput(
        uint256 exactAmountBOut,
        uint256 maxAmountAIn,
        address owner,
        uint256 sigmaInitialGuess
    ) external returns (uint256);

    function getOptionTradeDetailsExactAInput(uint256 exactAmountAIn)
        external
        view
        returns (
            uint256 amountBOutput,
            uint256 newSigma,
            uint256 feesTokenA,
            uint256 feesTokenB
        );

    function getOptionTradeDetailsExactAOutput(uint256 exactAmountAOut)
        external
        view
        returns (
            uint256 amountBInput,
            uint256 newSigma,
            uint256 feesTokenA,
            uint256 feesTokenB
        );

    function getOptionTradeDetailsExactBInput(uint256 exactAmountBIn)
        external
        view
        returns (
            uint256 amountAOutput,
            uint256 newSigma,
            uint256 feesTokenA,
            uint256 feesTokenB
        );

    function getOptionTradeDetailsExactBOutput(uint256 exactAmountBOut)
        external
        view
        returns (
            uint256 amountAInput,
            uint256 newSigma,
            uint256 feesTokenA,
            uint256 feesTokenB
        );

    function getSpotPrice(address asset, uint256 decimalsOutput) external view returns (uint256);

    function getABPrice() external view returns (uint256);
}
