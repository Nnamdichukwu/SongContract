
const SongContract = artifacts.require("SongContract");

let accounts;
let owner;

contract('SongContract', async(accs)=>{
    accounts = accs;
    owner = accounts[0];
});

it('Can create a song', async() =>{
    let tokenId = 1;
    let instance = await SongContract.deployed();
    await instance.createSong("Redemption Song", "Reggae", "Bob Marley",tokenId, {from: owner})
    let songInfo = await instance.tokenIdToSongInfo.call(tokenId)
    assert.equal(songInfo['nameOfSong'], "Redemption Song");
    assert.equal(songInfo['genre'], "Reggae");
    assert.equal(songInfo['artist'], "Bob Marley");
});

it ('user 1 can put song for sale', async()=>{
    let instance = await SongContract.deployed();
    let user1 = accounts[1];
    let songId = 2;
    let songPrice = web3.utils.toWei("0.01", "ether");
    await instance.createSong("Cloud9", "Afrobeats", "Dj Spinall ft Adekunle Gold", songId, {from: user1})
    await instance.putUpSongForSale.call(songId, songPrice, {from: user1})
    let putSongForSale = await instance.songForSale.call(songPrice, {from: user1});
    //putSongForSale = web3.utils.toWei("0.01", "ether"); 
    //anotherTest = await instance.songForSale.call(songId).web3.utils.toWei("0.01", "ether");
    console.log(songId)
    console.log(songPrice);
    console.log(putSongForSale);
    //console.log(instance.songForSale.call(songId));
   // console.log(anotherTest);
    assert.equal(putSongForSale, songPrice.toString());


});


