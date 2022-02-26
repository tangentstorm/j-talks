bg =. _1
f =. [:<[:|:bg,bg,~[:|:bg,bg,~2 2$] NB. laying out the "sprite sheet" for all 2x2 sandpiles
sheet =: to_pal"0 ,./^:2 > 16 16 $ f"1 (4$4) #: i.4^4
'' gpw sheet
