 cf0←{
     ⍺←⊢ ⋄ a←⍺ ⋄ w←⍵ ⋄ f←⍺⍺ ⋄ g←⍵⍵
     (↑'⍺ ⍺⍺ ⍵' '⍺ ⍵⍵ ⍵'),0 7↓cmpx'a f w' 'a g w'
 }