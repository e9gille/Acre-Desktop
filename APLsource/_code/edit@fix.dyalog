 editFix←{
     (⍵≡'Start'):{                                     ⍝ from Start
         SV.eventnumber←enum←3611                      ⍝ 26⊥⎕A⍳'FIX'
         (wx ⎕SE.⎕WX)←⎕SE.⎕WX 1 ⋄ qed←'⎕SE'⎕WG'Editor' ⍝ keep  ⎕WX
         SV.fixandafter←UT.ds¨qed.(onFix onAfterFix)   ⍝ oddity! extra nesting!
         qed.(onFix onAfterFix)←(evarg←0⊃⎕XSI)0
         ⎕SE.Event,←⊂enum,⊂evarg ⋄ ⎕SE.⎕WX←wx          ⍝ reset ⎕WX
         {0}SV.itemvalue←editStore ⎕NS''               ⍝ create value store
     }''
     (⍵≡'Close'):{                                     ⍝ from Close
         qed←'⎕SE'⎕WG'Editor'
         (wx ⎕SE.⎕WX)←⎕SE.⎕WX 1 ⋄ qed.(onFix onAfterFix)←SV.fixandafter
         ⎕SE.⎕WX←wx ⋄ {0}'⎕SE'∘⎕WS UT.ep'Event'SV.eventnumber 0}''
     {0::1 ⋄ 0∊SV.setupcomplete,⍴dataSpaces''}0:
⍝ closed without reinstating default Fix callback''
     enum←SV.eventnumber
     (editor event value space name new)←⍵             ⍝ so long as onFix unchanged
     first←event≢enum ⋄ ss←0∊UT.ns⊂⍕space              ⍝ is space scripted?
     fqn←(⍕space),(ss≤space=#)/'.',name new⊃⍨(≢∘∊⍨new)∧2≠space.⎕NC name
     ss←{(9=⌊⎕NC ⍵)∧0∊UT.ns ⍵}⊂fqn                ⍝ is item scripted?
     0=dat←whichProject fqn:{}{
⍝        val←{0::0 ⋄ ⍵=2:⍎⍺ ⋄ ⍵∊3 4:⎕NR ⍺ ⋄ ⍵=9:⎕SRC⍎⍺ ⋄ 0}∘⎕NC⍨fqn
         ⍵}showMsg(~'['∊fqn)/UT.bx MS.DI,' "',fqn,'".'
     (('⎕'∊fqn)≥(⎕NC⊂fqn)∊0,validAPLType''):
     first:{null⊢z←⊃¨getValues⊂fqn:z←''
         z←SV.itemvalue editStore z
         z←⎕NQ'⎕SE'enum value space name new}''
     (('⎕'∊z)∨0≥nc←#.⎕NC⊂z←fqn):                  ⍝ doesn't exist or bad name
     oldval←SV.itemvalue editStore fqn
     (oldval≡newval←⊃1⊃getValues⊂fqn):               ⍝ unchanged
     z←showMsg MS.DK showList dat putChanged⊂¨fqn newval
⍝ ⍺ dat
⍝ ⍵ 'Start' or 'Close' or callback argument
⍝ ← 0 for 'Start' and 'Close' - else none
⍝ Phil Last ⍝ 2008-05-18 07:48
 }