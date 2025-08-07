#  16-bit Pipelined ALU

This project implements a **16-bit Arithmetic Logic Unit (ALU)** with a **3-stage pipeline** architecture in Verilog HDL. The design is simulation-only and uses modular sub-blocks for each ALU operation. A testbench demonstrates functionality and pipeline behavior via waveform visualization.

---

##  Features

- **3-stage pipelined ALU**: Fetch → Execute → Write-back
- **Supports 9 operations** using a 4-bit `opcode`
- **Modular design**: Each operation is implemented as a separate Verilog module
- **Status flag generation**: Zero (Z), Carry (C), Overflow (V), Negative (N)
- **Waveform analysis** with `.vcd` output viewable in GTKWave

---

##  Supported Operations and Opcodes

| Opcode   | Operation           | Description                                |
|----------|---------------------|--------------------------------------------|
| `0000`   | ADD                 | `result = A + B`                           |
| `0001`   | SUB                 | `result = A - B`                           |
| `0010`   | AND                 | `result = A & B`                           |
| `0011`   | OR                  | `result = A | B`                           |
| `0100`   | XOR                 | `result = A ^ B`                           |
| `0101`   | NOT                 | `result = ~A` (ignores B)                  |
| `0110`   | Logical Left Shift  | `result = A << 1`                          |
| `0111`   | Logical Right Shift | `result = A >> 1`                          |
| `1000`   | Compare             | `result = 1 if A==B, 2 if A>B, 0 if A<B`   |

---

##  Pipeline Stages & Delay Explanation

The ALU uses a **3-stage pipeline**:

1. **Fetch**: Capture inputs (`A`, `B`) and opcode
2. **Execute**: Perform the selected operation using the respective submodule
3. **Write-back**: Store the result and update the status flags

Due to pipelining, each result appears **after 2 clock cycles**. This design mimics real CPU behavior by improving throughput — while a single operation is executing, others can be fetched or written back.

---

##  Tools Used

- Verilog HDL
- Vivado Simulator / ModelSim


