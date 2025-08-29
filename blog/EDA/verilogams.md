# Verilog-A, Verilog-AMS, SystemVerilog-AMS

Docs:

- [Designer’s Guide Community :: Verilog-AMS](https://designers-guide.org/verilog-ams/index.html)
- [Verilog-A/MS — Documentation](https://verilogams.com/index.html)
- [Download Verilog-AMS (Analog/Mixed-Signal) - Accellera Systems Initiative](https://www.accellera.org/downloads/standards/v-ams)
- Cadence Verilog-AMS Language Reference (`verilogamsref.pdf`)

Examples:

- [dwarning/VA-Models: Verilog-A simulation models](https://github.com/dwarning/VA-Models)
- [medwatt/Verilog-A](https://github.com/medwatt/Verilog-A)

### A simple digital stimulus written in Verilog-AMS


Verilog-A 13-Bit Synchronous Pattern Generator: This module generates a finite, 240-cycle digital pattern on a 13-bit output bus, `D[12:0]`.

**Key Specifications:**
*   **Ports:**
    *   `CLK`: Electrical Input.
    *   `D[12:0]`: Electrical Output.
*   **Core Logic:**
    *   The module is synchronous and updates its output state on the **falling edge** of the `CLK` input.
    *   The clock input threshold (`vth`) is defined as `(V_HIGH + V_LOW) / 2`.
    *   It generates a 240-cycle pattern, after which the output holds the final state.
*   **Generated Pattern Sequence:**
    *   **Cycles 0-79:**      An up-counter, from `13'd0` to `13'd79`.
    *   **Cycles 80-159:**    A 13-bit pseudo-random value. The sequence must be reproducible (i.e., generated from a fixed seed).
    *   **Cycles 160-239:**   A down-counter for 80 cycles, starting from `13'h1FFF` (all ones).
*   **Output Waveform Specifications:**
    *   `V_HIGH`: `1.0 V`
    *   `V_LOW`: `0.0 V`
    *   `Rise Time`: `50 ps`
    *   `Fall Time`: `50 ps`

```verilog
// todo
```
