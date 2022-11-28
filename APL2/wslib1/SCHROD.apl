#!apl --script

∇SCHROD     ⍝ Does electron moving slowly in one dimensional potential.
 ⎕IO←0           ⍝ Subscripts start at 0.
 I←0J1           ⍝ I is the square root of minus one.
 HBAR←.1         ⍝ HBAR is Plank's constant divided by two pi.
 MASS←1          ⍝ Mass of the electron.
 DELX←1÷N←50     ⍝ One unit of apce is dvided into N pieces, &
 DELT←1÷STEPS←20×N  ⍝ one unit of time is divided into 20 N steps.
 X←¯.5+(.5+⍳N)÷N
 V←N⍴0   ⍝ Try V←1000,((N-2)⍴0),1000 or V←((⌊.8×N)⍴0),(N-⌊.8×N)⍴10
 ALPHA←÷HBAR×I
 BETA←-ALPHA×(HBAR*2)×MASS×2×DELX*2       ⍝ X is a vector of the N
 A←B←N N⍴0       ⍝ possible positions of the electron ranging from
 A[;1]←A[;N-1]←-BETA      ⍝ -half to +half, & V is a vector of the
 A[;0]←(÷DELT)+(2×BETA)-(ALPHA÷2)×V      ⍝ potential energy of the
 B[;1]←B[;N-1]←BETA          ⍝ electron at each of these positions.
 B[;0]←(÷DELT)-(2×BETA)-(ALPHA÷2)×V  ⍝ C operates on the Psi field
 C←(⌹A←(-⍳N)⌽A)+.×B←(-⍳N)⌽B      ⍝ at time t giving it at time t+1.
 X0←0 ⍝ X0 is the center & SIGMA0 is the variance of a wave packet.
 K0←30       ⍝ K0←¯15 goes in opposite direction at half the speed;
 SIGMA0←.05       ⍝ K0 determines the momentum of the wave packet.
 PSI←(*K0×I×X)×(*-((X-X0)*2)÷(2×SIGMA0*2))      ⍝ Try PSI←*(○2)×I×X
 (TIME←0)DRAW PSI←PSI÷(+/|PSI*2)*.5      ⍝ Normalize Psi & draw it.
 STEP←0                     ⍝ Count time steps
LOOP:→(STEPS<STEP←STEP+1)/0 ⍝ until we have done them all.
  PSI←C+.×PSI               ⍝ Get new Psi field form current field.
  TIME←TIME+DELT            ⍝ Bump time.
  TIME DRAW PSI             ⍝ Draw field
  →(0≠20|STEP)/LOOP         ⍝ every 20 time steps,
  TIME DRAW PSI
  →LOOP
∇

∇TIME DRAW PSI ⍝ DRAWs graphs of probability and phase of Psi field.
' '                                       ⍝ Graph of probability
'PROBABILITY(POSITION) AT TIME = ',⍕TIME  ⍝ is 51 characters wide
'TOTAL PROBABILITY =', ⍕+/PROB←|PSI*2     ⍝ & scaled so that
FRAME(-⌊50×PROB÷⌈/PROB)⌽(N 51⍴'*',50⍴' ') ⍝ of the three components of the
' '                                       ⍝ Graph of phase is 44
'PHASE(POSTION) AT TIME = ',⍕TIME         ⍝ characters wide, from
FRAME(-⌊22+7×11○⍟(PSI=0)+PSI)⌽(N 44⍴'#',43⍴' ') ⍝ -pi to +pi
∇

∇FRAME PIC        ⍝ Add potential & postion numbers to a graph,
PIC←(N 5⍴'|  V='),(⍕N 1⍴V),' ',' ',(⍕N 1⍴⍳N),' ',' ','|',PIC,'|'
'-',[0]PIC,[0]'-'                                ⍝ & frames it.
∇
