// Replace the value with your NFT contract address
const VRF_V2_CONSUMER_ADDRESS = "0x8aF38b60130C2A063076a16CbFc995A90733819d";

module.exports = { VRF_V2_CONSUMER_ADDRESS };

const Alphabet = [
  "A",
  "B",
  "C ",
  "D ",
  "E ",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
];

const MegaAlphabet = [];

for (let i = 0; i < 10; i++) {
  MegaAlphabet.push(
    Alphabet.map((char) => {
      if (i > 0) {
        return `=${Alphabet[i - 1]}`;
      } else {
        return `=${Alphabet[i]}`;
      }
    })
  );
}
