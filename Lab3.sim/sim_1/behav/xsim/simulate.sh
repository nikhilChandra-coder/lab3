#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Mar 27 18:35:34 EDT 2025
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
#
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim uart_top_tb_behav -key {Behavioral:sim_1:Functional:uart_top_tb} -tclbatch uart_top_tb.tcl -log simulate.log"
xsim uart_top_tb_behav -key {Behavioral:sim_1:Functional:uart_top_tb} -tclbatch uart_top_tb.tcl -log simulate.log

