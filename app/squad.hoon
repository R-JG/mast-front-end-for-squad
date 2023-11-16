/-  *squad
/+  default-agent, dbug, agentio, mast
/=  index  /app/squad/index
/=  css    /app/squad/css
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =display =current-url =component =squads =acls =members]
+$  card  card:agent:gall
--
::
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  bol=bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bol)
    io    ~(. agentio bol)
    yards  %-  limo  :~
      ['/squad' index]
    ==
++  on-init
  ^-  (quip card _this)
  :_  this
  :-  (~(arvo pass:io /bind) %e %connect `/'squad' %squad)
  ?:  =(~pocwet our.bol)  ~
  ~[(~(watch pass:io /hello) [~pocwet %squad] /hello)]
++  on-save  !>(state)
++  on-load
  |=  old-vase=vase
  ^-  (quip card _this)
  [~ this(state !<(state-0 old-vase))]
::
++  on-poke
  |=  [=mark =vase]
  |^  ^-  (quip card _this)
  ?>  =(our.bol src.bol)
  =^  cards  state
    ?+  mark  (on-poke:def mark vase)
      %squad-do             (handle-action !<(act vase))
      %handle-http-request  (handle-http !<([@ta inbound-request:eyre] vase))
      %json                 (handle-json !<(json vase))
    ==
  [cards this]
  ::
  ++  handle-http
    |=  [rid=@ta req=inbound-request:eyre]
    ^-  (quip card _state)
    ?.  authenticated.req
      :_  state
      (give-http rid [307 ['Location' '/~/login?redirect='] ~] ~)
    ?+  method.request.req
      :_  state
      %^    give-http
          rid
        :-  405
        :~  ['Content-Type' 'text/html']
            ['Content-Length' '31']
            ['Allow' 'GET, POST']
        ==
      (some (as-octs:mimes:html '<h1>405 Method Not Allowed</h1>'))
    ::
    %'GET'
      ?:  =('/squad/css' url.request.req)
        [(make-css-response:mast rid css) state]
      =/  rigged-sail  (rig:mast yards url.request.req [bol component squads acls members])
      :-  (plank:mast rid our.bol "squad" "/display-updates" rigged-sail)
      state(display rigged-sail, current-url url.request.req)
    ::
    ==
  ::
  ++  handle-json  
    |=  json-req=json
    ^-  (quip card _state)
    =/  client-poke  (parse:mast json-req)
    ?~  tags.client-poke  !!
    ?~  t.tags.client-poke  !!
    ?+  [i.tags.client-poke i.t.tags.client-poke]  !!
      [%click %join-squad]
        =/  target=(unit @t)  (~(get by data.client-poke) '/join-gid-input/value')
        ?~  target  !!
        =/  u-gid=(unit gid)
          %+  rush  u.target
          %+  ifix  [(star ace) (star ace)]
          ;~(plug ;~(pfix sig fed:ag) ;~(pfix fas sym))
        ?~  u-gid  !!
        ?:  =(our.bol host.u.u-gid)  !!
        =^  cards  state  
          =:  status-message.component  "joined: {(trip name.u.u-gid)}"
              input-reset-switch.component  !input-reset-switch.component
              ==
          (handle-action %join u.u-gid)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %create-squad]
        ?.  (~(has by data.client-poke) '/create-title-input/value')  !!
        =/  title=@t  (~(got by data.client-poke) '/create-title-input/value')
        =/  pub=(unit @t)  (~(get by data.client-poke) '/is-public-checkbox/checked')
        =/  is-pub=?  ?~(pub %.n ?:(=('true' u.pub) %.y %.n))
        =^  cards  state
          =:  status-message.component  "created: {(trip title)}"
              input-reset-switch.component  !input-reset-switch.component
              ==
          (handle-action %new title is-pub)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %change-title]
        ?~  t.t.tags.client-poke  !!
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        =/  u-title=(unit title)  
          (~(get by data.client-poke) (crip "/change-title-input-{(trip i.t.t.tags.client-poke)}/value")) 
        ?~  u-title  !!
        =^  cards  state  
          =:  status-message.component  "changed title to: {(trip u.u-title)}"
              input-reset-switch.component  !input-reset-switch.component
              ==
          (handle-action %title u.u-gid u.u-title)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %delete-squad]
        ?~  t.t.tags.client-poke  !!
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        ?.  =(our.bol host.u.u-gid)  !!
        =^  cards  state  
          =.  status-message.component  "deleted squad: {(trip name.u.u-gid)}"
          (handle-action %del u.u-gid)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %leave-squad]
        ?~  t.t.tags.client-poke  !!
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        ?:  =(our.bol host.u.u-gid)  !!
        =^  cards  state  
          =.  status-message.component  "left squad: {(trip name.u.u-gid)}"
        (handle-action %leave u.u-gid)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %kick]
        ?~  t.t.tags.client-poke  !!
        ?~  t.t.t.tags.client-poke  !!
        =/  source=tape  (trip i.t.t.t.tags.client-poke)
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        ?.  =(host.u.u-gid our.bol)  !!
        =/  u-ship-str=(unit @t)
          (~(get by data.client-poke) (crip "/kick-ship-input-{(trip i.t.t.tags.client-poke)}-{source}/value"))
        ?~  u-ship-str  !!
        =/  u-ship=(unit @p)
          %+  rush  u.u-ship-str
          %+  ifix  [(star ace) (star ace)]
          ;~(pfix sig fed:ag)
        ?~  u-ship  !!
        ?:  =(u.u-ship our.bol)  !!
        =^  cards  state  
          =:  status-message.component  "blacklisted: {<u.u-ship>} from: {(trip name.u.u-gid)}"
              input-reset-switch.component  !input-reset-switch.component
              ==
          (handle-action %kick u.u-gid u.u-ship)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %allow]
        ?~  t.t.tags.client-poke  !!
        ?~  t.t.t.tags.client-poke  !!
        =/  source=tape  (trip i.t.t.t.tags.client-poke)
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        ?.  =(host.u.u-gid our.bol)  !!
        =/  u-ship-str=(unit @t)
          (~(get by data.client-poke) (crip "/allow-ship-input-{(trip i.t.t.tags.client-poke)}-{source}/value"))
        ?~  u-ship-str  !!
        =/  u-ship=(unit @p)
          %+  rush  u.u-ship-str
          %+  ifix  [(star ace) (star ace)]
          ;~(pfix sig fed:ag)
        ?~  u-ship  !!
        =^  cards  state  
          =:  status-message.component  "whitelisted: {<u.u-ship>} for: {(trip name.u.u-gid)}"
              input-reset-switch.component  !input-reset-switch.component
              ==
          (handle-action %allow u.u-gid u.u-ship)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %make-public]
        ?~  t.t.tags.client-poke  !!
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        ?.  =(our.bol host.u.u-gid)  !!
        =^  cards  state
          =.  status-message.component  "made: {(trip name.u.u-gid)} public"
          (handle-action %pub u.u-gid)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %make-private]
        ?~  t.t.tags.client-poke  !!
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        ?.  =(our.bol host.u.u-gid)  !!
        =^  cards  state
          =.  status-message.component  "made: {(trip name.u.u-gid)} private"
          (handle-action %priv u.u-gid)
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) cards]
      [%click %select-squad]
        ?~  t.t.tags.client-poke  !!
        =/  u-gid=(unit gid)
          %+  rush  i.t.t.tags.client-poke
          ;~(plug fed:ag ;~(pfix cab sym))
        ?~  u-gid  !!
        =.  selected-squad.component   u.u-gid
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) ~]
      [%click %close-status-modal]
        =.  status-message.component  ""
        =/  rigged-sail  (rig:mast yards current-url [bol component squads acls members])
        :_  state(display rigged-sail)
        [(gust:mast /display-updates display.state rigged-sail) ~]
    ==
  ::
  ++  handle-action
    |=  =act
    ^-  (quip card _state)
    ?-  -.act
        %new
      =/  =gid  [our.bol (title-to-name title.act)]
      =/  =squad  [title.act pub.act]
      =/  acl=ppl  ?:(pub.act *ppl (~(put in *ppl) our.bol))
      =/  =ppl  (~(put in *ppl) our.bol)
      :_  %=  state
            squads   (~(put by squads) gid squad)
            acls     (~(put by acls) gid acl)
            members  (~(put by members) gid ppl)
          ==
      :~  (fact:io squad-did+!>(`upd`[%init gid squad acl ppl]) ~[/local/all])
      ==
    ::
        %del
      ?>  =(our.bol host.gid.act)
      :_  %=  state
            squads   (~(del by squads) gid.act)
            acls     (~(del by acls) gid.act)
            members  (~(del by members) gid.act)
          ==
      :-  (fact:io squad-did+!>(`upd`[%del gid.act]) ~[/local/all])
      (fact-kick:io /[name.gid.act] squad-did+!>(`upd`[%del gid.act]))
    ::
        %allow
      ?>  =(our.bol host.gid.act)
      ?<  =(our.bol ship.act)
      =/  pub=?  pub:(~(got by squads) gid.act)
      ?:  ?|  &(pub !(~(has ju acls) gid.act ship.act))
              &(!pub (~(has ju acls) gid.act ship.act))
          ==
        `state
      :_  state(acls (?:(pub ~(del ju acls) ~(put ju acls)) gid.act ship.act))
      :~  %+  fact:io
            squad-did+!>(`upd`[%allow gid.act ship.act])
          ~[/local/all /[name.gid.act]]
      ==
    ::
        %kick
      ?>  =(our.bol host.gid.act)
      ?<  =(our.bol ship.act)
      =/  pub=?  pub:(~(got by squads) gid.act)
      ?:  ?|  &(pub (~(has ju acls) gid.act ship.act))
              &(!pub !(~(has ju acls) gid.act ship.act))
          ==
        `state
      :_  %=  state
            acls  (?:(pub ~(put ju acls) ~(del ju acls)) gid.act ship.act)
            members  (~(del ju members) gid.act ship.act)
          ==
      :~  %+  fact:io
            squad-did+!>(`upd`[%kick gid.act ship.act])
          ~[/local/all /[name.gid.act]]
          (kick-only:io ship.act ~[/[name.gid.act]])
      ==
    ::
        %join
      ?:  |(=(our.bol host.gid.act) (~(has by squads) gid.act))
        `state
      =/  =path  /[name.gid.act]
      :_  state
      :~  (~(watch pass:io path) [host.gid.act %squad] path)
      ==
    ::
        %leave
      ?<  =(our.bol host.gid.act)
      ?>  (~(has by squads) gid.act)
      =/  =path  /[name.gid.act]
      :_  %=  state
            squads   (~(del by squads) gid.act)
            members  (~(del by members) gid.act)
            acls     (~(del by acls) gid.act)
          ==
      :~  (~(leave-path pass:io path) [host.gid.act %squad] path)
          (fact:io squad-did+!>(`upd`[%leave gid.act our.bol]) ~[/local/all])
      ==
    ::
        %pub
      ?>  =(our.bol host.gid.act)
      =/  =squad  (~(got by squads) gid.act)
      ?:  pub.squad  `state
      :_  %=  state
            squads  (~(put by squads) gid.act squad(pub &))
            acls    (~(del by acls) gid.act)
          ==
      :~  %+  fact:io
            squad-did+!>(`upd`[%pub gid.act])
          ~[/local/all /[name.gid.act]]
      ==
    ::
        %priv
      ?>  =(our.bol host.gid.act)
      =/  =squad  (~(got by squads) gid.act)
      ?.  pub.squad  `state
      =/  =ppl  (~(got by members) gid.act)
      :_  %=  state
            squads  (~(put by squads) gid.act squad(pub |))
            acls    (~(put by acls) gid.act ppl)
          ==
      :~  %+  fact:io
            squad-did+!>(`upd`[%priv gid.act])
          ~[/local/all /[name.gid.act]]
      ==
    ::
        %title
      ?>  =(our.bol host.gid.act)
      =/  =squad  (~(got by squads) gid.act)
      ?:  =(title.squad title.act)
        `state
      :_  state(squads (~(put by squads) gid.act squad(title title.act)))
      :~  %+  fact:io
            squad-did+!>(`upd`[%title gid.act title.act])
          ~[/local/all /[name.gid.act]]
      ==
    ==
  ++  title-to-name
    |=  =title
    ^-  @tas
    =/  new=tape
      %+  scan
        (cass (trip title))
      %+  ifix
        :-  (star ;~(less aln next))
        (star next)
      %-  star
      ;~  pose
        aln
        ;~  less
          ;~  plug
            (plus ;~(less aln next))
            ;~(less next (easy ~))
          ==
          (cold '-' (plus ;~(less aln next)))
        ==
      ==
    =?  new  ?=(~ new)
      "x"
    =?  new  !((sane %tas) (crip new))
      ['x' '-' new]
    ?.  (~(has by squads) [our.bol (crip new)])
      (crip new)
    =/  num=@ud  1
    |-
    =/  =@tas  (crip "{new}-{(a-co:co num)}")
    ?.  (~(has by squads) [our.bol tas])
      tas
    $(num +(num))
  ::
  ++  index-redirect
    |=  [rid=@ta path=@t]
    ^-  (list card)
    (give-http rid [302 ['Location' path] ~] ~)
  ::
  ++  make-200
    |=  [rid=@ta dat=octs]
    ^-  (list card)
    %^    give-http
        rid
      :-  200
      :~  ['Content-Type' 'text/html']
          ['Content-Length' (crip ((d-co:co 1) p.dat))]
      ==
    [~ dat]
  ::
  ++  give-http
    |=  [rid=@ta hed=response-header:http dat=(unit octs)]
    ^-  (list card)
    :~  [%give %fact ~[/http-response/[rid]] %http-response-header !>(hed)]
        [%give %fact ~[/http-response/[rid]] %http-response-data !>(dat)]
        [%give %kick ~[/http-response/[rid]] ~]
    ==
  --
::
++  on-watch
  |=  =path
  |^  ^-  (quip card _this)
  ?:  &(=(our.bol src.bol) ?=([%http-response *] path))
    `this
  ?:  &(=(our.bol src.bol) ?=([%display-updates *] path))
    `this
  ?:  ?=([%local %all ~] path)
    ?>  =(our.bol src.bol)
    :_  this
    :~  %-  fact-init:io
        squad-did+!>(`upd`[%init-all squads acls members])
    ==
  ?>  ?=([@ ~] path)
  =/  =gid  [our.bol i.path]
  =/  =squad  (~(got by squads) gid)
  ?:  pub.squad
    ?<  (~(has ju acls) gid src.bol)
    ?:  (~(has ju members) gid src.bol)
      [~[(init gid)] this]
    :_  this(members (~(put ju members) gid src.bol))
    :~  (init gid)
        %+  fact:io
          squad-did+!>(`upd`[%join gid src.bol])
        ~[/local/all /[name.gid]]
    ==
  ?>  (~(has ju acls) gid src.bol)
  ?:  (~(has ju members) gid src.bol)
    [~[(init gid)] this]
  :_  this(members (~(put ju members) gid src.bol))
  :~  (init gid)
      %+  fact:io
        squad-did+!>(`upd`[%join gid src.bol])
      ~[/local/all /[name.gid]]
  ==
  ::
  ++  init
    |=  =gid
    ^-  card
    %+  fact-init:io  %squad-did
    !>  ^-  upd
    :*  %init
        gid
        (~(got by squads) gid)
        (~(get ju acls) gid)
        (~(got by members) gid)
    ==
  --
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?>  ?=([@ ~] wire)
  =/  =gid  [src.bol i.wire]
  ?+  -.sign  (on-agent:def wire sign)
      %watch-ack
    ?~  p.sign
      [~ this]
    :_  %=  this
          squads   (~(del by squads) gid)
          acls     (~(del by acls) gid)
          members  (~(del by members) gid)
        ==
    :~  (fact:io squad-did+!>(`upd`[%kick gid our.bol]) ~[/local/all])
    ==
  ::
      %kick
    ?.  (~(has by squads) gid)  `this
    :_  this
    :~  (~(watch pass:io wire) [host.gid %squad] wire)
    ==
  ::
      %fact
    ?>  ?=(%squad-did p.cage.sign)
    =/  =upd  !<(upd q.cage.sign)
    ?+  -.upd  (on-agent:def wire sign)
        %init
      ?.  =(gid gid.upd)  `this
      :-  ~[(fact:io cage.sign ~[/local/all])]
      %=  this
        squads   (~(put by squads) gid squad.upd)
        acls     (~(put by acls) gid acl.upd)
        members  (~(put by members) gid ppl.upd)
      ==
    ::
        %del
      ?.  =(gid gid.upd)  `this
      :_  %=  this
            squads  (~(del by squads) gid)
            acls  (~(del by acls) gid)
            members  (~(del by members) gid)
          ==
      :~  (fact:io cage.sign ~[/local/all])
          (~(leave-path pass:io wire) [src.bol %squad] wire)
      ==
    ::
        %allow
      ?.  =(gid gid.upd)  `this
      =/  pub=?  pub:(~(got by squads) gid)
      :-  ~[(fact:io cage.sign ~[/local/all])]
      this(acls (?:(pub ~(del ju acls) ~(put ju acls)) gid ship.upd))
    ::
        %kick
      ?.  =(gid gid.upd)  `this
      =/  pub=?  pub:(~(got by squads) gid)
      ?.  =(our.bol ship.upd)
        :-  ~[(fact:io cage.sign ~[/local/all])]
        %=  this
          acls  (?:(pub ~(put ju acls) ~(del ju acls)) gid ship.upd)
          members  (~(del ju members) gid ship.upd)
        ==
      :_  %=  this
            squads   (~(del by squads) gid)
            acls     (~(del by acls) gid)
            members  (~(del by members) gid)
          ==
      :~  (fact:io cage.sign ~[/local/all])
          (~(leave-path pass:io wire) [src.bol %squad] wire)
      ==
    ::
        %join
      ?.  =(gid gid.upd)  `this
      :-  ~[(fact:io cage.sign ~[/local/all])]
      this(members (~(put ju members) gid ship.upd))
    ::
        %leave
      ?.  =(gid gid.upd)  `this
      ?:  =(our.bol ship.upd)  `this
      :-  ~[(fact:io cage.sign ~[/local/all])]
      this(members (~(del ju members) gid ship.upd))
    ::
        %pub
      ?.  =(gid gid.upd)  `this
      =/  =squad  (~(got by squads) gid)
      ?:  pub.squad  `this
      :-  ~[(fact:io cage.sign ~[/local/all])]
      %=  this
        squads  (~(put by squads) gid squad(pub &))
        acls    (~(put by acls) gid *ppl)
      ==
    ::
        %priv
      ?.  =(gid gid.upd)  `this
      =/  =squad  (~(got by squads) gid)
      ?.  pub.squad  `this
      :-  ~[(fact:io cage.sign ~[/local/all])]
      %=  this
        squads  (~(put by squads) gid squad(pub |))
        acls    (~(put by acls) gid (~(get ju members) gid))
      ==
    ::
        %title
      ?.  =(gid gid.upd)  `this
      =/  =squad  (~(got by squads) gid)
      ?:  =(title.squad title.upd)  `this
      :-  ~[(fact:io cage.sign ~[/local/all])]
      %=  this
        squads  (~(put by squads) gid squad(title title.upd))
      ==
    ==
  ==
::
++  on-leave
  |=  =path
  ^-  (quip card _this)
  ?.  ?=([@ ~] path)  (on-leave:def path)
  ?:  |(=(src.bol our.bol) (~(any by sup.bol) |=([=@p *] =(src.bol p))))
    `this
  =/  =gid  [our.bol i.path]
  :_  this(members (~(del ju members) gid src.bol))
  :~  (fact:io squad-did+!>(`upd`[%leave gid src.bol]) ~[/local/all path])
  ==
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %all ~]
    ``noun+!>([squads acls members])
  ::
      [%x %squads ~]
    ``noun+!>(squads)
  ::
      [%x %gids %all ~]
    ``noun+!>(`(set gid)`~(key by squads))
  ::
      [%x %gids %our ~]
    =/  gids=(list gid)  ~(tap by ~(key by squads))
    =.  gids  (skim gids |=(=gid =(our.bol host.gid)))
    ``noun+!>(`(set gid)`(~(gas in *(set gid)) gids))
  ::
      [%x %squad @ @ ~]
    =/  =gid  [(slav %p i.t.t.path) i.t.t.t.path]
    ``noun+!>(`(unit squad)`(~(get by squads) gid))
  ::
      [%x %acl @ @ ~]
    =/  =gid  [(slav %p i.t.t.path) i.t.t.t.path]
    =/  u-squad=(unit squad)  (~(get by squads) gid)
    :^  ~  ~  %noun
    !>  ^-  (unit [pub=? acl=ppl])
    ?~  u-squad
      ~
    `[pub.u.u-squad (~(get ju acls) gid)]
  ::
      [%x %members @ @ ~]
    =/  =gid  [(slav %p i.t.t.path) i.t.t.t.path]
    ``noun+!>(`ppl`(~(get ju members) gid))
  ::
      [%x %titles ~]
    :^  ~  ~  %json
    !>  ^-  json
    :-  %a
    %+  turn
      (sort ~(tap by squads) |=([[* a=@t *] [* b=@t *]] (aor a b)))
    |=  [=gid =@t ?]
    ^-  json
    %-  pairs:enjs:format
    :~  :-  'gid'
        %-  pairs:enjs:format
        :~  ['host' s+(scot %p host.gid)]
            ['name' s+name.gid]
        ==
        ['title' s+t]
    ==
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%bind ~] wire)
    (on-arvo:def [wire sign-arvo])
  ?.  ?=([%eyre %bound *] sign-arvo)
    (on-arvo:def [wire sign-arvo])
  ~?  !accepted.sign-arvo
    %eyre-rejected-squad-binding
  `this
::
++  on-fail  on-fail:def
--
