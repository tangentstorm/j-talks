Note 'better/simpler cut? am i missing something?'

11:38:32         Ashy | is there a phrase or idiom for insert_at?                                 │ Ashy
11:40:07         Ashy | something like: 'abc' 1 insert_at '123'                                   │ b_jonas
11:40:16         Ashy | '1abc23'                                                                  │ clarity
11:43:35      FireFly | not that I know of, I guess it'd be a mix of {. and }. with inserting the │ dnm
                      | thing in-between                                                          │ elcaro_
11:43:36      FireFly | hm                                                                        │ FireFly
11:46:37         Ashy | hmm, really i want to be able to hit multiple indexes at the same time    │ gaze___
                      | too                                                                       │ hrberg
11:47:01      FireFly | and the 'abc' needs to be dynamic as well?                                │ inr
11:47:05         Ashy | 'abc' 1 2 insert_at '123'    => '1abc2abc3'                               │ j-bot
11:47:39         Ashy | i think it's just stringreplace actually                                  │ jpjacobs
11:47:55      FireFly | you could cut at multiple indices into a vector of boxed strings and then │ kevingal
                      | join by 'abc' or so                                                       │ kevingal_
11:47:58      FireFly | maybe                                                                     │ leah2
11:48:00         Ashy | twisted myself in around in mental circles with this code.golf challenge  │ milia
                      | haha                                                                      │ moon-child
11:48:08      FireFly | hehe                                                                      │ neitzel
15:53:32 tangentstorm | is there an easy way to do the cut part?                                  │ nickspoon
16:01:12 tangentstorm | [ 1 2 ((+/\@:+./@:(e."1 0~) i.@#)</. ]) 'banana'                          │ tangentstorm
16:01:12        j-bot | tangentstorm: ┌─┬─┬────┐                                                  │ V
16:01:12        j-bot | tangentstorm: │b│a│nana│                                                  │ xelxebar
16:01:12        j-bot | tangentstorm: └─┴─┴────┘                                                  │ yosafbridge
16:01:19 tangentstorm | that's too much                                                           │


)
