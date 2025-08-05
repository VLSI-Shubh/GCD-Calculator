#!/bin/bash

# Compile the Verilog design and testbench
echo "Compiling Verilog files..."

iverilog -o GCD_while.vvp GCD_while.v

# Run the simulation
echo "Running simulation..."

vvp GCD_while.vvp