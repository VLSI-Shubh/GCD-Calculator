#!/bin/bash

# Compile the Verilog design and testbench
echo "Compiling Verilog files..."

iverilog -o gcd_tb.vvp gcd_tb.v

# Run the simulation
echo "Running simulation..."

vvp gcd_tb.vvp
