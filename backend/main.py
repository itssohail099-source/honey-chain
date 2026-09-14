from fastapi import FastAPI
import mysql.connector
from web3 import Web3
import json

app = FastAPI()

# --- 1. MySQL Setup ---
db = mysql.connector.connect(
    host="localhost", user="root", password="xyz066@S", database="honey_demo"
)
cursor = db.cursor(dictionary=True)

# --- 2. Blockchain (Ganache) Setup ---
w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))
private_key = "0x6e01f0e7dd7085d77801f565ccc545ee232aa3828fca5fd8470954fe5bd0cbcc"
account = w3.eth.account.from_key(private_key)
contract_address = "0x0CA005452503A34648F78079164dDceb65Ec0727"


# Copy the ABI array from Remix after compiling your Solidity contract
contract_abi = json.loads('[{"inputs":[{"internalType":"string","name":"_hiveId","type":"string"},{"internalType":"uint256","name":"_weightKg","type":"uint256"}],"name":"createBatch","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_batchId","type":"uint256"}],"name":"verifyBatch","outputs":[{"internalType":"string","name":"","type":"string"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]')
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

# --- 3. API Endpoints ---
@app.get("/hive-status")
def get_hive_status():
    cursor.execute("SELECT * FROM hive_data ORDER BY timestamp DESC LIMIT 1")
    return cursor.fetchone()

@app.post("/create-batch")
def create_batch(hive_id: str, weight: int):
    # Send Transaction to Ganache
    tx = contract.functions.createBatch(hive_id, weight).build_transaction({
        'from': account.address,
        'nonce': w3.eth.get_transaction_count(account.address),
        'gas': 2000000,
        'gasPrice': w3.eth.gas_price
    })
    signed_tx = w3.eth.account.sign_transaction(tx, private_key)
    tx_hash = w3.eth.send_raw_transaction(signed_tx.raw_transaction)
    
    return {"message": "Batch Created on Blockchain!", "tx_hash": tx_hash.hex()}
