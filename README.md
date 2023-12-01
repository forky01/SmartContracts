# SmartContracts

## Contracts

There is currently only one contract for voting.

## Truffle Console

```
const abi = require("./build/contracts/Voting.json");
var voting_instance = new web3.eth.Contract(abi['abi'],"0xfdd47e526a93ec51dfb7f92b006ba0a448c8145c")
```

## Methods

| Method Name  | Parameters                                    | Description                                                                           |
| ------------ | --------------------------------------------- | ------------------------------------------------------------------------------------- |
| getVoteCount | n/a                                           | Gets the vote for the poll                                                            |
| vote         | `String` flavour ('Chocolate' \|\| 'Vanilla') | Place your vote for you favourite icecream flavour. You can only place your vote once |

### Examples

- To view the votes:

  `voting_instance.methods.getVoteCount().call()`

- To vote:

  `voting_instance.methods.vote('FLAVOUR').send({from: 'YOUR_ACCOUNT'})`
