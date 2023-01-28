include auxiliary.praat

##{ Form
form Get rhythm metrics...
boolean vowels 1
sentence vowels a e i o u i\nv u\nv
boolean sonorants 0
sentence sonorants m n \nj l \fh r
boolean voiced 0
sentence voiced \bf\TV \dh\TV \jc\Tv \gf\Tv
boolean other 0
sentence other 
word tier phones
endform
##}

##{ Create arrays of targets
if vowels | sonorants | voiced
strvowel = Create Strings as tokens: vowels$, " "
nvowel = Get number of strings
endif

if sonorants | voiced
str = Create Strings as tokens: sonorants$, " "
select strvowel
plus str
strsonorant = Append
nsonorant = Get number of strings
select str
Remove
endif

if voiced
str = Create Strings as tokens: voiced$, " "
select strsonorant
plus str
strvoiced = Append
nvoiced = Get number of strings
select str
Remove
endif

if other
strother = Create Strings as tokens: other$, " "
nother = Get number of strings
endif
##}

editor
@getinfo: 0
endeditor
@selobj: 0, 1
@findtierbyname: tier$, 1, 1
tierTID = findtierbyname.return
nint = Get number of intervals... tierTID

if vowels
@getmetrics: strvowel, nvowel
endif

procedure getmetrics .strtarget .ntarget

.ntargetseq = 0
.nnontargetseq = 0
.istarget = -1
.durtarget = 0
.durnontarget = 0

for .int from 1 to nint
select tierTID
.lab$ = Get label of interval... tierTID .int

if .lab$ = "" or .lab$ = " " or .lab$ = "#"
.istarget = -1
if .durtarget != 0
.ntargetseq = .ntargetseq + 1
.durtargetseq [.ntargetseq] = .durtarget
.durtarget = 0
endif
if .durnontarget != 0
.nnontargetseq = .nnontargetseq + 1
.durnontargetseq [.nnontargetseq] = .durnontarget
.durnontarget = 0
endif
goto nextint
endif

.ini = Get start time of interval... tierTID .int
.end = Get end time of interval... tierTID .int
.dur = .end - .ini

for .itarget from 1 to .ntarget
select .strtarget
.target$ = Get string... .itarget

if .lab$ = .target$ and .istarget = 0
.istarget = 1
.nnontargetseq = .nnontargetseq + 1
.durnontargetseq [.nnontargetseq] = .durnontarget
.durnontarget = 0
.durtarget = .durtarget + .dur
goto nextint
endif

if .lab$ = .target$ and .istarget = 1
.durtarget = .durtarget + .dur
goto nextint
endif

endfor ; to .ntarget

# .lab$ != .target$
if .istarget = 1
.istarget = 0
.ntargetseq = .ntargetseq + 1
.durtargetseq [.ntargetseq] = .durtarget
.durtarget = 0
.durnontarget = .durnontarget + .dur
endif

if .istarget = 0
.durnontarget = .durnontarget + .dur
endif

label nextint
endfor ; to nint

for .itargetseq from 1 to .ntargetseq - 1

endfor

endproc
