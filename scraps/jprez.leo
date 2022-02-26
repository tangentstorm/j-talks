<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2"/>
<globals/>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="tangentstorm.20220205182725.2"><vh>jprez</vh></v>
<v t="tangentstorm.20220205231205.1"><vh>goals/plans/ideas</vh>
<v t="tangentstorm.20220206125432.1"><vh>one/two/three</vh></v>
<v t="tangentstorm.20220205231208.1"><vh>move macro engine up into app</vh></v>
<v t="tangentstorm.20220206003930.1"><vh>clear screen command</vh></v>
</v>
<v t="tangentstorm.20220205183137.1"><vh>current features</vh>
<v t="tangentstorm.20220205183822.1"><vh>org file format</vh></v>
<v t="tangentstorm.20220205183205.1"><vh>console based editor</vh>
<v t="tangentstorm.20220205183144.1"><vh>outline</vh></v>
<v t="tangentstorm.20220205183332.1"><vh>text area</vh></v>
<v t="tangentstorm.20220205183339.1"><vh>newHeadline</vh></v>
</v>
<v t="tangentstorm.20220205183312.1"><vh>macro player</vh></v>
<v t="tangentstorm.20220205183242.1"><vh>time travelling repl</vh></v>
</v>
<v t="tangentstorm.20220205183529.1"><vh>audio enhancements</vh>
<v t="tangentstorm.20220205183516.1"><vh>associate clip with text line</vh></v>
<v t="tangentstorm.20220205182859.1"><vh>recording audio</vh></v>
<v t="tangentstorm.20220205183510.1"><vh>play audio</vh></v>
<v t="tangentstorm.20220205183739.1"><vh>timing information</vh></v>
</v>
<v t="tangentstorm.20220205183847.1"><vh>driving animations</vh>
<v t="tangentstorm.20220206155611.1"><vh>for now, we just send messages to godot in a queue</vh></v>
<v t="tangentstorm.20220206155801.1"><vh>jprez should run as standalone full-screen godot app</vh></v>
<v t="tangentstorm.20220206155900.1"><vh>jprez player component sits in the normal godot scene</vh>
<v t="tangentstorm.20220206160124.1"><vh>separate godot component for each j widget, so we can animate them</vh></v>
</v>
</v>
<v t="tangentstorm.20220205200047.1"><vh>gridliner</vh>
<v t="tangentstorm.20220205200056.1"><vh>general concept is a 2d grid of cells</vh>
<v t="tangentstorm.20220205212455.1"><vh>cols and rows have widths and heights, respectively in "pixels"</vh>
<v t="tangentstorm.20220205214843.1"><vh>use a running sum to track offsets</vh></v>
</v>
<v t="tangentstorm.20220205212748.1"><vh>we query a data source for visible cells given a view rectangle in pixels</vh>
<v t="tangentstorm.20220205213528.1"><vh>cells do not overlap</vh></v>
<v t="tangentstorm.20220205200124.1"><vh>cells may span multiple rows or columns</vh></v>
</v>
<v t="tangentstorm.20220205221706.1"><vh>fixed rows/columns can just be separate sub-widgets</vh></v>
</v>
<v t="tangentstorm.20220205200119.1"><vh>can collapse and expand rows (and columns?)</vh>
<v t="tangentstorm.20220205200803.1"><vh>there can be a single column that indicates tree structure</vh></v>
<v t="tangentstorm.20220205214534.1"><vh>"haschildren" column (or "childcount"?)</vh></v>
</v>
<v t="tangentstorm.20220205215139.1"><vh>grid operations</vh>
<v t="tangentstorm.20220205215146.1"><vh>navigation</vh></v>
<v t="tangentstorm.20220205215152.1"><vh>add/remove rows and column(s)</vh></v>
<v t="tangentstorm.20220205221611.1"><vh>show/hide rows and columns</vh></v>
</v>
<v t="tangentstorm.20220205215157.1"><vh>outline operations (extend general list/buffer operations)</vh>
<v t="tangentstorm.20220205221420.1"><vh>show/hide handled by grid, but also, toggle the icon</vh></v>
<v t="tangentstorm.20220205222120.1"><vh>store indentation level in a column</vh></v>
<v t="tangentstorm.20220205223410.1"><vh>new commands</vh>
<v t="tangentstorm.20220205223429.1"><vh>show/hide</vh></v>
<v t="tangentstorm.20220205223434.1"><vh>indent</vh></v>
<v t="tangentstorm.20220205223436.1"><vh>dedent</vh></v>
<v t="tangentstorm.20220205223440.1"><vh>up to parent</vh></v>
</v>
<v t="tangentstorm.20220205222123.1"><vh>clone</vh></v>
</v>
</v>
<v t="tangentstorm.20220205225621.1"><vh>@path d:/ver/j-kvm</vh>
<v t="tangentstorm.20220205225713.2"><vh>@clean ui.ijs</vh></v>
<v t="tangentstorm.20220205225722.1"><vh>@path ui</vh>
<v t="tangentstorm.20220205225640.2"><vh>@clean app.ijs</vh></v>
<v t="tangentstorm.20220205225640.4"><vh>@clean edit.ijs</vh></v>
<v t="tangentstorm.20220205225640.6"><vh>@clean list.ijs</vh></v>
</v>
</v>
<v t="tangentstorm.20220205232416.1"><vh>@path d:/ver/jprez</vh>
<v t="tangentstorm.20220205232416.2"><vh>@clean jprez.ijs</vh></v>
<v t="tangentstorm.20220206014626.2"><vh>@clean org.ijs</vh></v>
</v>
<v t="tangentstorm.20220206005523.1"><vh>how it works</vh>
<v t="tangentstorm.20220206005856.1"><vh>app variables</vh></v>
<v t="tangentstorm.20220206020948.1"><vh>timing information in org-mode files</vh></v>
<v t="tangentstorm.20220206005129.1"><vh>focus</vh></v>
<v t="tangentstorm.20220206005043.1"><vh>open org  file</vh></v>
<v t="tangentstorm.20220206005052.1"><vh>save org file</vh></v>
<v t="tangentstorm.20220206005121.1"><vh>widgets</vh></v>
</v>
<v t="tangentstorm.20220206150034.1"><vh>Imported Files</vh>
<v t="tangentstorm.20220206150034.2"><vh>@auto D:/ver/jprez/godot-plugin/addons/jprez/JKVM.gd</vh></v>
<v t="tangentstorm.20220206150034.4"><vh>@auto D:/ver/jprez/godot-plugin/addons/jprez/jprez.gd</vh></v>
<v t="tangentstorm.20220206150034.6"><vh>@auto D:/ver/jprez/godot-plugin/addons/jprez/jprez-plugin.tscn</vh></v>
<v t="tangentstorm.20220206150034.8"><vh>@auto D:/ver/jprez/godot-plugin/addons/jprez/jprez-scene.tscn</vh></v>
<v t="tangentstorm.20220206150034.10"><vh>@auto D:/ver/jprez/godot-plugin/addons/jprez/plugin.cfg</vh></v>
<v t="tangentstorm.20220206150034.12"><vh>@auto D:/ver/jprez/godot-plugin/addons/jprez/plugin.gd</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="tangentstorm.20220205182725.2"></t>
<t tx="tangentstorm.20220205182859.1"></t>
<t tx="tangentstorm.20220205183137.1"></t>
<t tx="tangentstorm.20220205183144.1"></t>
<t tx="tangentstorm.20220205183205.1"></t>
<t tx="tangentstorm.20220205183242.1"></t>
<t tx="tangentstorm.20220205183312.1"></t>
<t tx="tangentstorm.20220205183332.1"></t>
<t tx="tangentstorm.20220205183339.1"></t>
<t tx="tangentstorm.20220205183510.1"></t>
<t tx="tangentstorm.20220205183516.1">@
in the org file, it's just a wave file

