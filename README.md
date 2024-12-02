# Ethernaut

Ethernaut is a Web3/Solidity based wargame inspired by [overthewire](https://overthewire.org), to be played in the Ethereum Virtual Machine. Each level is a smart contract that needs to be 'hacked'.

The game acts both as a tool for those interested in learning ethereum, and as a way to catalogue historical hacks as levels. There can be an infinite number of levels and the game does not require to be played in any particular order.

## Hosting the game locally

The CTF is composed of 3 components:

- Test Network - A blockchain running locally.
- Contract Deployment - A script deploying the smart contracts.
- The Client/Frontend - A React app that runs locally and can be accessed on [localhost:3000](localhost:3000).

In order to install, build, and run Ethernaut locally, follow these instructions:

First clone this repository and its submodules with

#### Linux/MacOS

```bash
git clone --recurse-submodules https://gitlab.uliege.be/blockchains/ethereum/ctf-games/ethernaut/ethernaut.git
```


#### Windows

```bash
git clone -b vj-docker-compose-support-for-windows --recurse-submodules https://gitlab.uliege.be/blockchains/ethereum/ctf-games/ethernaut/ethernaut.git
```

### Option 1: With Docker Compose
To host the Ethernaut game locally (i.e. the local blockchain and the website), please run:
```
docker compose up
```

### Option 2: From source
In case the previous option didn't work, you can refer to this section to host the game on your machine.

0. Be sure to use a compatible Node version. If you use `nvm` you can run `nvm use` at the root level to be sure to select a compatible version.

1. Install dependencies:

    ```bash
    yarn install
    ```

2. Start deterministic rpc

    ```bash
    yarn network
    ```

3. Compile contracts

    ```bash
    yarn compile:contracts
    ```

4. Deploy contracts

    ```bash
    yarn deploy:contracts
    ```

5. Start Ethernaut locally

    ```bash
    yarn start:ethernaut
    ```

## Play

To start with this game, look at the instructions at [http://localhost:3000/help](http://localhost:3000/help).

Then, you can start with the first level at [http://localhost:3000/](http://localhost:3000/).

### Cheat Sheet

A bunch of commands to help the folks which are unfamiliar with JavaScript.

| Command                              | Details |
|----------------------------------------------------------------------------|------------------------------------------------------------------------------------|
|  (await contract.someProperty()).toNumber() | Fetches the property "someProperty" (int) stored within a contract. Then, it converts to a number as it's initial type is a BigNumber (i.e. an object). |
| await contract.f({value: toWei("0.0001")})                                 | Call the function 'f' of the contract and send 0.0001 ether along the transaction. |
| await sendTransaction({from: player, to: contract.address, value: toWei("0.1")}) | Send a transaction from the player address to the contract with 0.1 ether.         |

## Troubleshooting
### Issue: Transactions Failing After Lab Restart
Your local blockchain’s state is not permanently saved to disk. This means that each time you restart the lab (specifically, the Docker container running the blockchain), the blockchain is reset.

However, MetaMask keeps a record of your previous activity on the local blockchain, and it does not automatically clear this history. This causes MetaMask to be out-of-sync with the blockchain, which prevents you from publishing new transactions.

**Solution**:

- Clear the activity tab data:
    - Open the MetaMask extension.
    - Click on the three dots in the upper right corner.
    - Go to "Settings," then select "Advanced Settings."
    - Click on "Clear activity tab data."
- Disconnect MetaMask from localhost:3000 and reconnect:
    - Open the MetaMask extension.
    - Click on the circle icon next to the three dots.
    - Click on "Disconnect" and then reconnect.