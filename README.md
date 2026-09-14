<div align="center">

# 🍯 Honey Chain (Prototype)

**IoT-to-Blockchain Traceability Proof-of-Concept**

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi)](https://fastapi.tiangolo.com/)
[![Solidity](https://img.shields.io/badge/Solidity-363636?style=for-the-badge&logo=solidity&logoColor=white)](https://soliditylang.org/)

</div>

---

## 📖 Overview
**Honey Chain** is a cross-functional Web3 AgriTech prototype demonstrating how supply chain data can be securely tracked from apiary to consumer. This repository contains the foundational Proof-of-Concept (PoC), utilizing simulated IoT telemetry, a local FastAPI backend, and a local EVM testnet (Ganache) to hash and notarize harvest records.

## 🏗️ Prototype Architecture

| Layer | Technology | Current Implementation Status |
| :--- | :--- | :--- |
| **Hardware** | Python Simulation | Currently using `simulate_telemetry.py` to generate randomized weight and temperature metrics, mocking an ESP32 sensor node. |
| **Backend** | Python, FastAPI | Local REST API designed to ingest simulated hardware payloads and interact with the local blockchain. |
| **Blockchain** | Solidity, Ganache | Local EVM testnet deploying the `HoneyBatch.sol` contract to store Keccak-256 hashes of the telemetry data. |
| **Client** | Flutter | Scaffolded cross-platform mobile application intended to display the supply chain dashboard. |

## 📂 Repository Structure
```text
honey-chain/
├── app/                  # Flutter client UI (Skeleton)
├── backend/              # FastAPI server and Web3.py integration
├── contracts/            # Solidity smart contracts (HoneyBatch.sol)
└── hardware/             # IoT simulation scripts (simulate_telemetry.py)