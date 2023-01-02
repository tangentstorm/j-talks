

f0=:family =: '|' chopstring 'You|Daddy|Mommy|Grandpa|Grandma|Nana Ji|Nani Ji'

(,: [: ;/ i.@#) family  NB. append row of boxed integers from 0 to the length-1




person_named =: {{ family i. <y }}  NB. index of boxed name in 'family'
person_named 'You'
person_named 'Grandma'

DAD =: 1 2 & p.  NB. when counting from 0
MOM =: 2 2 & p.  NB. when counting from 0

> family {~ DAD person_named 'Daddy'

of =: person_named
the =: {{ > family {~ y }}


the DAD of 'You'
the MOM of 'You'


the MOM of the MOM of 'You'
the MOM MOM of 'You'
the MOM^:2 of 'You'
MGM =: MOM^:2
the MGM of 'You'

[family=:f0,'Dan';'Betty';'Ray';'Elizabeth'
(,: [: ;/ i.@#) family  NB. append row of boxed integers from 0 to the length-1


the MGM of 'Daddy'


your =: {{ the (<y)`:0 of 'You' }}

your 'MGM'
the MOM of your 'MOM'

NB. etc


the MGF of 'You'

(,: [: ;/ 1 + i.@#) family  NB. append row of boxed integers from 1 to the length


NB. the neat thing about this list is that you can use arithmetic
NB. on the numbers.



person_named =: {{family i. <y}}






NB. we need a way to map between the names and numbers
of  =: {{ }}



family i. <'You'





of =: {{ family  i. < y }}
the =: {{ > y { family }}



