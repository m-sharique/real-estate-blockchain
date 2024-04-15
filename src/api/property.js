const express = require('express');
const bodyParser = require('body-parser');
const { Web3 } = require('web3'); // Web3 library for interacting with smart contract

// Replace with your actual smart contract address and ABI
const contractAddress = 'your_contract_address';
const contractABI = require('./path/to/your/contract/abi.json');

const app = express();
const port = process.env.PORT || 3000; // Use environment variable or default port

// Connect to the blockchain node (replace with your provider details)
const provider = new Web3.providers.HttpProvider('your_blockchain_node_url');
const web3 = new Web3(provider);

// Instantiate the smart contract
const contract = new web3.eth.Contract(contractABI, contractAddress);

app.use(bodyParser.json());  // Parse incoming JSON data

app.post('/verify-property', async (req, res) => {
    const { propertyId, signature } = req.body;

    if (!propertyId || !signature) {
        return res.status(400).json({ message: 'Missing required data' });
    }

    try {
        // Call the smart contract function to verify ownership (replace with actual function)
        const isVerified = await contract.methods.verifyOwnership(propertyId, signature).call();

        if (isVerified) {
            res.status(200).json({ message: 'Property ownership verified' });
        } else {
            res.status(401).json({ message: 'Unauthorized property addition' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error verifying property' });
    }
});

app.listen(port, () => console.log(`Server listening on port ${port}`));
