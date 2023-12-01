// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public owner;

    string public option1;
    string public option2;

    uint256 public votesForOption1;
    uint256 public votesForOption2;

    mapping(address => bool) public hasVoted;

    event Voted(address indexed voter, string optionVoted);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(string memory _option1, string memory _option2) {
        owner = msg.sender;
        option1 = _option1;
        option2 = _option2;
    }

    function vote(string memory option) public {
        require(bytes(option).length > 0, "Option cannot be empty");
        require(!hasVoted[msg.sender], "You have already voted");

        if (
            keccak256(abi.encodePacked(option)) ==
            keccak256(abi.encodePacked(option1))
        ) {
            votesForOption1++;
        } else if (
            keccak256(abi.encodePacked(option)) ==
            keccak256(abi.encodePacked(option2))
        ) {
            votesForOption2++;
        } else {
            revert("Invalid option");
        }

        hasVoted[msg.sender] = true;

        emit Voted(msg.sender, option);
    }

    function getVoteCount() public view returns (string memory) {
        return
            string(
                abi.encodePacked(
                    option1,
                    ": ",
                    toString(votesForOption1),
                    " votes, ",
                    option2,
                    ": ",
                    toString(votesForOption2),
                    " votes"
                )
            );
    }

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
