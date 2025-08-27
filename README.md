# 📐 GCD Calculator using FSM and Datapath Design

This project implements a **Greatest Common Divisor (GCD)** calculator in Verilog, showcasing **two different approaches** to solving the same mathematical problem. The project emphasizes **digital hardware design principles** by comparing:

1. A **behavioral Verilog model** using `while` loop and modulus (`%`) operator  
2. A **fully synthesizable FSM + Datapath architecture** using the subtraction-based Euclidean algorithm

While both approaches are functionally correct, this project is primarily built around the **FSM + Datapath design**, which mirrors the internal workings of a CPU and is suitable for **actual hardware implementation**.

---

## 🧠 Project Overview

The main learning goal of this project was to explore the **controller + datapath design pattern**, which is foundational in modern CPU architecture. The FSM handles sequencing and logic control, while the datapath performs the arithmetic operations.

Additionally, an alternate Verilog implementation using a `while` loop and `%` modulus operator is included to compare both **hardware feasibility** and **performance considerations**.

---

## ⚙️ Design Approaches

### 🔧 Approach 1: Behavioral Verilog using `while` + `%` (Simulation Only)

This model follows the traditional GCD approach taught in programming courses — repeatedly applying modulus until one operand becomes zero.

```verilog
while (a != 0 && b != 0) {
    if (a > b)
        a = a % b;
    else
        b = b % a;
}
gcd = (a == 0) ? b : a;
```

- ✅ Functional in simulation  
- ❌ Not synthesizable  
- ⚠️ Uses `%` operator and `while` loop, which do not map directly to logic gates  
- 📂 Module: `GCD_while.v`, `GCD_while_tb.v`

This version is helpful for **early-stage functional validation**, but not suitable for synthesis or FPGA/ASIC design.

---

### ⚙️ Approach 2: FSM + Datapath using Subtraction (Synthesizable)

This is the core of the project. It builds a **hardware-friendly GCD unit** by breaking the design into:

- **Datapath**:
  - Subtractor
  - Comparator
  - Registers (PIPO)
  - MUXes  
- **Controller FSM**:
  - Issues control signals (`lda`, `ldb`, `sel1`, `sel2`, `sel3`)
  - Monitors condition flags (`Lt`, `Gt`, `Et`)
  - Determines which operand to update each cycle

This architecture mimics **how processors execute arithmetic through datapaths and control units**, making it an excellent exercise in **VLSI and digital system design**.

---

## 🔁 Why I Chose the FSM-Based Subtraction Approach

While both methods compute the GCD correctly, the final design was centered around the subtraction method for **hardware feasibility**:

| Feature | Subtraction Method | Modulus Method |
|--------|--------------------|----------------|
| Synthesizable | ✅ Yes | ❌ No |
| Hardware Resource Cost | Low (simple subtractor) | High (requires division circuitry) |
| Performance | Faster in hardware | Slower due to modulo complexity |
| Suitability | Excellent for FSM control | Best for simulation only |
| Final Choice | ✅ Chosen | ❌ Rejected for synthesis |

In digital hardware, **modulus (`%`) is slower and resource-heavy** compared to subtraction. Since both approaches require repetitive operations until convergence, the **subtraction method is computationally more efficient in a circuit**. Subtraction is just an adder with inversion and carry-in, while modulus requires division hardware or iterative logic, making it costlier and slower.

Thus, I opted to go with the **FSM + Datapath design** and treated the behavioral model as a learning milestone rather than the final implementation.

