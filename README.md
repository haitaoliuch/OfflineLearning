# Offline Sequential Learning via Simulation
This repository contains the source codes used in the paper: "offline sequential learning via simulation", submitted to IISE Transactions.

WARNING: These codes are written only for the purpose of demonstration and verification. 
While the correctness has been carefully checked, the quality such as standardability, clarity, generality, and efficiency has not been well considered.

The codes were written and run in MATLAB R2020a, on Windows 10.

Numerical Experiments:
	(1) You can set the numerical setting in demo.m, such as the simulation budget, number of replications, threshold value,and problem types.
	(2) When the dimension of design space is medium or large, you can use highD.m in folder ``Synthetic data generation'' to generate synthetic data.
	(3) You should run demoH.m to obtain the results of random and hIG policies.
