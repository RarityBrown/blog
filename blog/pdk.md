# PDK

## SMIC

### Digital

<svg width="1250" height="750" xmlns="http://www.w3.org/2000/svg" font-family="sans-serif">
  <!-- Define styles for reuse -->
  <defs>
    <style>
      .block {
        fill: #e0f2fe; /* light blue */
        stroke: #0ea5e9; /* darker blue */
        stroke-width: 1;
        rx: 12;
        ry: 12;
      }
      .block-text {
        font-size: 24px;
        fill: #333;
        text-anchor: middle;
        dominant-baseline: middle;
      }
      .header-text {
        font-size: 12px;
        fill: #444;
        text-anchor: middle;
      }
      .title-text {
        font-size: 20px;
        font-weight: bold;
        text-anchor: middle;
        fill: #000;
      }
      /* Style for explanation boxes */
      .explanation-box {
        fill: #f3f4f6; /* light gray */
        stroke: #9ca3af; /* darker gray */
        stroke-width: 1;
        rx: 6; /* smaller radius */
        ry: 6;
      }
      .explanation-text {
        font-size: 11px; /* smaller than header */
        fill: #555;
        text-anchor: middle;
        /* dominant-baseline: middle; no longer strictly middle for multi-line */
      }
      /* Specific adjustments for wrapped text */
      .explanation-text tspan {
         text-anchor: middle;
      }
    </style>
  </defs>
  <!-- Title -->
  <text x="625" y="40" class="title-text">SMIC Library Filename Structure Breakdown</text>
  <!-- Column Headers (Y adjusted slightly for spacing) -->
  <text x="70"  y="75" class="header-text">Foundry:</text>
  <text x="190" y="75" class="header-text">Technology Node:</text>
  <text x="310" y="75" class="header-text">Lib Type/App:</text>
  <text x="430" y="75" class="header-text">Speed / Density</text>
  <text x="550" y="75" class="header-text">Threshold Voltage (Vt)</text>
  <text x="670" y="75" class="header-text">Process Corner (P):</text>
  <text x="790" y="75" class="header-text">Voltage Corner (V)</text>
  <text x="910" y="75" class="header-text">Temperature Corner (T):</text>
  <text x="1030" y="75" class="header-text">Model Type:</text>
  <text x="1150" y="75" class="header-text">File Extension:</text>
  <!--
    Block: width=110, height=50.
    Explanation Box: width=110, height=35.
    Vertical gap between blue and gray = 5px.
    Vertical gap between gray box and next row's blue box = 40px.
    Total vertical step between rows = 50 + 5 + 35 + 40 = 130px.
    Row 1 Y = 95
    Row 2 Y = 225 (95 + 130)
    Row 3 Y = 355 (225 + 130)
    Row 4 Y = 485 (355 + 130)
    Row 5 Y = 615 (485 + 130)
  -->
  <!-- Row 1 Data - Y = 95 -->
  <g id="row1">
    <!-- scc -->
    <rect x="15" y="95" width="110" height="50" class="block"/>
    <text x="70" y="120" class="block-text">scc</text>
    <rect x="15" y="150" width="110" height="35" class="explanation-box"/>
    <text x="70" y="167.5" class="explanation-text" dominant-baseline="middle">SMIC Code</text>
    <!-- 018u (Col 2) -->
    <rect x="135" y="95" width="110" height="50" class="block"/>
    <text x="190" y="120" class="block-text">018u</text>
    <rect x="135" y="150" width="110" height="35" class="explanation-box"/>
    <text x="190" y="167.5" class="explanation-text" dominant-baseline="middle">0.18 µm Node</text>
    <!-- ms (Col 3) -->
    <rect x="255" y="95" width="110" height="50" class="block"/>
    <text x="310" y="120" class="block-text">ms</text>
    <rect x="255" y="150" width="110" height="35" class="explanation-box"/>
    <text x="310" y="167.5" class="explanation-text" dominant-baseline="middle">Mixed-Signal</text>
    <!-- hsw (Col 4) -->
    <rect x="375" y="95" width="110" height="50" class="block"/>
    <text x="430" y="120" class="block-text">hsw</text>
    <rect x="375" y="150" width="110" height="35" class="explanation-box"/>
    <text x="430" y="167.5" class="explanation-text" dominant-baseline="middle">High Speed (+well?)</text>
    <!-- rvt (Col 5) -->
    <rect x="495" y="95" width="110" height="50" class="block"/>
    <text x="550" y="120" class="block-text">rvt</text>
    <rect x="495" y="150" width="110" height="35" class="explanation-box"/>
    <text x="550" y="167.5" class="explanation-text" dominant-baseline="middle">Regular VT</text>
    <!-- ff (Col 6) -->
    <rect x="615" y="95" width="110" height="50" class="block"/>
    <text x="670" y="120" class="block-text">ff</text>
    <rect x="615" y="150" width="110" height="35" class="explanation-box"/>
    <text x="670" y="167.5" class="explanation-text" dominant-baseline="middle">Fast NMOS/PMOS</text>
    <!-- v1p98 (Col 7) -->
    <rect x="735" y="95" width="110" height="50" class="block"/>
    <text x="790" y="120" class="block-text">v1p98</text>
    <rect x="735" y="150" width="110" height="35" class="explanation-box"/>
    <text x="790" y="167.5" class="explanation-text" dominant-baseline="middle">1.98 Volts</text>
    <!-- -40c (Col 8) -->
    <rect x="855" y="95" width="110" height="50" class="block"/>
    <text x="910" y="120" class="block-text">-40c</text>
    <rect x="855" y="150" width="110" height="35" class="explanation-box"/>
    <text x="910" y="167.5" class="explanation-text" dominant-baseline="middle">-40° Celsius</text>
    <!-- basic (Col 9) -->
    <rect x="975" y="95" width="110" height="50" class="block"/>
    <text x="1030" y="120" class="block-text">basic</text>
    <rect x="975" y="150" width="110" height="35" class="explanation-box"/>
    <text x="1030" y="167.5" class="explanation-text" dominant-baseline="middle">Non-Linear Delay Model</text> <!-- MODIFIED -->
    <!-- .db (Col 10) -->
    <rect x="1095" y="95" width="110" height="50" class="block"/>
    <text x="1150" y="120" class="block-text">.db</text>
    <rect x="1095" y="150" width="110" height="35" class="explanation-box"/>
    <text x="1150" y="167.5" class="explanation-text" dominant-baseline="middle">Liberty DB</text>
  </g>
  <!-- Row 2 Data - Y = 225 (95 + 130) -->
   <g id="row2">
    <!-- No Col 1 -->
    <!-- 55n (Col 2) -->
    <rect x="135" y="225" width="110" height="50" class="block"/>
    <text x="190" y="250" class="block-text">55n</text>
    <rect x="135" y="280" width="110" height="35" class="explanation-box"/>
    <text x="190" y="297.5" class="explanation-text" dominant-baseline="middle">55 nm Node</text>
    <!-- g (Col 3) -->
    <rect x="255" y="225" width="110" height="50" class="block"/>
    <text x="310" y="250" class="block-text">g</text>
    <rect x="255" y="280" width="110" height="35" class="explanation-box"/>
    <text x="310" y="297.5" class="explanation-text" dominant-baseline="middle">Generic Logic Process</text>
    <!-- uhd (Col 4) -->
    <rect x="375" y="225" width="110" height="50" class="block"/>
    <text x="430" y="250" class="block-text">uhd</text>
    <rect x="375" y="280" width="110" height="35" class="explanation-box"/>
    <text x="430" y="297.5" class="explanation-text" dominant-baseline="middle">Ultra High Density</text>
    <!-- hvt (Col 5) -->
    <rect x="495" y="225" width="110" height="50" class="block"/>
    <text x="550" y="250" class="block-text">hvt</text>
    <rect x="495" y="280" width="110" height="35" class="explanation-box"/>
    <text x="550" y="297.5" class="explanation-text" dominant-baseline="middle">High VT</text>
    <!-- ss (Col 6) -->
    <rect x="615" y="225" width="110" height="50" class="block"/>
    <text x="670" y="250" class="block-text">ss</text>
    <rect x="615" y="280" width="110" height="35" class="explanation-box"/>
    <text x="670" y="297.5" class="explanation-text" dominant-baseline="middle">Slow NMOS/PMOS</text>
    <!-- No Col 7 -->
    <!-- 0c (Col 8) -->
    <rect x="855" y="225" width="110" height="50" class="block"/>
    <text x="910" y="250" class="block-text">0c</text>
    <rect x="855" y="280" width="110" height="35" class="explanation-box"/>
    <text x="910" y="297.5" class="explanation-text" dominant-baseline="middle">0° Celsius</text>
    <!-- ccs (Col 9) -->
    <rect x="975" y="225" width="110" height="50" class="block"/>
    <text x="1030" y="250" class="block-text">ccs</text>
    <rect x="975" y="280" width="110" height="35" class="explanation-box"/>
    <!-- Wrapped Text -->
    <text x="1030" y="292.5" class="explanation-text" font-size="10">
      <tspan x="1030">Composite Current</tspan>
      <tspan x="1030" dy="1.2em">Source (Synopsys)</tspan>
    </text>
    <!-- .lib (Col 10) - MOVED HERE -->
    <rect x="1095" y="225" width="110" height="50" class="block"/>
    <text x="1150" y="250" class="block-text">.lib</text>
    <rect x="1095" y="280" width="110" height="35" class="explanation-box"/>
    <!-- Wrapped Text -->
    <text x="1150" y="292" class="explanation-text"> <!-- Adjusted y for 2 lines -->
        <tspan x="1150">Liberty Compiled</tspan> <!-- MODIFIED -->
        <tspan x="1150" dy="1.2em">(Synopsys)</tspan>
    </text>
  </g>
  <!-- Row 3 Data - Y = 355 (225 + 130) -->
  <g id="row3">
    <!-- No Col 1, 2 -->
     <!-- ll (Col 3) -->
    <rect x="255" y="355" width="110" height="50" class="block"/>
    <text x="310" y="380" class="block-text">ll</text>
    <rect x="255" y="410" width="110" height="35" class="explanation-box"/>
    <text x="310" y="427.5" class="explanation-text" dominant-baseline="middle">Low Leakage</text>
    <!-- hd (Col 4) -->
    <rect x="375" y="355" width="110" height="50" class="block"/>
    <text x="430" y="380" class="block-text">hd</text>
    <rect x="375" y="410" width="110" height="35" class="explanation-box"/>
    <text x="430" y="427.5" class="explanation-text" dominant-baseline="middle">High Density</text>
    <!-- lvt (Col 5) -->
    <rect x="495" y="355" width="110" height="50" class="block"/>
    <text x="550" y="380" class="block-text">lvt</text>
    <rect x="495" y="410" width="110" height="35" class="explanation-box"/>
    <text x="550" y="427.5" class="explanation-text" dominant-baseline="middle">Low VT</text>
    <!-- tt (Col 6) -->
    <rect x="615" y="355" width="110" height="50" class="block"/>
    <text x="670" y="380" class="block-text">tt</text>
    <rect x="615" y="410" width="110" height="35" class="explanation-box"/>
    <text x="670" y="427.5" class="explanation-text" dominant-baseline="middle">Typical NMOS/PMOS</text>
    <!-- No Col 7 -->
    <!-- 25c (Col 8) -->
    <rect x="855" y="355" width="110" height="50" class="block"/>
    <text x="910" y="380" class="block-text">25c</text>
    <rect x="855" y="410" width="110" height="35" class="explanation-box"/>
    <text x="910" y="427.5" class="explanation-text" dominant-baseline="middle">25° Celsius</text>
    <!-- ecsm (Col 9) -->
    <rect x="975" y="355" width="110" height="50" class="block"/>
    <text x="1030" y="380" class="block-text">ecsm</text>
    <rect x="975" y="410" width="110" height="35" class="explanation-box"/>
    <!-- Wrapped Text -->
    <text x="1030" y="422.5" class="explanation-text" font-size="10">
      <tspan x="1030">Effective Current</tspan>
      <tspan x="1030" dy="1.2em">Source Model (Cadence)</tspan>
    </text>
    <!-- No Col 10 -->
   </g>
   <!-- Row 4 Data - Y = 485 (355 + 130) -->
   <g id="row4">
     <!-- No Col 1-3 -->
     <!-- hs (Col 4) -->
     <rect x="375" y="485" width="110" height="50" class="block"/>
     <text x="430" y="510" class="block-text">hs</text>
     <rect x="375" y="540" width="110" height="35" class="explanation-box"/>
     <text x="430" y="557.5" class="explanation-text" dominant-baseline="middle">High Speed</text>
     <!-- No Col 5-7 -->
     <!-- 85c (Col 8) -->
     <rect x="855" y="485" width="110" height="50" class="block"/>
     <text x="910" y="510" class="block-text">85c</text>
     <rect x="855" y="540" width="110" height="35" class="explanation-box"/>
     <text x="910" y="557.5" class="explanation-text" dominant-baseline="middle">85° Celsius</text>
     <!-- No Col 9-10 -->
   </g>
   <!-- Row 5 Data - Y = 615 (485 + 130) -->
   <g id="row5">
      <!-- No Col 1-3 -->
      <!-- vhs (Col 4) -->
      <rect x="375" y="615" width="110" height="50" class="block"/>
      <text x="430" y="640" class="block-text">vhs</text>
      <rect x="375" y="670" width="110" height="35" class="explanation-box"/>
      <text x="430" y="687.5" class="explanation-text" dominant-baseline="middle">Very High Speed</text>
      <!-- No Col 5-7 -->
      <!-- 125c (Col 8) -->
     <rect x="855" y="615" width="110" height="50" class="block"/>
     <text x="910" y="640" class="block-text">125c</text>
     <rect x="855" y="670" width="110" height="35" class="explanation-box"/>
     <text x="910" y="687.5" class="explanation-text" dominant-baseline="middle">125° Celsius</text>
     <!-- No Col 9-10 -->
   </g>