![Circuit Block Diagram](https://github.com/VLSI-Shubh/GCD-Calculator/blob/d8f045c2119be38e65745db2c3375080d7613f1c/images/Block%20diagram%20circuit.jpeg)

---

## 🧩 Architecture Overview

### 🧭 FSM Controller

#### 📉 Controller Flowchart  
![Controller Flowchart](https://github.com/VLSI-Shubh/GCD-Calculator/blob/dfcf05d9cfe588bd599af36a1a3003621496baa2/images/controller%20flow%20chart.jpeg)

The FSM transitions through 6 states:

| State | Function |
|-------|----------|
| S0    | Load first operand A |
| S1    | Load second operand B |
| S2    | Check for equality or decide subtraction direction |
| S3    | A > B: Subtract B from A |
| S4    | B > A: Subtract A from B |
| S5    | Done — GCD ready |

#### 🔁 FSM State Diagram  
![FSM State Diagram](https://github.com/VLSI-Shubh/GCD-Calculator/blob/dfcf05d9cfe588bd599af36a1a3003621496baa2/images/controller%20FSM.jpeg)

---

### 🔧 Datapath Components

#### 📘 Datapath Flowchart  
![Datapath Flowchart](https://github.com/VLSI-Shubh/GCD-Calculator/blob/dfcf05d9cfe588bd599af36a1a3003621496baa2/images/Datapath%20algorithm.jpeg)

| Component | Role |
|-----------|------|
| `pipo.v` | Registers to hold A and B |
| `subtractor.v` | Performs `A - B` or `B - A` |
| `comparator.v` | Generates `Lt`, `Gt`, `Et` flags |
| `mux_2x1.v` | Select paths for operand and result routing |

#### 🧮 Datapath Circuit  
![Datapath Circuit](https://github.com/VLSI-Shubh/GCD-Calculator/blob/dfcf05d9cfe588bd599af36a1a3003621496baa2/images/datapath%20circuit.jpeg)

---

## 🔬 Output Snapshots

> Example terminal output for FSM + Datapath design (from testbench with inputs 4 and 24):

```
GCD calculation completed
GCD of the two numbers is: 4
```

### 📷 Subtraction-Based FSM Model Output  
![Subtraction Output](https://github.com/VLSI-Shubh/GCD-Calculator/blob/dfcf05d9cfe588bd599af36a1a3003621496baa2/images/substraction%20output.gif)

### 🧮 Modulus-Based While Loop Output  
![Modulus Output](https://github.com/VLSI-Shubh/GCD-Calculator/blob/dfcf05d9cfe588bd599af36a1a3003621496baa2/images/modulus%20output.gif)

---

## 🏗️ Synthesis Results

The Controller + Datapath GCD design was synthesized successfully, confirming that the architecture is **fully hardware realizable**.

### 📷 Synthesis Screenshot
![Synthesis Screenshot](https://github.com/VLSI-Shubh/GCD-Calculator/blob/07a8d73211b95a545ba648e508c2d640e752e414/images/schematic.png)

### 📄 Generated Netlist Schematic
A detailed schematic was auto-generated during synthesis, showcasing how the datapath and FSM logic are mapped into gates and registers.

🔗 [Download Schematic PDF](https://github.com/VLSI-Shubh/GCD-Calculator/blob/07a8d73211b95a545ba648e508c2d640e752e414/images/schematic.pdf)

---

## 📁 Project Files

| File | Description |
|------|-------------|
| `datapath.v`         | Main datapath module |
| `controller.v`       | FSM controller logic |
| `pipo.v`             | PIPO register |
| `subtractor.v`       | Arithmetic subtractor |
| `comparator.v`       | Comparison logic |
| `mux_2x1.v`          | 2:1 multiplexer |
| `gcd_tb.v`           | Testbench for FSM-based GCD |
| `GCD_while.v`        | Behavioral GCD using while + modulus |
| `GCD_while_tb.v`     | Testbench for `GCD_while` |
| `images/`            | Waveform and output screenshots |
| `*.vcd`              | Simulation waveform files |

---

## 🛠️ Tools Used

| Tool               | Purpose                                           |
|--------------------|---------------------------------------------------|
| **Icarus Verilog** | Compile/simulate Verilog code                    |
| **GTKWave**        | View simulation waveform dumps (`.vcd` files)    |
| **EDA Playground** | Online Verilog editor and schematic viewer       |

---
## ✅ Conclusion

This project demonstrates two distinct ways to compute GCD in Verilog — one focused on **hardware synthesis** and the other on **algorithmic clarity**:

- The FSM-based subtraction model is **modular, synthesizable**, and suited for real hardware.  
- The while + modulus approach offers **quick simulation modeling** but is **not synthesizable** and impractical in hardware.

Through this, I gained a deeper understanding of:

- FSM and datapath partitioning  
- Hardware implementation vs behavioral modeling  
- Trade-offs in algorithm selection based on speed and synthesizability

---

## 📝 License


Open for educational and personal use under the [MIT License](https://github.com/VLSI-Shubh/GCD-Calculator/blob/0aed2b6cbe53a69f572582162a2f4a3701c9c94d/License.txt)


