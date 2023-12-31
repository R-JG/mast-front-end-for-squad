/-  *squad
|=  [bol=bowl:gall =component =squads =acls =members]
|^  ^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;link(href "https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Source+Code+Pro:wght@400;600&display=swap", rel "stylesheet");
    ;link(href "/squad/css", rel "stylesheet");
  ==
  ;body
    ;+  (status-modal status-message.component)
    ;main
      ;div.forms-section
        ;h2: Join
        ;+  join-component
        ;h2: Create
        ;+  new-component
      ==
      ;div
        =class  ?~(squads "squads-section-null" "squads-section")
        ;+  ?~  squads
              ;/("")
            ;h2.squads-heading: Squads
        ;*  %+  turn
              %+  sort  ~(tap by squads)
              |=  [a=[* =title *] b=[* =title *]]
              (aor title.a title.b)
            squad-component
      ==
    ==
  ==
==
::
++  status-modal
  |=  txt=tape
  ^-  manx
  ?~  txt  ;div;
  ;div.status-modal
    ;+  ;/  txt
    ;button(event "/click/close-status-modal"): ×
  ==
::
++  join-component
  ^-  manx
  ;div.join-component
    ;input
      =id           "join-gid-input"
      =class        "code"
      =placeholder  "~sampel-palnet/squad-name"
      =reset   <input-reset-switch.component>
      ;+  ;/("")
    ==
    ;button
      =class        "bg-green-400 text-white" 
      =event   "/click/join-squad" 
      =return  "/join-gid-input/value"
      ;+  ;/  "Join"
    ==
  ==
::
++  new-component
  ^-  manx
  ;div(class "new-form")
    ;input
      =id           "create-title-input"
      =placeholder  "My squad"
      =reset   <input-reset-switch.component>
      ;+  ;/("")
    ==
    ;div.new-component-checkbox
      ;input
        =id     "is-public-checkbox"
        =type   "checkbox"
        =reset   <input-reset-switch.component>
        ;+  ;/("")
      ==
      ;label(for "is-public-checkbox"): Public
    ==
    ;button
      =class        "bg-green-400 text-white"
      =event   "/click/create-squad"
      =return  "/create-title-input/value /is-public-checkbox/checked"
      ;+  ;/  "Create"
    ==
  ==
::
++  squad-component
  |=  [=gid =squad]
  ^-  manx
  =/  gid-str=tape  "{=>(<host.gid> ?>(?=(^ .) t))}_{(trip name.gid)}"
  =/  summary=manx
    ;div
      =class  ?:(=(gid selected-squad.component) "squad-summary-selected" "squad-summary")
      =event  ?:(=(gid selected-squad.component) "" "/click/select-squad/{gid-str}")
      ;h3(class "inline"): {(trip title.squad)}
    ==
  =/  content=manx
    ;div.squad-content
      ;p
        ;span(style "margin-right: 2px;"): id:
        ;span(class "code"): {<host.gid>}/{(trip name.gid)}
      ==
      ;+  ?.  =(our.bol host.gid)
            ;/("")
          (squad-title-component gid squad)
      ;+  (squad-leave-component gid)
      ;+  ?.  =(our.bol host.gid)
            ;/("")
          (squad-public-component gid squad)
      ;+  (squad-acl-component gid squad)
      ;+  (squad-members-component gid squad)
    ==
  ;div(id gid-str)
    ;+  summary
    ;+  ?:  =(gid selected-squad.component)
      content
    ;div;
  ==
::
++  squad-title-component
  |=  [=gid =squad]
  ^-  manx
  =/  gid-str=tape  "{=>(<host.gid> ?>(?=(^ .) t))}_{(trip name.gid)}"
  =/  input-id=tape  "change-title-input-{gid-str}"
  ;div
    ;label(for input-id): title:
    ;input
      =id           input-id
      =placeholder  "My Squad"
      =reset   <input-reset-switch.component>
      ;+  ;/("")
    ==
    ;button
      =event  "/click/change-title/{gid-str}"
      =return  "/{input-id}/value"
      ;+  ;/  "Change"
    ==
  ==
