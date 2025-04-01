# PDK


<svg width="1250" height="750" xmlns="http://www.w3.org/2000/svg" font-family="sans-serif"> <!-- Adjusted height -->
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
