 ml←{
     r←re fl∘('&' '&amp;')('<' '&lt;')('>' '&gt;')
     c←r if{'<'≠⍬⍴⍵}
     ((1=≡⍺)⊃⍺(⊂⍺)){
⍝     (⊃{⊂⍵}/(1∩≡⍺),⊂⍺){
         1⌽'><',(⊃{⍵,⊃{' ',⍺,1⌽'"="',r ⍵}∘⍕/⍺}/⌽⍺),⊃(×⍴⍵)↓'/'('>',(c ⍵),'</',⊃⍺)
     },⍕⍵
 }