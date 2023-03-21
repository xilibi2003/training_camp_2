pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol";

contract MyERC721 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721(unicode"集训营二期学员卡", "CAMP2") {}

    //  QmZNFPwox146ohY93ViFD8omSThRAVYF1A96MNHbWoa2Nr
    function mint(address student, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(student, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }
}