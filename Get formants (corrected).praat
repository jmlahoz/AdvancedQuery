# Get formants (corrected)
# José María Lahoz-Bengoechea (jmlahoz@ucm.es)
# Version 2022-07-01

# LICENSE
# (C) 2022 José María Lahoz-Bengoechea
# This file is part of the plugin_AdvancedQuery.
# This is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License
# as published by the Free Software Foundation
# either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# For more details, you can find the GNU General Public License here:
# http://www.gnu.org/licenses/gpl-3.0.en.html
# This file runs on Praat, a software developed by Paul Boersma
# and David Weenink at University of Amsterdam.

# This is an Editor script.

# The script calculates formants (F1-F3), bandwidths (B1-B3) and amplitudes (A1-A3).
# It invokes an algorithm of formant correction in case of atypical values.

include auxiliary.praat

@getinfo: 1

##{ Get time of analysis
ini = Get start of selection
end = Get end of selection
t = (ini+end)/2
t1 = t - 0.100
t2 = t + 0.100
if t1 < editor_start
t1 = editor_start
endif
if t2 > editor_end
t2 = editor_end
endif
##}

endeditor

@getsegmentid

##{ Form
beginPause: "Get formants (corrected)..."
choice: "sex", 1
option: "male"
option: "female"
if data_type$ = "Sound" or phonesTID = 0
comment: "It is not necessary to indicate the segment identity (eg. i) and whether or not it is next to a nasal,"
comment: "but it may help to calculate formant values in some problematic cases."
word: "segment_id", ""
optionMenu: "nasal_context", 1
option: "no"
option: "yes"
endif
endPause: "OK", 1
##}

@parsex: 'sex', 1

##{ Create analysis objects
@selobj: 1, 0
sopart = Extract part... t1 t2 rectangular 1 yes
pitch = noprogress To Pitch... 0 'pitch_floor' 'pitch_ceiling'
select sopart
@toaltfn
select sopart
@topulses
##}

##{ Analysis
select pitch
f0 = Get value at time... t Hertz Linear

select sopart
fs = Get sampling frequency
select fn
@getformants: t, segment_id$, nasal_context$

@spectral_analysis: t, f0, f1, b1, f2, b2, f3, b3
a1 = spectral_analysis.a1
a2 = spectral_analysis.a2
a3 = spectral_analysis.a3
##}

##{ Restore original workspace
select pitch
plus fn
plus altfn
plus pulses
nocheck plus socopy
plus sopart
Remove

@restorews
##}

##{ Write results
echo t='t:3''tab$'1'tab$'2'tab$'3
... 'newline$'F'tab$''tab$''f1:0''tab$''f2:0''tab$''f3:0''tab$'(Hz)
... 'newline$'B'tab$''tab$''b1:0''tab$''b2:0''tab$''b3:0''tab$'(Hz)
... 'newline$'A'tab$''tab$''a1:0''tab$''a2:0''tab$''a3:0''tab$'(dB)
##}
