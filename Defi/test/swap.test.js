const {expect} = require("chai");
const {ethers} = require("hardhat");

const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
const WETH9 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";
const feeTier = 3000;

describe("swapWETHForDAI", function() {
    it("swapWETHForDAI", async function() {
        const accounts = await ethers.getSigners()

        const dai = await ethers.getContractAt("IERC20", DAI)
        const weth = await ethers.getContractAt("IWeth", WETH9)

        const SwapExamples = await ethers.getContractFactory("SwapExample");
        const swapExamples = await SwapExamples.deploy();
        await swapExamples.waitForDeployment();

        const amountIn = 10n ** 18n

        await weth.connect(accounts[0]).deposit({value: amountIn});
        await weth.connect(accounts[0]).approve(swapExamples.getAddress(), amountIn)


        await swapExamples.swapWETHForDAI(amountIn)

        console.log("Dai balance", await dai.balanceOf(accounts[0].address));
    });
});