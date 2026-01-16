# FPGA UART Communication Project

FPGA UART communication project implemented in VHDL, focusing on digital design and embedded systems fundamentals.

This project demonstrates a basic UART (Universal Asynchronous Receiver/Transmitter)
communication system implemented in VHDL and verified using simulation.

The design includes a UART receiver and transmitter integrated in a top-level module.
A dedicated testbench is used to simulate UART frames and verify correct data reception
and transmission.

## Project Structure

fpga/
- top.vhd        : Top-level module integrating UART RX and TX
- uart_rx.vhd    : UART receiver module
- uart_tx.vhd    : UART transmitter module
- tb_top.vhd     : Testbench for simulation

## Features

- UART RX and TX implementation in VHDL
- Parameterized baud rate
- Simulation-based verification
- Modular and clean design

## Tools Used

- VHDL
- Xilinx Vivado
- Behavioral Simulation

## Notes

This project was developed for learning purposes and internship preparation.
The design focuses on understanding UART communication and FPGA-based digital design.

## Author

Bera

