## install rust
```bash
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
```


## install circom
```bash
git clone https://github.com/iden3/circom.git

cd circom

cargo build --release

cargo install --path circom

npm install -g snarkjs
```


## compile circuit

```bash
circom multiplier2.circom --r1cs --wasm --sym --c
```

## generate witness

```bash
node multiplier2_js/generate_witness.js multiplier2_js/multiplier2.wasm input.json witness.wtns
```

## generate trusted setup
```bash
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v


snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v


snarkjs groth16 setup multiplier2.r1cs pot12_final.ptau multiplier2_0000.zkey

snarkjs zkey contribute multiplier2_0000.zkey multiplier2_0001.zkey --name="1st Contributor Name" -v

snarkjs zkey export verificationkey multiplier2_0001.zkey verification_key.json
```

## generate Proof

```bash
snarkjs groth16 prove multiplier2_0001.zkey witness.wtns proof.json public.json
```


## verify proof

```bash
snarkjs groth16 verify verification_key.json public.json proof.json
```

## verify proof from a Smart Contract

```bash
snarkjs zkey export solidityverifier multiplier2_0001.zkey verifier.sol
```

To facilitate the call, you can use snarkJS to generate the parameters of the call by typing:

```bash
snarkjs generatecall
```