# KaleidoHackathon

We have created a smart contract GovtContract.sol to track the transactions that an agency might do. The goal of this smart contract is to hold the said agency accountable and to introduce transparency into its working. The smart contract also catches any unauthorized spending or spending over the allocated budget by creating events and then creating a transaction containing the event on the blockchain.

To run our smart contract navigate to a local working directory on your machine. Clone this repo and change into it:

```git clone https://github.com/AbhishaB/KaleidoHackathon.git  && cd KaleidoHackathon```

Install dependencies with ```npm install```

Deploy a Kaleido environment using ```node setup.js PASTE_YOUR_APIKEY_HERE```

The server is run on node.js using the command:

```node govt_app.js```

After it starts listening on port 3000, deploy the contract.

Our smart contract is first deployed using the command:

```curl -X POST -H "Content-Type: application/json" localhost:3000/govtcontract/deploy | jq```

This initializes the initial budget allocated to be some value set in the contract's js file, GovtContract.js.

The smart contracts records pertinent details of the transaction, such as amount of expenditure, department, purpose, date, time and location. These details are recorded on the blockchain.

This is done using the command:

```curl -X POST -H "Content-Type: application/json" localhost:3000/govtcontract/set -d '{"value1":"5000","value2":"01","value3":"PowerTools","value4":"09/24/2018","value5":"03:27:00","value6":"27606"}' | jq```

The value parameters are the aforementioned details of the transaction.

This smart contract now takes the expenditure amount and subtracts it from the initial budget and assigns it to the remaining budget. For subsequent transactions, it subtracts the amount from the remaining budget.

The remaining budget value is also written to the blockchain. It can be obtained using the command:

```curl -X GET -H "Content-Type: application/json" localhost:3000/govtcontract/get | jq```
