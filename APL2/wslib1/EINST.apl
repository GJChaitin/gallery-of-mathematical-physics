#!apl --script

∇EINST           ⍝ Program for geodescis in curved spacetime.
 ⎕IO←0           ⍝ Subscripts start at 0.
 BODIES←2        ⍝ There are 2 bodies.
 ORBIT←50 50⍴' ' ⍝ Initialize 50 by 50 picture of orbit.
 E←1000          ⍝ (f(x+e)-f(x-e))/2e gives the partial derivatives.
 DELT←60         ⍝ Time interval between first two points in orbit.
 C←3E8           ⍝ Speed of light in meters per second.
 DX←(X←1D6,(DELT×6E3),0,(DELT×C))-(1E7,0,0,0)  ⍝ X is the current
 STEP←2          ⍝ position of satellite in spacetime & DX is the
LOOP:      ⍝ difference between the current & the previous position.
  DRAW X←X+DX←DX-((GAMMA X)+.×DX)+.×DX   ⍝ Plot next point in orbit.
  →((12×15)≥STEP←STEP+1)/LOOP  ⍝ Do 12 by 15 times & draw each 15th.
∇

∇DRAW
 ORBIT[25+⌊X[0;0]÷5E5;25+⌊X[0;1]÷5E5]←'E'  ⍝ Plot earth.
 ORBIT[25+⌊X[1;0]÷5E5;25+⌊X[1;1]÷5E5]←'*'  ⍝ Plot satellite.
 →(0≠15∣STEP)/0                  ⍝ Draw orbit every 15 time steps.
 ' '                             ⍝ Skip line.
'TIME IN HOURS ',⍕T÷60×60        ⍝ Convert seconds to hours.
FRAME ORBIT                      ⍝ Draw picture of orbit.
∇

∇Z←G X                ⍝ Get the metric G at a point X of spacetime.
 Z←4 4 ⍴0             ⍝ It happens to be a diagonal metric.
 (1 1 ⍉Z)←(¯1 ¯1 ¯1),1-.0088÷(+/3↑X*2)*.5 ⍝ rocky: This line fails
∇

∇Z←DGDX X             ⍝ Get the partial derivatives of G at point X.
 Z←4 4 ⍴0             ⍝ It happens to be a diagonal metric.
 Z←⊃[1 2]((G¨⊂[2]X+Z)-(G¨⊂[2](X←4 4 ⍴X)-Z←E×(⍳4)∘.=⍳4))÷2×E ⍝ rocky: This line fails
∇

∇Z←GAMMA X  ⍝ Get the connection at a point from the partials t & the
 Z←.5×(⌹G X)+.×(2 1 3⍉Z)+(3 1 2⍉Z)-(2 3 1⍉Z←DGDX X) ⍝ metric inverse.
∇

∇FRAME PIC        ⍝ Put frame around picture of orbit.
 '|',('-',[1]PIC,[1]'-'), '|'
∇
