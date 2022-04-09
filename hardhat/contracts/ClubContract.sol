// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;
import "./Interfaces/IERC721.sol";
import "./Utils/VRFv2Consumer.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract ClubContract {
    uint256 upVoteXp = 1;
    uint256 engagementRewardMultiplier = 1;
    uint256 penaltyMultiplier = 1;
    uint256 tierCount = 5;
    address[] public memberList;
    address public factory;
    address public nftContractAddress;

    event MemberCreated(uint256, uint256, address);

    struct MemberInfo {
        uint256 proposalCount;
        uint256 voteCount;
        uint256 xp;
        uint256 tier;
        uint256 created;
        uint256 nftCount;
        bytes userName;
        bool currentMember;
        bool suspended;
    }

    VRFCoordinatorV2Interface COORDINATOR;

    // Your subscription ID.
    uint64 s_subscriptionId;

    // Rinkeby coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;

    // The gas lane to use, which specifies the maximum gas price to bump to.
    // For a list of available gas lanes on each network,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    bytes32 keyHash =
        0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

    // Depends on the number of requested values that you want sent to the
    // fulfillRandomWords() function. Storing each word costs about 20,000 gas,
    // so 100,000 is a safe default for this example contract. Test and adjust
    // this limit based on the network that you select, the size of the request,
    // and the processing of the callback request in the fulfillRandomWords()
    // function.
    uint32 callbackGasLimit = 200000;

    // The default is 3, but you can set this higher.
    uint16 requestConfirmations = 3;

    // For this example, retrieve 2 random values in one request.
    // Cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS.
    uint32 numWords = 5;

    uint256[] s_randomWords;
    uint256 public s_requestId;

    // Assumes the subscription is funded sufficiently.
    function requestRandomWords() internal onlyOwner {
        // Will revert if subscription is not set and funded.
        s_requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal {
        s_randomWords = randomWords;
    }

    /* 
    Encryption keys used to decript messages in different chanels
    0-Room main
    1- Tier 1
    2 - Tier 2
    ...
    */
    mapping(address => MemberInfo) public members;

    constructor() {
        factory = msg.sender;
    }

    function initialize(address _nftCollection, uint64 subscriptionId)
        external
    {
        require(msg.sender == factory, "ClubFactory: FORBIDDEN"); // sufficient check
        nftContractAddress = _nftCollection;
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_subscriptionId = subscriptionId;
    }

    function getUserNftCount(address _user)
        internal
        view
        returns (uint256 balance)
    {
        IERC721 collection = IERC721(nftContractAddress);
        balance = collection.balanceOf(_user);

        return balance;
    }

    //
    function loadUsers(address[] memory _toload) public {
        for (uint256 i = 0; i < _toload.length; i++) {
            if (getUserNftCount(_toload[i]) > 0) {
                memberList.push(_toload[i]);
            }
        }
    }

    function joinClub() public {
        require(nftContractAddress != address(0), "BAD NFT CONTRACT ADDRESS");
        require(getUserNftCount(msg.sender) > 0, "Club: NOT ELIGIBLE");
        require(members[msg.sender].currentMember != true, "ALREADY MEMBER");

        MemberInfo memory member;
        member.currentMember = true;
        member.proposalCount = 0;
        member.xp = 0;
        member.tier = 1;
        member.created = block.timestamp;
        member.voteCount = member.nftCount * member.tier;
        memberList.push(msg.sender);
        members[msg.sender] = member;
        emit MemberCreated(
            member.tier,
            getUserNftCount(msg.sender),
            msg.sender
        );
    }

    address[] temp;

    function sync() public {
        for (uint256 j = 0; j < temp.length; j++) {
            temp.pop();
        }

        for (uint256 i = 0; i < memberList.length; i++) {
            if (getUserNftCount(memberList[i]) > 0) {
                members[memberList[i]].nftCount = getUserNftCount(
                    memberList[i]
                );
                temp.push(memberList[i]);
            }
        }
        memberList = temp;
    }

    modifier onlyOwner() {
        require(msg.sender == factory);
        _;
    }
}
