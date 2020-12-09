const approveTransferERC20 = require('../utils/approveTransferERC20')

internalTask('mintOptions', 'Mint options')
  .addParam('option', 'Option address')
  .addParam('amount', 'Amount of Options to mint')
  .addOptionalParam('contract', 'Option Contract type to use')
  .addOptionalParam('owner', 'Option owner')
  .setAction(async ({ option, owner, amount, contract = 'PodPut' }, bre) => {
    const [caller] = await ethers.getSigners()
    const callerAddress = await caller.getAddress()

    if(!owner) {
      owner = callerAddress
    }

    const optionContract = await ethers.getContractAt(contract, option)
    const amountBN = ethers.BigNumber.from(amount).mul(ethers.BigNumber.from(10).pow(await optionContract.decimals()))

    const strikeAssetContract = await ethers.getContractAt('MintableERC20', await optionContract.strikeAsset())
    const strikeToTransfer = await optionContract.strikeToTransfer(amountBN)

    // 1) Approve StrikeAsset between me and option Contract
    await approveTransferERC20(strikeAssetContract, option, strikeToTransfer)

    const optionsBefore = await optionContract.balanceOf(owner)

    // 2) Call option Mint
    const txIdMint = await optionContract.mint(amountBN, owner)
    await txIdMint.wait()

    const optionsAfter = await optionContract.balanceOf(owner)
    console.log(`Minted ${optionsAfter.sub(optionsBefore)} ${await optionContract.symbol()} to address: ${owner}`)
  })