::
++  squad-public-component
  |=  [=gid =squad]
  ^-  manx
  =/  gid-str=tape  "{=>(<host.gid> ?>(?=(^ .) t))}_{(trip name.gid)}"
  ?:  pub.squad
    ;button(event "/click/make-private/{gid-str}"): Make Private
  ;button(event "/click/make-public/{gid-str}"): Make Public
::
++  squad-leave-component
  |=  =gid
  ^-  manx
  =/  gid-str=tape  "{=>(<host.gid> ?>(?=(^ .) t))}_{(trip name.gid)}"
  ?:  =(our.bol host.gid)
    ;div(class "delete-form")
      ;button
        =class       "bg-red text-white" 
        =event  "/click/delete-squad/{gid-str}"
        ;+  ;/  "Delete"
      ==
    ==
  ;div(class "leave-form")
    ;button
      =class       "bg-red text-white" 
      =event  "/click/leave-squad/{gid-str}"
      ;+  ;/  "Leave"
    ==
  ==
::
++  squad-acl-component
  |=  [=gid =squad]
  ^-  manx
  =/  acl=(list @p)  ~(tap in (~(get ju acls) gid))
  =/  gid-str=tape  "{=>(<host.gid> ?>(?=(^ .) t))}_{(trip name.gid)}"
  =/  summary=manx
    ;summary
      ;h4(class "inline"): {?:(pub.squad "Blacklist" "Whitelist")} ({(a-co:co (lent acl))})
    ==
  =/  kick-allow-form=manx
    =/  kick-or-allow  ?:(pub.squad "kick" "allow")
    =/  kick-allow-input-id  "{kick-or-allow}-ship-input-{gid-str}-form"
    ;div
      ;input
        =id           kick-allow-input-id
        =placeholder  "~sampel-palnet"
        =reset   <input-reset-switch.component>
        ;+  ;/("")
      ==
      ;button
        =event   "/click/{kick-or-allow}/{gid-str}/form"
        =return  "/{kick-allow-input-id}/value"
        ;+  ;/  ?:(pub.squad "Blacklist" "Whitelist")
      ==
    ==
  =/  ships=manx
    ;div(id "acl:{gid-str}")
      ;*  %+  turn
            %+  sort  acl
            |=([a=@p b=@p] (aor (cite:^title a) (cite:^title b)))
          |=(=ship (ship-acl-item-component gid ship pub.squad))
    ==
  ;details
    ;+  summary
    ;div
      ;+  ?.  =(our.bol host.gid)
            ;/("")
          kick-allow-form
      ;+  ships
    ==
  ==
::
++  ship-acl-item-component
  |=  [=gid =ship pub=?]
  ^-  manx
  ?.  =(our.bol host.gid)
    ;span(class "ship-acl-span"): {(cite:^title ship)}
  =/  gid-str=tape  "{=>(<host.gid> ?>(?=(^ .) t))}_{(trip name.gid)}"
  =/  kick-or-allow  ?:(pub "allow" "kick")
  =/  kick-allow-input-id  "{kick-or-allow}-ship-input-{gid-str}-acl"
  ;div(class "ship-acl-form")
    ;input(type "hidden", name "ship", value <ship>, id kick-allow-input-id);
    ;button
      =event   "/click/{kick-or-allow}/{gid-str}/acl"
      =return  "/{kick-allow-input-id}/value"
      ;+  ;/  "{(cite:^title ship)} ×"
    ==
  ==
::
++  squad-members-component
  |=  [=gid =squad]
  ^-  manx
  =/  members=(list @p)  ~(tap in (~(get ju members) gid))
  ;details
    ;summary
      ;h4(class "inline"): Members ({(a-co:co (lent members))})
    ==
    ;div
      ;*  %+  turn
            %+  sort  members
            |=([a=@p b=@p] (aor (cite:^title a) (cite:^title b)))
          |=  =ship
          ^-  manx
          ;span(class "ship-members-span"): {(cite:^title ship)}
    ==
  ==
--