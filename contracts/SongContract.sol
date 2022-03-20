// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

contract SongContract is ERC721 {
    struct Song{
        string nameOfSong;
       string genre;
        string artist;

    }
    mapping(uint256 => Song) public tokenIdToSongInfo;
    mapping(uint256 => uint256) public songForSale;
    constructor() ERC721("SongNFT", "SNFT") {

    }
    
    function createSong(string memory _name,string memory _genre, string memory _artist, uint256 _tokenId) public{
        Song memory newSong = Song({
            nameOfSong: _name,
            genre: _genre,
            artist: _artist
        });
        tokenIdToSongInfo[_tokenId] = newSong;
        _mint(msg.sender, _tokenId); // _mint  assign the star with _tokenId to the msg.sender address



    }
    function putUpSongForSale(uint256 _tokenId, uint256 _price) public{
        require(ownerOf(_tokenId)== msg.sender, "You are not eligible to put star up for sale");
        songForSale[_tokenId] = _price;
    }
    //function to convert any address to a payable address
   /* function _make_payable(address x) internal pure returns(address payable){
        return address(uint160(x));
    } */
    function buySong(uint256 _tokenId) public payable{
        require(songForSale[_tokenId]> 0);
        uint256 songCost = songForSale[_tokenId];
        address ownerAddress = ownerOf(_tokenId);
        require(msg.value > songCost, "You need more ether");
        transferFrom(ownerAddress, msg.sender, _tokenId);
        address payable ownerAddressPayable = payable(ownerAddress);
        ownerAddressPayable.transfer(songCost);
        if(msg.value > songCost){
            payable(msg.sender).transfer(msg.value - songCost);
        }


    }
}