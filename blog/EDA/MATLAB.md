# MATLAB

## Symbolic Toolbox

```matlab
syms x y z
assume([x y z], 'real');

A = (x + y*i);      
abs(A)                                                     % 自动化简

B = (x + y*z*i);
abs(B)                                                     % 不自动化简
simplify(abs(B), 'Steps', 1000)                            % 不能正常化简
simplify(abs(B), 'Steps', 7, 'Criterion', 'preferReal')    % 正常化简
simplify(sqrt(B*conj(B)))                                  % 正常化简
simplify(sqrt(real(B)^2 + imag(B)^2))                      % 正常化简

C = 1/(x + y*i);      
abs(C)                                                     % 自动化简

D = 1/(x + y*z*i);
abs(D)                                                     % 不自动化简
simplify(abs(D))                                           % 不能默认化简
simplify(abs(D), 'Steps', 12)                              % 正常化简
```