org parser needs to support links and timestamps
should be added to a table for each slide

inserting a row should insert values for all columns
&lt;sounds like we may eventually need something like a k-table or pandas dataframe&gt;

this is why we want a grid editor widget.

anyway, then the recording and saving gets handled on the godot side,
and now we need some way for the two sides to communicate.

* proposal:
- recording keypresess are still handled by jprez
- give jprez a way to send messages to godot, requesting a recording
  - this can just be a simple message queue posted on every call to update
  - could also be used to in play mode to trigger playback and godot animations
- when the result (filename and duration) comes back, update the timestamps

</t>
<t tx="tangentstorm.20220205183529.1"></t>
<t tx="tangentstorm.20220205183739.1"></t>
<t tx="tangentstorm.20220205183822.1"></t>
<t tx="tangentstorm.20220205183847.1"></t>
<t tx="tangentstorm.20220205200047.1"></t>
<t tx="tangentstorm.20220205200056.1"></t>
<t tx="tangentstorm.20220205200119.1"></t>
<t tx="tangentstorm.20220205200124.1">@
this means the view may include the right-hand or bottom part of an oversized cell.
</t>
<t tx="tangentstorm.20220205200803.1"></t>
<t tx="tangentstorm.20220205212455.1">@
texels?</t>
<t tx="tangentstorm.20220205212748.1"></t>
<t tx="tangentstorm.20220205213528.1"></t>
<t tx="tangentstorm.20220205214534.1"></t>
<t tx="tangentstorm.20220205214843.1">@
we will see later that this has to be updated whenever the visible tree structure changes
</t>
<t tx="tangentstorm.20220205215139.1"></t>
<t tx="tangentstorm.20220205215146.1"></t>
<t tx="tangentstorm.20220205215152.1"></t>
<t tx="tangentstorm.20220205215157.1"></t>
<t tx="tangentstorm.20220205221420.1">@


</t>
<t tx="tangentstorm.20220205221611.1">@
have a 'visible' bit vectors for both rows and columns, to go with the widths and heights.

when these get toggled, re-calculate the offsets (as running sum of visible sizes).
 </t>
<t tx="tangentstorm.20220205221706.1"></t>
<t tx="tangentstorm.20220205222120.1"></t>
<t tx="tangentstorm.20220205222123.1"></t>
<t tx="tangentstorm.20220205223410.1"></t>
<t tx="tangentstorm.20220205223429.1"></t>
<t tx="tangentstorm.20220205223434.1"></t>
<t tx="tangentstorm.20220205223436.1"></t>
<t tx="tangentstorm.20220205223440.1"></t>
<t tx="tangentstorm.20220205225621.1"></t>
<t tx="tangentstorm.20220205225640.2">@language J
NB. ui application

coclass 'UiApp' extends 'kvm'

now =: 6!:1
then=: now''

