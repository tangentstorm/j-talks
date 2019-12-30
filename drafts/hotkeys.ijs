load 'tables/dsv'

tbl =: [: dltb each '|' fixdsv ]

[ data =: tbl 0 :0
  1 | hello 'world'
  2 | whatever
  3 | foo
)

nn =: <@;:;._2 [ 0 : 0
 1 2 3
 4 5 6
 hello world
 7 8 9
)


NB. this pops up a little control that I intend to use as a keymap

wd'pc wnd closebutton; cc t table 10 2; pshow'
wd'psel wnd; set t hdr key value'
wd'psel wnd; set t colwidth 64 256; set t rowheight 40; set t font consolas'
wd'psel wnd; set t stylesheet *',0 : 0
  QHeaderView::section { background-color: #ccc; font-size:32px; height:50px; }
  QTableView { background-color: #bbc; width:100%; font-size: 32px; }
  QTableView::item { background-color: #eee; }
  QTableView::item::alternate { background-color: #fff; }
  QTableView::item::selected { color:#fff; background-color: #336; }
)

wnd_default =: 3 : 'smoutput sysevent'
wnd_t_change =: verb define
 wd'psel wnd; set t colwidth 64 256'
 smoutput _2,\ <;._2 wd'psel wnd; get t table'
)
wnd_t_mbldown =: verb define
  smoutput t
)