# OrganChain
Project built for IBC Hackathon

## **Idea**

A Dapp to provide easy access of donated organs


- No paperwork needed with blockchain guarantees code is law.

- No more red-tapism

- Security of privacy of organ donors powered by blockchain.

- Free transfer of ownership

- Automation of process via smart contracts

- No more Illegal Sale of Donated Organs by Middlemen.


## **Basic Architecture**

<img src="https://github.com/ItachiUchiha1998/OrganChain/blob/master/organ1.jpg" width="600">

## **Setup**

1. Clone the repo using terminal:

```
git clone https://github.com/ItachiUchiha1998/OrganChain
cd OrganChain
```

2. Install all the npm dependencies:

```
npm install
```

3. Deploy contracts through Ganache:

```
ganache-cli
```

4. In a new terminal migrate contracts to Ganache:

```
truffle migrate
```

5. Run the application:

```
npm run dev
```

## **Stack Used**

- **Solidity** For writing smart contracts
- **Truffle** Framework to interact with blockchain
- **Web3.js** Integrate blockchain with UI
- **ExpressJS** For serving and routing of application
