const express = require('express');
const Web3 = require('web3');
const contractABI = require('./propertyRegistryABI.json'); // Replace with path to your contract ABI

const app = express();
const port = 3000; // Replace with desired port number

// Replace with your provider URL (e.g., local node or Infura)
const provider = new Web3.providers.HttpProvider('http://localhost:8545');
const web3 = new Web3(provider);

// Replace with your deployed contract address
const contractAddress = '0xYourContractAddress';
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Restricted endpoint accessible only by authorized users (replace with authentication)
app.post('/register-property', async (req, res) => {
    const { propertyId, newOwnerAddress } = req.body;
    try {
        const tx = await contract.methods.registerProperty(propertyId, newOwnerAddress)
        .send({ from: yourAuthorizedAccountAddress }); // Replace with authorized account

        res.json({ message: 'Property registration successful!', txHash: tx.transactionHash });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error registering property' });
    }
    });

app.get('/property/:propertyId/owner', async (req, res) => {
    const { propertyId } = req.params;
    try {
        const ownerAddress = await contract.methods.getPropertyOwner(propertyId).call();
        res.json({ owner: ownerAddress });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error retrieving owner information' });
    }
});

// Restricted endpoint accessible only by current owner (replace with access control)
app.put('/property/:propertyId/transfer', async (req, res) => {
    const { propertyId, newOwnerAddress } = req.body;
    try {
        const tx = await contract.methods.transferOwnership(propertyId, newOwnerAddress)
        .send({ from: currentOwnerAddress }); // Replace with current owner address
        res.json({ message: 'Ownership transferred successfully!', txHash: tx.transactionHash });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error transferring ownership' });
    }
});

app.listen(port, () => console.log(`Server listening on port ${port}`));