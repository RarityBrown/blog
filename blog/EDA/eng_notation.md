# Engineering notation in common softwares


## Excel

### 把单元格中的 1,000,000 显示为 "1M"

```excel
=IF(E10=0, "0", 
  LET(
    abs_val, ABS(E10),
    n, FLOOR((LOG10(abs_val) + 1E-14) / 3, 1),
    n_clamped, MIN(MAX(n, -5), 5),
    scaled_val, E10 / 10^(n_clamped * 3),
    prefixes, {"f";"p";"n";"u";"m";"";"k";"M";"G";"T";"P"},
    suffix, INDEX(prefixes, n_clamped + 6),
    TEXT(scaled_val, "0.###") & suffix
  )
)
```

### 把单元格中的 "1M" 识别为 1,000,000

```excel
=LET(
    t, TRIM(A2),
    last, RIGHT(t),
    has_suffix, ISERROR(VALUE(last)),
    num_str, IF(has_suffix, LEFT(t, LEN(t)-1), t),
    suffix, IF(has_suffix, last, ""),
    units, {"T","G","M","k","","m","u","n","p","f"},
    mults, {1E12,1E9,1E6,1E3,1,1E-3,1E-6,1E-9,1E-12,1E-15},
    factor, XLOOKUP(TRUE, EXACT(suffix, units), mults, 1),
    IFERROR(VALUE(num_str) * factor, NA())
)
```


## Matlab

#### coding

```matlab
format shortEng

T = 1e12;   % Tera
G = 1e9;    % Giga
M = 1e6;    % Mega
k = 1e3;    % kilo
m = 1e-3;   % milli
u = 1e-6;   % micro
n = 1e-9;   % nano
p = 1e-12;  % pico
f = 1e-15;  % femto
a = 1e-18;  % atto


k_b   = physconst('Boltzmann');           % 1.380649e-23 J/K
q     = 1.602176634e-19;                  % Elementary charge (C)
temp  = 300;                              % Kelvin
kT    = k_b*temp;                         % J
```

#### general conversion

```matlab
function [prefixes, exponents] = siPrefixTable()
    prefixes  = {'y','z','a','f','p','n','u','m','', 'k','M','G','T','P','E','Z','Y'};
    exponents = -24 : 3 : 24;
end
function [num, prefix, scale] = num2eng(val)
    if val == 0
        num = 0;  prefix = '';  scale = 1;
        return
    end
    [prefixes, exponents] = siPrefixTable();
    exp3 = 3 * floor(log10(abs(val)) / 3);
    exp3 = max(min(exp3, exponents(end)), exponents(1));
    idx    = find(exponents == exp3, 1);
    prefix = prefixes{idx};
    scale  = 10^exp3;
    num    = val / scale;
end
function vals = eng2num(strs)
    [prefixes, exponents] = siPrefixTable();
    mask = ~cellfun(@isempty, prefixes);
    prefixMap = containers.Map(prefixes(mask), num2cell(10.^exponents(mask)));
    strs = string(strs);
    vals = nan(size(strs));
    for i = 1:numel(strs)
        vals(i) = parseSingle(strs(i), prefixMap);
    end
    if isscalar(vals),  vals = vals(1);  end
    
    function val = parseSingle(str, prefixMap)
        str = strtrim(str);
        if str == "" || ismissing(str)
            val = NaN;  return
        end
        val = str2double(str);
        if ~isnan(val),  return,  end
        suffix  = extractAfter(str, strlength(str) - 1);
        numPart = extractBefore(str, strlength(str));
    
        if isKey(prefixMap, suffix)
            val = str2double(numPart) * prefixMap(suffix);
        else
            val = NaN;
        end
    end
end
```

#### ploting

```matlab
function auto_eng_ticks(ax, axis_name, unit)
    if nargin < 1, ax = gca; end
    if nargin < 2, axis_name = 'x'; end
    if nargin < 3, unit = ''; end
    
    switch lower(axis_name)
        case 'x', r = ax.XAxis; lbl_handle = ax.XLabel;
        case 'y', r = ax.YAxis; lbl_handle = ax.YLabel;
        case 'z', r = ax.ZAxis; lbl_handle = ax.ZLabel;
        otherwise, error('Axis must be x, y, or z');
    end

    ticks = r.TickValues;
    if isempty(ticks), return; end
    isLog = strcmp(r.Scale, 'log');

    if isLog
        newLabels = cell(size(ticks));
        for i = 1:length(ticks)
            val = ticks(i);
            if val == 0
                newLabels{i} = '0';
            else
                [num, suffix] = num2eng(val);
                if abs(num - round(num)) < 1e-5
                    newLabels{i} = sprintf('%d%s', round(num), suffix);
                else
                    newLabels{i} = sprintf('%.3g%s', num, suffix);
                end
            end
        end
        r.TickLabels = newLabels;
        combinedSuffix = unit;
    else
        maxVal = max(abs(ticks));
        [~, suffix, scaleFactor] = num2eng(maxVal);
        scaledTicks = ticks / scaleFactor;
        newLabels = arrayfun(@(v) sprintf('%g', v), scaledTicks, 'UniformOutput', false);
        r.TickLabels = newLabels;
        combinedSuffix = [suffix, unit];
    end
    
    if ~isempty(combinedSuffix)
        cleanLabel = regexprep(lbl_handle.String, '\s*\(.*\)$', '');
        lbl_handle.String = sprintf('%s (%s)', cleanLabel, combinedSuffix);
    end
end
```

example usage:

```matlab
figure;
f = logspace(3, 9, 7);
C = [100e-12, 98e-12, 95e-12, 90e-12, 80e-12, 60e-12, 40e-12]; 
semilogx(f, C, '-s', 'LineWidth', 2);
grid on;
title('Cap vs Freq');
xlabel('Frequency'); 
ylabel('Capacitance');
auto_eng_ticks(gca, 'x', 'Hz');
auto_eng_ticks(gca, 'y');
```


![](https://github.com/user-attachments/assets/2a11da8d-ce16-4591-bb2d-7678a39470f6)


#### read-in table

todo
