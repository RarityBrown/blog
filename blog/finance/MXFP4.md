# MXFP4

gpt-oss 的发布，从硬件角度讲，我个人认为最关键的是 MXFP4。很明显，intel 确实掉队了：


| Company   | Product                                                      | release date  | on customers' rack date | MXFP4 Support?                                               |
| --------- | ------------------------------------------------------------ | ------------- | ----------------------- | ------------------------------------------------------------ |
| Nvidia    | Blackwell GPUs                                               | Mar 18, 2024  | Q4 2024                 | ✔️ Hardware                                                     |
| AMD       | Instinct MI350 Series (CDNA 4)                               | June 12, 2025 | Q3 2025                 | ✔️ [Hardware](https://www.amd.com/content/dam/amd/en/documents/instinct-tech-docs/white-papers/amd-cdna-4-architecture-whitepaper.pdf) |
| Intel     | Gaudi 3                                                      | Apr 9, 2024   | Q4 2024                 | ⚠️ [Software](https://newsroom.intel.com/artificial-intelligence/vision-2024-enterprise-ai-gaudi-3-open-systems-strategy) |
| Synopsys  | [ARC VPX DSP IP](https://www.synopsys.com/articles/narrow-precision-data-types-embedded-ai.html) | Jul 17, 2025  | -                       | ✔️ Hardware                                                     |
| Google    | TPU v7                                                       | Apr 9, 2025   | Q4 2025                 | ❌ [Software? / No?](https://www.reddit.com/r/singularity/comments/1kevvfa/hardware_nerds_ironwood_vs_blackwellrubin/) |
| Microsoft | Maia 100                                                     | Nov 2023      | Q1 2024                 | ✔️ Hardware                                                     |
| AWS       | Trainium 3                                                   | Q4 2025       | Q4 2025                 | ❓                                                            |
| IBM       | Spyre                                                        | Aug 26, 2024  | Q4 2025                 | ❌ No?                                                          |
|           |                                                              |               |                         |                                                              |
| Huawei    | 昇腾 Ascend 920                                              | Q4 2025       | ?                       | ❓                                                           |

以下是一些观点：

- Huawei 别说追上 Nvidia，距离 [AMD](https://huggingface.co/amd/DeepSeek-R1-MXFP4-Preview) 还有不少距离。当然，我个人认为 TSMC 不给代工仍然是造成这个距离的主要原因。
- 现在 OpenAI 等企业的话语权已经可以深入到 Microsoft, Nvidia, AMD 等公司的 GPU spec 定义阶段了，所以 IC 本质上还是做他人嫁衣啊
- MXFP4 的[标准](https://www.opencompute.org/documents/ocp-microscaling-formats-mx-v1-0-spec-final-pdf)也不是 IEEE 最先确定了，而是 opencompute 来决定了。FP8 这个故事已经发生过一次了，有一点互联网思维战胜硬件工程师思维的感觉。
