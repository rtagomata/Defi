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


        DAI = interface.IERC20(config["networks"]["goerli"]["DAI"])
        WETH = interface.IERC20(config["networks"]["goerli"]["WETH"])

        print("Transferring")
        WETH.transfer(SwapContract.address, amount, {"from": account, "gas_price": gasPrice})
        print("Approving")
        WETH.approve(SwapContract.address, amount, {"from": account, "gas_price": gasPrice})
        
        print("Testing swapExactInputSingle")
        receivedDAI1 = SwapContract.swapExactInputSingle(amount, {"from": account, "gas_price": gasPrice})
        print("Successful") 


        print("Transferring")
        WETH.transfer(SwapContract.address, amount, {"from": account, "gas_price": gasPrice})
        print("Approving")
        WETH.approve(SwapContract.address, amount, {"from": account, "gas_price": gasPrice})
        
        print("Testing swapExactInputSingle")
        receivedDAI2 = SwapContract.swapExactInputSingle(amount, {"from": account, "gas_price": gasPrice})
        print("Successful") 

        print(f"Received DAI TX1: {receivedDAI1.return_value}")
        print(f"Received DAI TX2: {receivedDAI2.return_value}")
    