</svg>


## TSMC

上海集成电路技术与产业促进中心 (SHICC) 和 TSMC 签 NDA 的 pdk 泄露过，所以在闲鱼上可以买到 70% 左右全的老版本 tsmc 28nm pdk，也有一些同款的[免费资源](https://mp.weixin.qq.com/s/eEymBHAeKTUs6YYu8YyLrw)分享

resource: 

> TSMC reference flow 12.0
> TSMC AMS Reference Flow 2.0
> TN28CLDR002_2_2.pdf (20231229)

### Digital

Directory structure:

`tcbn28hpcplusbwp7t30p140`

> https://zhuanlan.zhihu.com/p/5873231713
> 

```
TSMCHOME
└── digital
    ├── IMPORTANT.NOTE
    ├── VERSION_NUMBERING_SCHEME.txt
    ├── Back_End
    │   ├── cdk
    │   │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │   │       ├── cds.lib
    │   │       ├── display.drf
    │   │       └── tcbn...hvt, tcbn...lvt, tcbn...ulvt
    │   │           ├── AN2D0BWP7T30P140HVT, AN2D0BWP7T30P140LVT, AN2D0BWP7T30P140ULVT
    │   │           │   ├── data.dm
    │   │           │   ├── hspiceD, hspiceS
    │   │           │   └── layout, schematic, symbol
    │   │           └── ...
    │   ├── celtic
    │   │   └── tcbn...hvt_180a, tcbn...lvt_180a, tcbn...ulvt_180a
    │   │       ├── tcbn...hvtffg0p88v0c.cdb, tcbn...lvtffg0p88v0c.cdb, tcbn...ulvtffg0p88v0c.cdb, 
    │   │       └── ...
    │   ├── gds
    │   │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │   │       └── tcbn...hvt.gds, tcbn...lvt.gds, tcbn...ulvt.gds
    │   ├── lef
    │   │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │   │       ├── DESIGNKIT.INFO
    │   │       └── tcbn...hvt.lef, tcbn...lvt.lef, tcbn...ulvt.lef
    │   ├── lpe_spice
    │   │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │   ├── milkyway
    │   │   ├── tcbn...hvt_170a
    │   │   │   ├── DESIGNKIT.INFO
    │   │   │   ├── cell_frame_VHV_/tcbn...hvt
    │   │   │   │   ├── CEL
    │   │   │   │   └── FRAM
    │   │   │   ├── frame_only_VHV_/tcbn...hvt
    │   │   │   │   ├── CEL
    │   │   │   │   └── FRAM
    │   │   │   └── clf
    │   │   │       └── antenna_tcbn...hvt.clf
    │   │   └── tcbn...lvt_170a, tcbn...ulvt_170a
    │   ├── redhawk
    │   │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │   └── spice
    │       └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │           └── tcbn...hvt_170a.spi, tcbn...lvt_170a.spi, tcbn...ulvt_170a.spi
    ├── Front_End
    │   ├── mentor_dft
    │   │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │   │       └── tcbn...hvt.mdt, tcbn...lvt.mdt, tcbn...ulvt.mdt
    │   ├── SBOCV
    │   │   ├── CCS
    │   │   ├── ECSM
    │   │   └── documents
    │   ├── timing_power_noise
    │   │   ├── CCS
    │   │   │   └── tcbn...hvt_180a, tcbn...lvt_180a, tcbn...ulvt_180a
    │   │   │       ├── tcbn...hvtffg0p88v0c_ccs.db
    │   │   │       ├── tcbn...hvtffg0p88v0c_ccs.lib
    │   │   │       └── ...
    │   │   ├── ECSM
    │   │   │   └── tcbn...hvt_180a, tcbn...lvt_180a, tcbn...ulvt_180a
    │   │   │       ├── tcbn...hvtffg0p88v0c_ecsm.lib
    │   │   │       └── ...
    │   │   └── NLDM
    │   │       └── tcbn...hvt_180a, tcbn...lvt_180a, tcbn...ulvt_180a
    │   │           ├── tcbn...hvtffg0p88v0c.db
    │   │           ├── tcbn...hvtffg0p88v0c.lib
    │   │           └── ...
    │   ├── verilog
    │   │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │   │       ├── tcbn...hvt.v, tcbn...lvt.v, tcbn...ulvt.v
    │   │       └── tcbn...hvt_pwr.v, tcbn...lvt_pwr.v, tcbn...ulvt_pwr.v
    │   └── vital
    │       └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
    │           ├── tcbn...hvt_170a.vhd, tcbn...lvt_170a.vhd, tcbn...ulvt_170a.vhd
    │           ├── Vtable.vhd
    │           └── VCOMPONENT.vhd
    └── Documentation
        ├── documents
        │   └── tcbn...hvt_170a, tcbn...lvt_170a, tcbn...ulvt_170a
        │       ├── DB_TCBN...HVT_TT1V25C.pdf, DB_TCBN...LVT_TT1V25C.pdf, DB_TCBN...ULVT_TT1V25C.pdf
        │       └── ...
        └── release_note
            └── RN_TCBN...HVT_190A.pdf, RN_TCBN...LVT_190A.pdf, RN_TCBN...ULVT_190A.pdf
```


<svg width="1250" height="580" xmlns="http://www.w3.org/2000/svg" font-family="sans-serif">
  <!-- Define styles for reuse -->
  <defs>
    <style>
      .block {
      fill: #e0f7fa; /* light cyan */
      stroke: #0891b2; /* darker cyan */
      stroke-width: 1.5;
      rx: 12;
      ry: 12;
      }
      .block-none {
      fill: #f8fafc; /* very light gray */
      stroke: #94a3b8; /* medium gray */
      stroke-width: 1.5;
      stroke-dasharray: 6 3;
      rx: 12;
      ry: 12;
      }
      .block-text {
      font-size: 24px;
      fill: #1e293b;
      font-weight: 500;
      text-anchor: middle;
      dominant-baseline: middle;
      }
      .block-text-none {
      font-size: 22px;
      fill: #64748b; /* grayed out */
      font-weight: 400;
      text-anchor: middle;
      dominant-baseline: middle;
      }
      .header-text {
      font-size: 13px;
      fill: #475569;
      text-anchor: middle;
      font-weight: 600;
      }
      .title-text {
      font-size: 22px;
      font-weight: bold;
      text-anchor: middle;
      fill: #000;
      }
      .explanation-box {
      fill: #f1f5f9; /* light gray */
      stroke: #94a3b8; /* darker gray */
      stroke-width: 1;
      rx: 6;
      ry: 6;
      }
      .explanation-text {
      font-size: 11px;
      fill: #334155;
      text-anchor: middle;
      }
      .explanation-text tspan {
      text-anchor: middle;
      }
    </style>
  </defs>

  <!-- Title -->
  <text x="625" y="45" class="title-text">TSMC Library Naming Convention Breakdown</text>

  <!-- Column Headers -->
  <!-- Layout: 10 columns, 110px width, 125px center-to-center spacing -->
  <text x="65" y="85" class="header-text">Foundry</text>
  <text x="190" y="85" class="header-text">Library Type</text>
  <text x="315" y="85" class="header-text">Technology Node</text>
  <text x="440" y="85" class="header-text">Application</text>
  <text x="565" y="85" class="header-text">Process Variant</text>
  <text x="690" y="85" class="header-text">Cell Architecture</text>
  <text x="815" y="85" class="header-text">Cell Height</text>
  <text x="940" y="85" class="header-text">Gate Length</text>
  <text x="1065" y="85" class="header-text">Poly Pitch</text>
  <text x="1190" y="85" class="header-text">Version</text>

  <!--
    Block: width=110, height=55. Explanation Box: width=110, height=45.
    Vertical gap between rows = 30px. Total vertical step = 135px.
  -->

  <!-- Row 1: Main Example -->
  <g id="row1">
    <!-- t (Col 1) -->
    <rect x="10" y="105" width="110" height="55" class="block" />
    <text x="65" y="132.5" class="block-text">t</text>
    <rect x="10" y="165" width="110" height="45" class="explanation-box" />
    <text x="65" y="187.5" class="explanation-text" dominant-baseline="middle">TSMC</text>

    <!-- cb (Col 2) -->
    <rect x="135" y="105" width="110" height="55" class="block" />
    <text x="190" y="132.5" class="block-text">cb</text>
    <rect x="135" y="165" width="110" height="45" class="explanation-box" />
    <text x="190" y="187.5" class="explanation-text" dominant-baseline="middle">Standard Cell</text>

    <!-- n28 (Col 3) -->
    <rect x="260" y="105" width="110" height="55" class="block" />
    <text x="315" y="132.5" class="block-text">n28</text>
    <rect x="260" y="165" width="110" height="45" class="explanation-box" />
    <text x="315" y="187.5" class="explanation-text" dominant-baseline="middle">28nm Node</text>

    <!-- hpc (Col 4) -->
    <rect x="385" y="105" width="110" height="55" class="block" />
    <text x="440" y="132.5" class="block-text">hpc</text>
    <rect x="385" y="165" width="110" height="45" class="explanation-box" />
    <text x="440" y="182.5" class="explanation-text">
      <tspan x="440">High-Performance</tspan>
      <tspan x="440" dy="1.2em">Computing</tspan>
    </text>

    <!-- plus (Col 5) -->
    <rect x="510" y="105" width="110" height="55" class="block" />
    <text x="565" y="132.5" class="block-text">plus</text>
    <rect x="510" y="165" width="110" height="45" class="explanation-box" />
    <text x="565" y="187.5" class="explanation-text" dominant-baseline="middle">Plus (+) Variant</text>

    <!-- bwp (Col 6) -->
    <rect x="635" y="105" width="110" height="55" class="block" />
    <text x="690" y="132.5" class="block-text">bwp</text>
    <rect x="635" y="165" width="110" height="45" class="explanation-box" />
    <text x="690" y="187.5" class="explanation-text" dominant-baseline="middle">Tapless Cell</text>

    <!-- 7t (Col 7) -->
    <rect x="760" y="105" width="110" height="55" class="block" />
    <text x="815" y="132.5" class="block-text">7t</text>
    <rect x="760" y="165" width="110" height="45" class="explanation-box" />
    <text x="815" y="187.5" class="explanation-text" dominant-baseline="middle">7-Track Cell Height</text>

    <!-- 30 (Col 8) -->
    <rect x="885" y="105" width="110" height="55" class="block" />
    <text x="940" y="132.5" class="block-text">30</text>
    <rect x="885" y="165" width="110" height="45" class="explanation-box" />
    <text x="940" y="187.5" class="explanation-text" dominant-baseline="middle">Gate Length: 30nm</text>

    <!-- p140 (Col 9) -->
    <rect x="1010" y="105" width="110" height="55" class="block" />
    <text x="1065" y="132.5" class="block-text">p140</text>
    <rect x="1010" y="165" width="110" height="45" class="explanation-box" />
    <text x="1065" y="187.5" class="explanation-text" dominant-baseline="middle">Poly Pitch: 140nm</text>

    <!-- _190a (Col 10) -->
    <rect x="1135" y="105" width="110" height="55" class="block" />
    <text x="1190" y="132.5" class="block-text">_190a</text>
    <rect x="1135" y="165" width="110" height="45" class="explanation-box" />
    <text x="1190" y="182.5" class="explanation-text">
      <tspan x="1190">Revision 1.90a</tspan>
      <tspan x="1190" dy="1.2em">(Higher is newer)</tspan>
    </text>
  </g>

  <!-- Row 2: Alternative options -->
  <g id="row2">
    <!-- pb (Col 2) -->
    <rect x="135" y="240" width="110" height="55" class="block" />
    <text x="190" y="267.5" class="block-text">pb</text>
    <rect x="135" y="300" width="110" height="45" class="explanation-box" />
    <text x="190" y="322.5" class="explanation-text" dominant-baseline="middle">IO</text>

    <!-- hpm (Col 4) -->
    <rect x="385" y="240" width="110" height="55" class="block" />
    <text x="440" y="267.5" class="block-text">hpm</text>
    <rect x="385" y="300" width="110" height="45" class="explanation-box" />
    <text x="440" y="317.5" class="explanation-text">
      <tspan x="440">High-Performance</tspan>
      <tspan x="440" dy="1.2em">Mobile</tspan>
    </text>

    <!-- bw (Col 6) -->
    <rect x="635" y="240" width="110" height="55" class="block" />
    <text x="690" y="267.5" class="block-text">bw</text>
    <rect x="635" y="300" width="110" height="45" class="explanation-box" />
    <text x="690" y="317.5" class="explanation-text">
      <tspan x="690">Tapless with</tspan>
      <tspan x="690" dy="1.2em">VPP/VBB Cell</tspan>
    </text>

    <!-- 12t (Col 7) -->
    <rect x="760" y="240" width="110" height="55" class="block" />
    <text x="815" y="267.5" class="block-text">12t</text>
    <rect x="760" y="300" width="110" height="45" class="explanation-box" />
    <text x="815" y="322.5" class="explanation-text" dominant-baseline="middle">12-Track Cell Height</text>

    <!-- 35 (Col 8) -->
    <rect x="885" y="240" width="110" height="55" class="block" />
    <text x="940" y="267.5" class="block-text">35</text>
    <rect x="885" y="300" width="110" height="45" class="explanation-box" />
    <text x="940" y="322.5" class="explanation-text" dominant-baseline="middle">Gate Length: 35nm</text>

    <!-- p135 (Col 9) -->
    <rect x="1010" y="240" width="110" height="55" class="block" />
    <text x="1065" y="267.5" class="block-text">p135</text>
    <rect x="1010" y="300" width="110" height="45" class="explanation-box" />
    <text x="1065" y="322.5" class="explanation-text" dominant-baseline="middle">Poly Pitch: 135nm</text>
  </g>

  <!-- Row 3: More alternative options -->
  <g id="row3">
    <!-- s (Col 2) -->
    <rect x="135" y="375" width="110" height="55" class="block" />
    <text x="190" y="402.5" class="block-text">s</text>
    <rect x="135" y="435" width="110" height="45" class="explanation-box" />
    <text x="190" y="457.5" class="explanation-text" dominant-baseline="middle">SRAM</text>

    <!-- hpl (Col 4) -->
    <rect x="385" y="375" width="110" height="55" class="block" />
    <text x="440" y="402.5" class="block-text">hpl</text>
    <rect x="385" y="435" width="110" height="45" class="explanation-box" />
    <text x="440" y="452.5" class="explanation-text">
      <tspan x="440">High-Performance</tspan>
      <tspan x="440" dy="1.2em">Low Power</tspan>
    </text>

    <!-- "None" (Col 7) -->
    <rect x="760" y="375" width="110" height="55" class="block-none" />
    <text x="815" y="402.5" class="block-text-none">None</text>
    <rect x="760" y="435" width="110" height="45" class="explanation-box" />
    <text x="815" y="457.5" class="explanation-text" dominant-baseline="middle">Default: 9-Track</text>

    <!-- 40 (Col 8) -->
    <rect x="885" y="375" width="110" height="55" class="block" />
    <text x="940" y="402.5" class="block-text">40</text>
    <rect x="885" y="435" width="110" height="45" class="explanation-box" />
    <text x="940" y="457.5" class="explanation-text" dominant-baseline="middle">Gate Length: 40nm</text>
  </g>
</svg>


例如 `tcbn40lpbwp`, `TCBN28HPCPLUSBWP30P140`, `tcbn65gplusbwp12t_200a`

Ref:

> DB_TCBN28HPCPLUSBWP30P140_TT1V25C.pdf; [CSDN: TSMC cell 工艺库命名规则](https://blog.csdn.net/nine_sheep/article/details/142431817)
> [Synopsys IP: Exploring TSMC 28HPC+ with Logic Library Capabilities](https://www.synopsys.com/articles/logic-library-capabilities.html)
> [EDN: Product How-to: Fully utilize TSMC’s 28HPC process](https://www.edn.com/product-how-to-fully-utilize-tsmcs-28hpc-process/)
> [EETOP: 库命名](https://bbs.eetop.cn/thread-880993-1-1.html)
> [N28_HPCPLUS_072024.xlsx](https://europractice-ic.com/wp-content/uploads/2024/01/N28_HPCPLUS_072024.xlsx)

### Analog
