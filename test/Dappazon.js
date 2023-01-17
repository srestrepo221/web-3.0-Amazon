const { expect } = require("chai")

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

    // Global constants for listing an item...
    const ID = 1
    const NAME = "Shoes"
    const CATEGORY = "Clothing"
    const IMAGE = "https://ipfs.io/ipfs/QmTYEboq8raiBs7GTUg2yLXB3PMz6HuBNgNfSZBx5Msztg/shoes.jpg"
    const COST = tokens(1)
    const RATING = 4
    const STOCK = 5

describe("Dappazon", () => {
  let dappazon, 
      deployer, 
      buyer

  beforeEach(async () => {
    // Setup Accounts
    [deployer, buyer] = await ethers.getSigners()
    //console.log((await ethers.getSigners()).length)

    // Deploy contracts
    const Dappazon = await ethers.getContractFactory('Dappazon')
    dappazon = await Dappazon.deploy()
  })

  describe("Deployment", () => {
    it('sets the owner', async () => {
      expect(await dappazon.owner()).to.equal(deployer.address)
    })
  })
    /*
    it('has a name', async () => {
    const name = await dappazon.name()
    expect(name).to.equal('Dappazon')
    //expect(await dappazon.name()).to.equal('Dappazon')
    })
    */
  describe("Listing Products", () => {
    let transaction

    beforeEach(async () => {
    transaction = await dappazon.connect(deployer).listProducts(
      ID,          // id
      NAME,    // name
      CATEGORY, // category
      IMAGE,    // image
      COST,          // cost
      RATING,          // rating
      STOCK           // stock
    )

    await transaction.wait()
  })
    it('returns item attributes', async () => {
      const item = await dappazon.items(1)
      expect(item.id).to.equal(ID)
      expect(item.name).to.equal(NAME)
      expect(item.category).to.equal(CATEGORY)
      expect(item.image).to.equal(IMAGE)
      expect(item.cost).to.equal(COST)
      expect(item.rating).to.equal(RATING)
      expect(item.stock).to.equal(STOCK)
    })
  })


})
