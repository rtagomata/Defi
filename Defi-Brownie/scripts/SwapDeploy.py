from web3 import Web3
from brownie import config, network, accounts, SwapExamples, interface

def main():
    convert()
gasPrice = 3000000000
amount = 0.000001 * 10 ** 18
def convert():
    if network.show_active().lower() == "goerli":
        account = accounts.add(config["wallets"]["testnet"])
        print("Deploying Contract")
        SwapContract = SwapExamples.deploy({"from": account, "gas_price": gasPrice})
        print("Contract deployed.")


        print("Approving")
        DAI = interface.IERC20(config["networks"]["goerli"]["DAI"])
        WETH = interface.IERC20(config["networks"]["goerli"]["WETH"])
        WETHBal = WETH.balanceOf(SwapContract.address, {"from": account})
        print(f"Swap WETH Contract balance: {WETHBal}")
        print("Transferring")
        WETH.transfer(SwapContract.address, amount, {"from": account, "gas_price": gasPrice})
        print("Approving")
        WETH.approve(SwapContract.address, amount, {"from": account, "gas_price": gasPrice})
        print("Checking")
        print(WETH.allowance(account.address, SwapContract.address, {"from": account}))
        WETHBal = WETH.balanceOf(SwapContract.address, {"from": account})
        print(f"Swap WETH Contract balance: {WETHBal}")
        print("Approved!")

        print("Checking account balance...")
        daibal = DAI.balanceOf(account.address, {"from": account})
        wethbal = WETH.balanceOf(account.address, {"from": account})
        print(f"Account WETH Balance: {wethbal}")
        print(f"Account DAI Balance: {daibal}")
        
        print("Testing swapExactInputSingle")
        SwapContract.swapExactInputSingle(amount, {"from": account, "gas_price": gasPrice * 10})
        print("Successful") 