create =: {{
  BG =: 0
  W =: y               NB. list of widget references
  F =: {.y             NB. reference to currently focused widget
  C =: '' conew 'vid'  NB. canvas for widgets
  B =: '' conew 'vid'  NB. main video buffer
  A =: '' conew 'vid'  NB. alternate frame buffer
  smudge''
}}

of =: {{ (x,'__y')~ [ y }}"1 0

NB. smudge marks entire screen dirty so we redraw
smudge =: {{
  for_w. W do. R__w =: 1 end.
  cscr__B'' [ BG__B =: BG [ reset__B''
  fill__A 128{a. [ reset__A'' }}

update =: {{
  NB. update gets the number of seconds since last frame
  delta =. (then =: now'')-then
  for_w. W #~ 'A' of W do.
    update__w delta
  end. }}

render =: {{
  NB. redraw each visible widget that needs a refresh.
  NB. we draw each widget on buffer C (which is sized to
  NB. match the widget), then blit it to buffer B at the
  NB. relevant coordinates.
  pushterm B
  for_w. W #~ *./'VR' of "0 _  W do.
    pushterm C
    sethw__C 'HW'of"0 w
    render__w F = w   NB. has-focus flag
    popterm''
    XY__w blit__B C
  end.
  popterm''
  EMPTY }}

vtblit =: {{
  NB. compare buffers A and B, and draw only what has changed.
  jn =. ,&amp;.&gt;
  fc =. bc =. -82076 NB. arbitrary non-valid color
  for_row. (CHB__A~:CHB__B) +. (FGB__A~:FGB__B) +. BGB__A~:BGB__B do.
    for_col. I. row do.
      goxy |.&gt; ix=. &lt;row_index,col
      if. fc ~: f =.ix{FGB__B do. fg_vt_ fc=.f end.
      if. bc ~: b =.ix{BGB__B do. bg_vt_ bc=.b end.
      puts_vt_ 8 u: ix{CHB__B
    end.
  end.
  reset''
  0 0 $ copyto__A B }}

step =: vtblit@render@update
</t>
<t tx="tangentstorm.20220205225640.4">@language J
NB. simple abstract editor

coclass 'UiEditWidget' extends 'UiWidget'

create =: {{
  setval y
  A =: 0           NB. only animate when macro is playing
  W =: 64          NB. width/max length
  BG=: _234        NB. bg color
  FG=: _7          NB. fg color
  MACRO =: ''      NB. the macro we are playing
  I =: _1          NB. the index into macro / instruction pointer
  T =: 0           NB. timer. seconds since last key (sum of time delta from update verb)
  KPS =: 12.2      NB. typing speed (keystrokes per second)
  TSV =: %(10*KPS) NB. max delay for random modifier for typing speed (in seconds/key)
  NEXT =: 0        NB. time for next keypress/macro event (last keypress+computed delay)
}}

setval =: {{
  B =: y           NB. the buffer to edit.
  E=: {.@(0&amp;$) B   NB. empty element (temp used when appending a value)
  C =: #B          NB. cursor position(s)
  M =: 0           NB. mark(s) (one per cursor)
  MODE =: 'n'      NB. MODE e. 'niq'  : 'n'avigate, 'i'nsert, 'q'uote
  LOG =: 0$a:      NB. macro recorder history
  TS =: 0$0        NB. timestamps for the log
  R =: 1           NB. set redraw flag
}}

getstate =: {{ C;B;M;MODE }}
setstate =: {{)v
  'c b m mode' =. y
  setval b
  0 0 $ C =: c [ M =: m [ MODE =: mode }}

ins =: {{
  tmp =. (1+C e.~ i.#b)#b=.B,E
  inspos =. &lt;:C=:&gt;:(+i.@#)C  NB. move all cursors forward
  newlen =. C+&amp;#B
  R=:1 [ B=: newlen {. y inspos } tmp }}"0

NB. !! maybe factor out 'tmp' here, as above in 'ins'?
del =: {{ if. (&gt;./C)&gt;:#B do. return.
          else. R=:1[ C=:C-i.#C[B=:}: (1-C e.~ i.#b)#b=.B,E end. }}
bsp =: del@bak

keol =: {{ R=:1[ B =: (C=:{.C) {. B }} NB. collapse cursors,kill to eol
eol =: {{ R=:1[ C=:C+(#B)-&gt;./C }}
bol =: {{ R=:1[ C=:C-&lt;./C }}
swp =: {{ R=:1[ B=: a (C-1) } b (C-2) } B [ a=. (C-2) { B [ b=. (C-1) { B }}
for =: {{ if. (#B)&gt;&gt;./C do. R=:1 [ C=:&gt;:C end. }}
bak =: {{ if. 0&lt;&lt;./C do. R=:1 [ C=:&lt;:C end. }}

atz =: {{y] -. (#B)&gt;&gt;./C }}
at0 =: {{y] -. 0&lt;&lt;./C }}
atsp =: ({{y] ' ' e. C{B }}) :: 0
fwd =: {{ whilst. (atz +: atsp)'' do. for'' end. }}
bwd =: {{ whilst. (at0 +: atsp)'' do. bak'' end. }}

NB. this is a dyad so that multi-line editor can draw the cursor
NB. on a line other than line 0. (y_coord render_cursor is_focused)
NB. (so sadly, argument x is the y coordinate.)
render_cursor =: 0&amp;$: : {{
  if. y do. fg CU_FG [ bg CU_BG else. fg HI_FG [ bg HI_BG  end.
  NB. draw each cursor at cooridates (C,x) (where again arg x=y coord)
  C {{ goxy xy [ putc x{B,E [ goxy xy=.x,y }}"0 x
  0 0$0}}

render =: {{
  bg BG [ fg FG
  puts B
  render_cursor y
  bg BG [ fg FG  }}

do =: play NB. old name. !!! deprecate this.
play =: {{ NB. queue macro y for playback
  MACRO =: y NB. the macro to play
  NEXT =: 0 NB. start immediately
  T =: 0 NB. start the timer
  A =: 1 NB. start animation mode
  I =: 0 NB. the index into macro / instruction pointer
}}

NB. play entire macro immediately, without animation
NB. (used by macro debugger in jprez)
instaplay =: {{
  setval ''
  play y   NB. queue macro for playback.
  try.
    while. A do. update NEXT=:0 end. NB. fast forward to end
  catch.
    echo 'in here'
    A =: 0 NB. turn off animation if failed
    setval '&gt;ERR: ', (dberm'')-.CRLF
  end.
  A =: 0
  0 0 $ 0}}

update =: {{
  if. (T =: T + y) &lt; NEXT do. return. end. NB. y = seconds since last update
  T =: 0 [ NEXT =: (TSV*?0) + %KPS NB. schedule next keypress
  NB. this provides a little language for animating the editors.
  NB. execute a series of actions on the token editor
  q =. '?'  NB. quote char. '?' is rare symbol in j
  if. I &lt; # MACRO do.
    c =. I{MACRO
    select. MODE
    fcase. 'q' do.
      if. c = q do. ins q [ MODE =: 'i' return.
      else. MODE=:'n' end. NB. and fall through
    case. 'n' do.
      if. c='?' do. MODE =: 'i'
      else. (CMD_VERBS`] {~ CMD_CHARS&amp;i.c)`:0 '' end.
    case. 'i' do.
      if. c = q do. MODE =: 'q'
      else. ins c end.
    end.
    R =: 1 [ I =: I + 1
  else. on_macro_end'' [ A =: 0 end.
  if. MODE = 'q' do. MODE =: 'n' end. }}

NB. -- interactive app --
coinsert 'kvm'

NB. event handlers for up/down/enter keys
on_up =: ]
on_dn =: ]
on_accept =: ]
on_macro_end =: ]

now =: 6!:1
log =: {{ TS =: TS,now'' [ LOG =: LOG,&lt;y }}

k_asc =: {{log '?',y,'?' }} [ ins

NB. -- tables for macro language and keybindings
rdtbl =: {{cut&amp;&gt; LF cut y-.CR}}

NB. key&lt;-&gt;macro table
KEYS =: rdtbl noun define
k_ardn v
k_arup ^
k_bsp X
ka_b b
ka_f w
kc_a 0
kc_b &lt;
kc_d x
kc_e $
kc_f &gt;
kc_h X
kc_k K
kc_m !
kc_n v
kc_p ^
kc_t T
)

NB. macro&lt;-&gt;method table
CMDS =: rdtbl noun define
! on_accept
$ eol
0 bol
K keol
T swp
X bsp
b bwd
&lt; bak
v on_dn
^ on_up
&gt; for
w fwd
x del
)

NB. extract columns of those above tables
KEY_PRESS=: 0{"1 KEYS     NB. ex: &lt;'kc_e'
KEY_CMDS=:  1{"1 KEYS     NB. ex: &lt;'$'
CMD_CHARS =: ,&gt;0{"1 CMDS  NB. ex: '$'
CMD_VERBS =:   1{"1 CMDS  NB. ex: &lt;'eol'

NB. 3 column table of keypress, key_cmd/cmd_char, cmd_verb
KEYMAP =: KEY_PRESS ,. KEY_CMDS ,. CMD_VERBS {~ CMD_CHARS i. &gt;KEY_CMDS

NB. define keyboard handlers using the above tables.
NB. for each (k_verb, cmdchar, cmdverb) triple, define:
NB.     k_verb =: log@cmdchar @ cmdverb
NB. ex: kc_e =: log@'$' @ eol
".(' =: log@'''; ''' @ ';'') ;@,.~"1  KEYMAP

NB. catch-all keyboard handling for inserting normal keys into text
k_asc =: {{log '?',y,'?' }} [ ins


mi =: {{ y {~ I. -.@(+. _1&amp;|.) '??' E.y }} NB. merge inserts
gettimes =: {{
  q=.5 NB. quantization factor
  &lt;.q^.100*2-~/\TS }}

getlog =: {{ if. 0=#LOG do. '' else. mi ;&lt;@;"1 LOG ,.~ (#&amp;'_') each 0,gettimes'' end. }}

kvm_init =: {{ R =: 1 [ curs 0 }}
kvm_done =: {{ curs 1 [ reset'' [ echo'' [ raw 0}}
lined =: {{ if. R do. draw'' [ R=: 0 end. }} loop@'UiField'
ed_z_=:lined_ed_

NB. tests framework
create''
assert '!.!michal!.!' -: 'B'~ [ ins'!.!' [ B=:'michal' [ C=:0 6
sho =. {{ b,:'-^' {~ C e.~i.#b=.B,E }}
sho B0=.B [ C0=.C
create ''
</t>
<t tx="tangentstorm.20220205225640.6">@language J

coclass 'UiList' extends 'UiWidget'

doc =: 'A vertically-scrolling buffer with one line highlighted.'

create =: verb define
  W =: 32
  H =: 8
  S =: 0      NB. scroll position
  C =: 0      NB. cursor
  L =: y      NB. boxed list of labels
)

fwd =: {{ C=:(&lt;:#L)&lt;.C+1 if. (C-S) &gt;: H do. S =: S + 1 end. C }}
bak =: {{ C=: 0 &gt;. C-1   if. (C-S) &lt; 0 do. S =: S - 1 end. C }}
val =: {{ C { ::a: L }}
(at0 =: {{ C = 0 }}) `(atz =: {{ C = &lt;: #L }})
(go0 =: {{ C =: 0 }})`(goz =: {{ S =: 0 &gt;. (H-~#L) &lt;. C =: &lt;: #L }})

ins =: {{ R=:1 [ L=: }: (&lt;y) C }b#~1+C=i.#b=.L,{.L }}
del =: {{ R=:1 [ L=: L#~-.C=i.#L }}
set =: {{ R=:1 [ L=: (&lt;y) C } L }}

render =: verb define
  for_vln. H {. S }. L do.  NB. visible lines
    goxy 0,i=.vln_index
    hi =. (C=S+i)
    if. y do.
      fg hi pick TX_FG;CU_FG
      bg hi pick TX_BG;CU_BG
    else.
      fg hi pick TX_FG;HI_FG
      bg hi pick TX_BG;HI_BG
    end.
    if. vln -: a: do. puts W#' '
    else. puts W{.&gt;vln end.
  end.
)
</t>
<t tx="tangentstorm.20220205225713.2">@language J
NB. (text-based) UI widgets for kvm
require 'tangentstorm/j-kvm/vid'
extends_z_ =: {{ x [ coinsert y [ cocurrent x }}
of_self_z_ =: {{ (m,'_','_',~&gt;coname'')~ }}

cocurrent 'UiTheme' extends 'kvm'

NB. TX = plain text color
TX_FG =: _7
TX_BG =: 0

NB. HI = hilight color (unfocused cursor)
HI_FG =: 0
HI_BG =: _7

NB. CU = focused cursor
CU_FG =: 0
CU_BG =: _214


coclass 'UiWidget' extends 'UiTheme'

create =: ]
render =: ]
update =: ]

termdraw =: {{ NB. y is hasfocus (same arg as render)
  buf =. (W,H) conew 'vid'
  pushterm buf
  render y
  popterm''
  XY blit buf
  0 0 $ codestroy__buf'' }}

XY =: 0 0          NB. location on screen
H  =: 1            NB. height
W  =: 1            NB. width
R  =: 1            NB. need to redraw?
V  =: 1            NB. visible?
A  =: 1            NB. animated/active?

load 'tangentstorm/j-kvm/ui/list'    NB. UiList
load 'tangentstorm/j-kvm/ui/edit'    NB. UiEditWidget
load 'tangentstorm/j-kvm/ui/app'     NB. UiApp
</t>
<t tx="tangentstorm.20220205225722.1"></t>
<t tx="tangentstorm.20220205231205.1"></t>
<t tx="tangentstorm.20220205231208.1"></t>
<t tx="tangentstorm.20220205232416.1"></t>
<t tx="tangentstorm.20220205232416.2">@language j
NB. minimal j editor
NB.
NB. This file my attempt to port my presentation tool
NB. over to my new console-based libraries, token editor
NB. components, etc. It is something of a scratchpad and
NB. not well organized at the moment, but important enough
NB. that I should probably have it under version control.
(&lt;'z') copath 'base' NB. clear previous path
load'tangentstorm/j-kvm tangentstorm/j-kvm/ui tangentstorm/j-lex'
load'worlds.ijs org.ijs tok.ijs repl.ijs jedit.ijs macro.ijs'
coinsert 'kvm'
dbg 1
copush_z_ =: {{ 18!:4 y [ BASE__y =: coname'' [ y=.&lt;y }}
copop_z_ =: {{ y [ 18!:4 BASE [ y=.coname'' }}

NB. main code
ORG_PATH =: {{
  if. '.org' {.@E.&amp;.|. arg=.&gt;{:ARGV do. arg
  else. './screenplay.org' end. }}''


NB. org-mode stuff
open =: {{
  org_slides ORG_PATH  NB. defines title =: ... and  slides =: ...
  NB. heads is the indented outline that shows up on the left
  heads =: &lt;@;"1((' '#~+:@&lt;:) each 3 {"1 slides),.(0{"1 slides)
  rebuild''}}

rebuild =: {{
  emit_vm_ =: ] NB. so j-kvm/vm outputs string we can capture (vs puts)
  NB. (index I. (C__list, C__cmd) { olw) says which world we are in
  index =: 0 0 $ 0  NB. one entry per line that starts with : (slide,line no)
  olw =: ,0  NB. outline worlds. 'now'=EHISTL0/EHISTL1 in (i{olw)
  init_world_''
  tmp =. ''conew 'UiEditWidget' NB. for tracking start states per macro
  KPS__tmp =: _ [ TSV__tmp =: 0 NB. infinite speed, no random variation
  olr =: ,&lt;getstate__tmp''      NB. repl state for each ':' line
  for_slide. slides do. i =. slide_index
    for_line. text i do. j =. line_index
      if. -. line = a: do.
        line =. &gt; line
        if. ': ' {.@E. line do. line =. 2}.line     NB. : marks code line
          if. '. ' {.@E. line do. line =. 2}.line   NB. : . is editor macro
            do__tmp line while. A__tmp do. update__tmp 1 end. NB. run macro
          else.
            setval__tmp line
            exec_world_ line           NB. execute code in repl
            setval__tmp''
          end.
          index =: index, i,j
          olr =: olr,&lt;getstate__tmp'' NB. store start state for next cmd
          olw =: olw,ii_world_        NB. world stores both start &amp; end state
        end.
      end.
    end.
  end.
  codestroy__tmp''
  emit_vm_ =: emit0_vm_ NB. restore j-kvm/vm
  0 0$0}}

open''  NB. TODO: move to bottom

NB. --  screen setup ---------------------------------------------------
H_SPLIT =: 24 NB. initial height of horizontal splitter

NB. indent headings based on depth
list =: 'UiList' conew~ heads
H__list =: (&gt;:ymax'')-H_SPLIT
XY__list =: 0,H_SPLIT
TX_BG__list =: 16b111122

NB. the detailed text of the screenplay (also macro commands)
cmds =: 'UiList' conew~ a:
W__cmds =: (xmax'')-(W__list)
H__cmds =: H__list
XY__cmds =: ((W__list+2),0) + XY__list
TX_BG__cmds =: 16b111122

NB. led is the line editor for editing a line of text in the outline
led =: 'MacroWidget' conew~ ''
XY__led =: XY__cmds
W__led =: W__cmds
V__led =: 0

repl =: 'UiRepl' conew~ ''   NB. W,XY of repl are calculated in show/hide editor
H__repl =: H_SPLIT
A__repl =: 1
OLD__repl =: ''
red =: ed__repl

editor =: 'JCodeEditor' conew~ ''
XY__editor =: 0 0
H__editor =: H_SPLIT
W__editor =: 70

show_editor =: {{ V__editor =: 1 [ XY__repl =: (W__editor+2), 0 [ W__red =: W__repl =: W__editor -~ xmax'' }}
hide_editor =: {{ V__editor =: 0 [ XY__repl =: 0 0 [ W__red =: W__repl =: 1+xmax'' }}
hide_editor''

app =: (list,editor,cmds,led,repl) conew 'UiApp'
smudge__app BG__app =: 16b112233

NB. -- widget modifications ---------------------------------------

NB. allow changing the repl line as we navigate through the outline
new_repl_line =: {{
  if. ': ' {.@E. val =. &gt;val__cmds'' do.
    if. ': . ' {.@E. val do. ''
    else. 2}.val end.
  else. '' end. }}

update__repl =: {{
  if. A__ed do. update__ed y end.
  R =: R +. R__ed
  new =. new_repl_line_base_''
  if. -. new -: OLD do.
    setval__ed OLD =: new
    R =: 1
  end. }}

inscmd =: put_text [ ins__cmds

accept__repl =: {{
  inscmd_base_ ': ', B__ed
  inscmd_base_ ': . ', getlog__ed''
  cmds =. cmds_base_
  fwd__cmds^:2''
  accept_UiRepl_ f.''
  rebuild_base_'' }}

cmdix =: {{ index I. C__list, C__cmds }}

worldnum =: {{ olw_base_ pick~ cmdix_base_'' }}
getworld__repl =: {{ 'WORLD',": worldnum_base_'' }}


NB. keyboard control
goto =: {{
 R__editor =: R__repl =: 1
 L__cmds =: text cur =: y
 setval__editor code y
 S__cmds =: C__cmds =: 0 }}

put_text =: {{ 0 0 $ slides =: (&lt;L__cmds) (&lt;cur,1) } slides  }}

COPATH =: copath coname''
keymode =: {{
  NB. modal editing kludge to simulate focused widget
  NB. and swap out keyboard handler.
  NB. the curtail (}:) is to cut out 'z' reference from copath y
  (~. (}: y;copath y),COPATH__BASE) copath BASE
  NB. also set focus to a widget:
  F__app =: FOCUS__ns [ ns =. &lt; y
  NB. !! this should probably be in an on_focus event, but:
  reset_rhist''
}}

NB. 1+worldnum includes the completed macro.
reset_rhist =: {{ goz__hist__repl'' [ L__hist__repl =: (1+worldnum'') {. ihist_world_ }}


NB. global keyboard shortcuts
NB. ----------------------------------------------------
kc_l =: smudge__app
kc_o =: reopen
kc_s =: save
kc_spc =: k_nul =: halt  NB. 'kc_spc' does nothing yet

k_f2 =: flip
k_f3 =: move_splitter@_1
k_f4 =: move_splitter@1
k_f5 =: toggle_editor
k_f6 =: goto@bak__list
k_f7 =: goto@fwd__list
k_f8 =: bak_cmd
k_f9 =: advance

advance =: {{
  if. ': . ' {.@E. &gt;val__cmds'' do. playmacro''
  else. fwd_cmd'' [ keymode'replkeys' end. }}

FLIP =: 1
flipped =: {{ FLIP }}
flip =: {{
  FLIP =: -FLIP
  H__list =: H__cmds =: H__editor [ th =. H__cmds
  H__editor =: H__repl =: th
  ty1 =. 1{XY__editor [ ty0 =. 1{XY__cmds
  XY__editor =: ty0 (1) } XY__editor
  XY__repl   =: ty0 (1) } XY__repl
  XY__list   =: ty1 (1) } XY__list
  XY__cmds   =: ty1 (1) } XY__cmds
  move_splitter 0
}}

move_splitter =: {{
  if. *./ 1 &lt; (H__list-y),H__repl + y do.
    if. FLIP = 1 do.
      XY__list =: XY__list + 0,y [ H__list =: H__list - y
      XY__cmds =: XY__cmds + 0,y [ H__cmds =: H__cmds - y
      H__editor =: H__editor + y
      H__repl =: H__repl + y
    else.
      XY__editor =: XY__editor + 0,y [ H__editor =: H__editor - y
      XY__repl   =: XY__repl   + 0,y [ H__repl =: H__repl - y
      H__cmds =: H__cmds + y
      H__list =: H__list + y
    end.
    smudge__app''
  end. }}

toggle_editor =: {{
  if. V__editor do. hide_editor'' else. show_editor'' end.
  smudge__app'' }}


save =: {{ (org_text'') fwrites ORG_PATH }}
halt =: {{ curs@1 @ reset@'' [ break_kvm_=: 1 }}
insline =: edline@'' @ inscmd@''
delline =: rebuild @ put_text@'' @ del__cmds

bak_cmd =: {{
  if. (at0__cmds &gt; at0__list)'' do.
    goto bak__list''
    goz__cmds''
  else. bak__cmds'' end. }}

fwd_cmd =: {{
  if. atz__cmds'' do. goto fwd__list''
  else. fwd__cmds'' end. }}

playmacro =: {{
  NB. play macro we currently looking at in the outline
  if. a: ~: cmd =. val__cmds'' do.
    cmd =. &gt;cmd
    if. ': . ' -: 4{.cmd do.
      setstate__red olr pick~ cmdix''
      reset_rhist'' NB. this includes the completed line...
      set__hist__repl'' NB. so delete it. (TODO: handle multi-line macros)
      on_macro_end__red =: fwd_cmd_base_
      do__red 4}.cmd
    end.
  end. }}


(copush [ coinsert) 'outkeys'
NB. -----------------------------------------------------------
coinsert BASE
FOCUS =: list__BASE [ ''`inscmd =: inscmd__BASE

k_any =: {{
  select. 0{y
  case.'9'do. goto bak__list''
  case.'0'do. goto fwd__list''
  case.'('do. bak__cmds''
  case.')'do. fwd__cmds''
  end. }}
k_E =: edrepl
k_N =: playmacro
k_O =: insline
k_d =: delline
k_e =: edline
k_j =: k_n =: fwd_cmd
k_k =: k_p =: bak_cmd
k_o =: insline@fwd__cmds
kc_i =: focus_on_repl

focus_on_repl =: {{
  R__list =: R__repl =: 1 NB. to redraw focus
  keymode__BASE 'replkeys' }}

reopen =: {{
  lc =. cur
  rc =. C__cmds
  init_world_''
  open''
  R__list =: 1 [ L__list =: heads
  goto lc &lt;. &lt;: #slides
  C__cmds =: rc &lt;. &lt;: #L__cmds }}

NB. outline / macro editor

register__led red  NB. red listens for changes to led ..
notify__led =: ]   NB. .. but ignores them by default.
edline =: {{
  R__led =: V__led =: 1 [ XY__led =: XY__cmds + 0,C__cmds-S__cmds
  C__led =: 0 [ B__led =: b=. '',&gt;val__cmds__BASE''
  ed_edkeys_ =: led
  keymode__BASE 'edkeys'
  if. ': ' -: 2 {. b do.
    if. ': . ' -: 4{.b do.
      notify__red =: instaplay @ (4&amp;}. [ reset_rhist_base_@'')
      setval__red ''
    else.
      notify__red =: setval @ (2&amp;}.)
      setval__red 2}.b
    end.
  else. notify__red =: ] end.
  0 0$0 }}

edrepl =: {{
  V__red =: R__red =: 1
  C__red =: 0 [ B__red =: 2}.&gt;val__cmds__BASE''
  keymode__BASE 'replkeys' }}

copop''

copush 'edkeys'
NB. -----------------------------------------------------------
FOCUS =: led =: led__BASE [ cmds =: cmds__BASE

stop =: {{
  keymode__BASE 'outkeys'
  V__led =: 0 [ R__repl =: R__red =: R__led =: R__cmds =: 1
  L__cmds =: (&lt;B__led) C__cmds } L__cmds
  put_text'' }}

NB. copy keymap from led. ex:  k_arup =: k_arup__led
". {{  y,' =: ',y,'__led' }}S:0 KEY_PRESS__led
k_asc =: k_asc__led
kc_m =: stop

copop''



copush'replkeys'
NB. -----------------------------------------------------------
FOCUS =: repl =: repl__BASE
red =: ed__repl

focus_on_outline =: {{
  R__repl =: 1 NB. to redraw without focus
  keymode__BASE 'outkeys' }}

NB. copy keymap from red. ex:  k_arup =: k_arup__red
". {{  y,' =: ',y,'__red' }}S:0 KEY_PRESS__red

k_asc =: k_asc__red
kc_i =: focus_on_outline  NB. tab to unfocus

copop''


rl =: {{ load'jprez.ijs' }} NB. reload command (for development)

NB. event loop
mje =: {{
  9!:29]0  NB. disable infinite loop on error
  curs 0
  goto 0 NB. slide 0
  NB. main loop
  step__app loop_kvm_'base'
  reset''
  0$0}}

NB. only run if directly invoked from command line
{{9!:29]1[9!:27 'mje _'}}^:('jprez.ijs' {.@E.&amp;.|. &gt;{.}.ARGV)''
</t>
<t tx="tangentstorm.20220206003930.1"></t>
<t tx="tangentstorm.20220206005043.1"></t>
<t tx="tangentstorm.20220206005052.1"></t>
<t tx="tangentstorm.20220206005121.1"></t>
<t tx="tangentstorm.20220206005129.1"></t>
<t tx="tangentstorm.20220206005523.1"></t>
<t tx="tangentstorm.20220206005856.1">@

the "current document"
 ORG_PATH -&gt; set by an imediate function at top.
 open command defines the following "globals"
    title  : the org title
    slides : (data structure of all slide information)
      accessor methods: head / text / code / depth
    heads  : headlines extracted and indented from slides
 TODO:
    - move these into a 'JPrezDoc' class
    - add timing column


the timeline "table", constructed by "rebuild"
not exactly a table, but a collection of  parallel arrays:

  index  : (slide #, line #) per line that starts with ":" 
      this tracks the location of input lines and keyboard macros
  olw : repl world number for the current line
  olr : repl's line editor state for each ":" line (used when playing back macros)


widget stuff:
  H_SPLIT
  list: (lhs widget)
  cmds: (rhs screenplay text/code widget)
  led: (line editor for commands) [should make cmds an edit widget instead]
  repl: "on-stage" UiRepl  (meaning it's part of the presentation)
  red: "on-stage" JCodeEditor 
  app: top-level UiApp


COPATH: used in the "focused widget keyboard command" kludge
FLIP: toggles layout of splitter


FOCUS
BASE_kbloc_ (one per keyboard locale, so we can call 'keymode__BASE', etc)
</t>
<t tx="tangentstorm.20220206014626.2">@language j
NB. jprez-specific org-mode parser
NB. the jprez format is a subset of org-mode:
NB.  - #+title: at the top
NB.  - any number of nested headlines
NB.  - body text only appears in leaf nodes ("slides")
NB.  - zero to one #+begin_src j ... #+end_src per slide
NB.  - lines starting with # indicate comments
NB.  - [[path/to/file.xyz]] indicates an audio file
NB.  - verbatim lines (starting with ":") indicate repl input or macros
NB.    - ": ." indicates that the line is a jprez keyboard macro
NB.    - ": " (not followed by " .") indicates verbatim repl input

between =: (&gt;:@[ +  i.@&lt;:@-~)/           NB. between 3 7 -&gt;  4 5 6
parse =: monad define
  NB. parse a single slide
  NB. returns (head; text; src) triple
  head =. (2+I.'* 'E.h) }. h=.&gt;{. y      NB. strip any number of leading '*'s, up to ' '
  depth =. h &lt;:@-&amp;# head                 NB. record the number of leading stars
  text =. }. y
  srcd =. '#+begin_src j';'#+end_src'    NB. source code delimiters
  src =. , |: si=.I. y ="1 0 srcd        NB. indices of start and end delimiters
  if. #src do.
    code =. y {~ between 2$src           NB. only take the first source block
    text =. (1{src) }. text
  else. code =. a:  end.
  (&lt;head),(&lt;text),(&lt;code),&lt;depth
)

org_slides =: verb define
  org =. 'b'freads y                     NB. returns a vector of boxed strings
  org =. 7 u: L:0 org
  headbits =. '*' = {.&amp;&gt; org             NB. 1 if org line starts with '*' (a headline)
  slide0 =. headbits &lt;;.1 org            NB. group lines: each headline starts a new slide
  title =: {.org
  slides =: &gt; parse each slide0
)


slide_lines =: {{
  'd h t c' =. (depth;head;text;&lt;@code) y
  r =. &lt;(d#'*'),' ',h
  if. #&gt;c do. r =. r,'#+begin_src j';c,&lt;'#+end_src' end.
  r,t }}

NB. turn the arrays back into org text:
org_text =: {{ ;(,&amp;LF)L:0 title,'';;slide_lines each i.#slides }}

head =: verb : '&gt; (&lt;y,0) { slides'  NB. -&gt; str
text =: verb : '&gt; (&lt;y,1) { slides'  NB. -&gt; [box(str)]
code =: verb : '&gt; (&lt;y,2) { slides'  NB. -&gt; [box(str)]
depth=: verb : '&gt; (&lt;y,3) { slides'  NB. -&gt; [box(str)]
</t>
<t tx="tangentstorm.20220206020948.1">NB.  planned: - "@mm:ss" at start of line (or after ": ") indicates a duration</t>
<t tx="tangentstorm.20220206125432.1"></t>
<t tx="tangentstorm.20220206150034.1"></t>
<t tx="tangentstorm.20220206155611.1"></t>
<t tx="tangentstorm.20220206155801.1"></t>
<t tx="tangentstorm.20220206155900.1"></t>
<t tx="tangentstorm.20220206160124.1"></t>
</tnodes>
</leo_file>
