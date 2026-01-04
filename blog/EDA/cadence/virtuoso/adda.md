## Virtuoso tips for ADDA simulation

> Excerpted from *Analog IP Verification Seminar - ADC Verification Methodology, Best Practices*     source: [eetop](https://bbs.eetop.cn/thread-969302-1-1.html)



### Variation-aware design methodology



|             Parasitics/LDE (Layout Dependent Effects)        |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/20b0cfb2-fa4d-40de-b131-06b0037442c7) | ![](https://github.com/user-attachments/assets/605a96a0-4798-4db4-a3ee-466a79b21d94) |

for more: Parasitic Aware Design (PAD) Flow RAK, from [eetop](https://blog.eetop.cn/space-uid-1113959.html)

### Spectre

Take-away: 

- ❌ Large voltages in Verilog-A
- ✅ `cktpreset=sampled`

![](https://github.com/user-attachments/assets/9ad31662-88c0-4ac8-8ca2-dca1b04d9932)

