#!apl --script

∇NEWTON              ⍝ Program draws trajectories of point masses.
 ⎕IO←0               ⍝ Subscripts start at 0.
 BODIES←2            ⍝ There are 2 bodies.
 ORBIT←50 50⍴' '     ⍝ Initialize 50 by 50 picture of orbit.
 G←.667E¯10          ⍝ G is the gravitational coupling constant
 T←0                 ⍝ Initialize time.
 DELT←60             ⍝ The time step delta t is 60 seconds.
 M←6E24 10           ⍝ Vector of mass of Earth and satellite.
 X←V←BODIES 3⍴0      ⍝ Matrices of velocities and positions.
 X[1;0]←1E7          ⍝ Initial position of satellite.
 V[1;1]←6E3          ⍝ Initial velocity of satellite.
 STEP←1              ⍝ Will do 12 times 15 time steps,
 LOOP:               ⍝ and will draw orbit each 15 time steps.
  F←(⍳BODIES)∘.FORCE⍳BODIES ⍝ Get all forces between bodies.
  A←⊃(+/F)÷M         ⍝ Get all accelerations.
  V←V+A×DELT         ⍝ Update velocities.
  X←X+V×DELT         ⍝ Update positions.
  T←T+DELT           ⍝ Bump time.
  DRAW               ⍝ Plot positions of Earth and satellite.
  →((12×15)≥STEP←STEP+1)/LOOP ⍝ Loop until finished.
∇

∇F←I FORCE J         ⍝ Force exerted on body i by body j
 F←3⍴0               ⍝ Initialize force to zero.
 →(I=J)/0            ⍝ No force of body on itself.
 DELX←X[J;]-X[I;]    ⍝ Get displacement vector delta x.
 R←(+/DELX*2)*.5     ⍝ Get distance r between bodies.
 F←(G×M[I]×M[J]÷R*2)×(DELX÷R) ⍝ Calculate force vector.
∇

∇DRAW
ORBIT[25+⌊X[0;0]÷5E5;25+⌊X[0;1]÷5E5]←'E'  ⍝ Plot earth.
ORBIT[25+⌊X[1;0]÷5E5;25+⌊X[1;1]÷5E5]←'*'  ⍝ Plot satellite.
 →(0≠15∣STEP)/0                  ⍝ Draw orbit every 15 time steps.
 ' '                             ⍝ Skip line.
'TIME IN HOURS ',⍕T÷60×60        ⍝ Convert seconds to hours.
FRAME ORBIT                      ⍝ Draw picture of orbit.
∇

∇FRAME PIC        ⍝ Put frame around picture of orbit.
'|',('-',[0]PIC,[0]'-'), '|'
∇
