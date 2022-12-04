#!apl --script

∇EINST2 ⍝ Numerical verification of the curavture near a black hole.
 ⎕IO←1                        ⍝ Subscripts start at 1.
 'EPSILON = ',⍕E←.0001         ⍝ (f(x+e)-f(x-e))/2e gives partials.
 'X = ',⍕X←2 1 1 0             ⍝ Point of spacetime near black hole.
 ' '                           ⍝ Skip a line.
 'RIEMANN CURVATURE TENSOR = ' ⍝ Show all the components of the
 ⎕←R←R4 X                      ⍝ Riemann tensor at the point X.
 ' '                           ⍝ Skip a line.
 'WILL SUM:'                   ⍝ Show the components which are
 3 1 2 3 ⍉R                    ⍝ summed to give the Ricci tensor.
 ' '                           ⍝ Skip a line.
 'RICCI TENSOR = '             ⍝ Ricci tensor should be identically
 +/3 1 2 3⍉R                   ⍝ zero according to field equations.
∇

∇Z←G X       ⍝ Get the Schwarchild metric G at a point X
 Z←4 4 ⍴0    ⍝ which is a diagonal metric.
 (1 1 ⍉Z)←(-÷1-÷X[1]),(-X[1]*2),(-(X[1]×1○X[2])*2),1-÷X[1]
∇

∇Z←G2 X        ⍝ Get the inverse of a diagonal metric, by taking
 (1 1 ⍉Z)←÷1 1⍉Z←G X  ⍝ the reciprocal of each diagnoal element.
∇

∇Z←DGDX X        ⍝ Get the inverse of a diagonal metric, by taking
 Z←⊃[1 2]((G¯⊂[2]X+Z)-(G¯⊂[2](X←4 4 ⍴X)-Z←E×(⍳4)∘.=⍳4))÷2×E
∇

∇Z←GAMMA X            ⍝ Get the connection from the paritials & the inverse.
 Z←.5×(G2 X)+.×(2 1 3⍉Z)+(3 1 2⍉Z)-(2 3 1⍉Z←DGDX X) ⍝ metric inverse.
∇

∇Z←DGAMMADX X         ⍝ Get the parital deriviatives of the connection.
 Z←⊃[1 2 3]((GAMMA¯⊂[2]X+Z)-(GAMMA¯⊂[2](X←4 4 ⍴X)-Z←E×(⍳4)∘.=⍳4))÷2×E
∇

∇Z←R4 X               ⍝ Get the curvature tensor form the connection &
 Z←(1 3 2⍉Z)+.×Z←GAMMA X                      ⍝ its partial derivatives.
 Z←(-Z)+(1 2 4 3⍉Z←DGAMMADX X)+(1 3 2 4⍉Z)-(1 4 2 3⍉Z)
∇
