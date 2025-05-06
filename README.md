# SPI UVM project
# Overview
This project verifies an SPI (Serial Peripheral Interface) slave module integrated with internal RAM using the Universal Verification Methodology (UVM) in SystemVerilog. The goal is to validate the data integrity and control logic of the SPI slave and RAM through a wrapper interface, simulating a variety of protocol-level and memory-level scenarios.

The verification environment includes one active UVM agent for the wrapper and two passive agents to monitor the SPI slave and RAM modules. The testbench targets functional correctness, edge case validation, and interface compliance.

# Features
**UVM-Based Testbench**: A modular UVM environment including drivers, monitors, agents, and scoreboards.
- **Protocol & Memory Monitoring**: SPI slave and RAM are monitored passively to validate behavior without direct influence.
- **Functional Coverage**: Captures all valid SPI transactions, memory accesses, and edge cases.
- **Randomized Sequences**: Drives various read/write operations and protocol-level timing scenarios through the wrapper.
- **Scoreboarding**: Matches expected vs actual data through both SPI and RAM channels.

# How to Run the Simulation
1. **Set Up the Environment**
   - Ensure you have a SystemVerilog simulator installed (QuestaSim).
   - Clone the repository and navigate to the project directory.

2. **Compile and Run**
   - Use the provided `do` file 

# Key Components
Wrapper Interface: Connects the SPI slave with RAM; serves as the main control logic and is stimulated by the active agent.

SPI Slave Agent (Passive): Observes SPI protocol signals (MOSI, MISO, SCLK, SS) and captures command/data transactions.

RAM Agent (Passive): Monitors memory interface signals for reads/writes without injecting stimulus.

Wrapper Agent (Active): Drives functional sequences to stimulate SPI-to-RAM operations via the wrapper module.

Scoreboard: Verifies correctness of data transferred through the system.

Coverage Collector: Ensures all critical functional scenarios are exercised during simulation.

# Features Tested
SPI Read/Write Transactions: Validates transfer of commands and data through the SPI slave.

RAM Write and Read: Ensures correct data is stored and retrieved via wrapper.

Protocol Timing Compliance: Tests proper timing alignment and response behavior.

Edge Cases: Tests scenarios like mid-transaction resets, back-to-back transactions, and full memory writes.

Transaction Consistency: Compares command/data integrity between input and memory content.

# uvm_testbench
![ChatGPT Image May 6, 2025, 10_08_02 PM](https://github.com/user-attachments/assets/969884d8-f71f-428f-be3b-f4367dd96fd4)


