#!apl --script

∇MAXWELL     ⍝ Program does electromagnetic field in vacuum.
 ⎕IO←0       ⍝ Subscripts start at 0.
 DELTA←1     ⍝ Granularity of space & time is one unit.
 O←N←20      ⍝ Rectangular sold of A mu field is 0 time units
 M←L←1       ⍝ by (N by M by L) space units wide
 A←O N M L 4⍴0 ⍝ and has 4 components at each point of spacetime.
 A[0;;;;2]←(÷○2÷N)×2○○2×(⍳N)÷N          ⍝ A mu at time 0.
 A[1;;;;2]←(÷○2÷N)×2○○2×((-DELTA)+⍳N)÷N ⍝ A mu at time 1.
 T←1   ⍝ Initialize time.
 LOOP: ⍝ Loop get A mu at time t+1 from it at time t & t-1.
  X←(1⌽[0]A[T;;;;])+(1⌽[1]A[T;;;;])+(1⌽[2]A[T;;;;])
  Y←(¯1⌽[0]A[T;;;;])+(¯1⌽[1]A[T;;;;])+(¯1⌽[2]A[T;;;;])
  A[T+1;;;;]←X+Y-A[T-1;;;;]+4×A[T;;;;]
  →(O>1+T←T+1)/LOOP              ⍝ Continue leapfrog integration.
  DA←O N M L 4 4 ⍴0              ⍝ Get partial derivatives of A mu
  DA[;;;;;0]←((1⌽[0]A)-(¯1⌽[0]A))÷2×DELTA  ⍝with respect to time t
  DA[;;;;;1]←-((1⌽[1]A)-(¯1⌽[1]A))÷2×DELTA ⍝with respect to space x
  DA[;;;;;2]←-((1⌽[2]A)-(¯1⌽[2]A))÷2×DELTA ⍝with respect to space y
  DA[;;;;;3]←-((1⌽[3]A)-(¯1⌽[3]A))÷2×DELTA ⍝with respect to space z.
  'LORENTZ CONDITION: MAX|DIV| = 0?'
  ⌈/,|+/0 1 2 3 4 4⍉DA    ⍝ Check generalized divergence is zero.
  F←(0 1 2 3 5 4⍉DA)-DA   ⍝ Check F mu nu tensor which contains
  T←0                     ⍝ all components of E and B vectors.
 LOOP2:                   ⍝ Draw picture of electrif field E
   DRAW                   ⍝ and magnetic field B
  →(O>T←T+1)/LOOP2
∇

∇DRAW                     ⍝ DRAW assumes M = L = 1
'Ex' SHOW F[T;;0;0;1;0]   ⍝ At each time step DRAW shows each
'Ey' SHOW F[T;;0;0;2;0]   ⍝ of the three componets of the
'Ez' SHOW F[T;;0;0;3;0]   ⍝ electric field, and each of the
'Bx' SHOW F[T;;0;0;3;2]   ⍝ three components of the magnetic
'By' SHOW F[T;;0;0;1;3]   ⍝ field.  SHOW assumes component
'Bz' SHOW F[T;;0;0;2;3]   ⍝ values range from -1 to +1.
∇

∇NAME SHOW F  ⍝ Show E/B component as a function of position.
 →(∧/0=F)/0   ⍝ Do not show it if it is identically zero.
 ' '          ⍝ Skip line.
NAME,' AT TIME =',⍕T×DELTA         ⍝ Identify component & give time.
FRAME(-⌊26+25×F)⌽((⍴F),52)⍴'*',51⍴' '            ⍝ Graph and frame it.
∇

∇FRAME PIC ⍝ Add position numbers to graph of E/B component & frame
'-',[0]('|',' ', ' ',(⍕N 1⍴⍳N),' ',' ', '|',PIC,'|'),[0]'-'   ⍝ it.
∇
