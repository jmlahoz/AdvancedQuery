# Get spectral slope
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

# The script calculates different measures of spectral slope, such as H1-H2, H2-H4, H4-H2K, H2K-H5K, H1-A1, H1-A2, H1-A3.
# In this script, corrected measures are appended a "c" instead of the commonly used star: thus H1*-H2* is expressed here as h1h2c.
# Values are taken at cursor, or every glottal cycle in case an interval is selected.
# These measures are commonly used to assess voice quality and glottal function (Gobl & Ní Chasaide, 2010; Hanson, 1997; Hanson & Chuang, 1999; Kreiman, Gerratt & Antoñanzas-Barroso, 2007; Kreiman, Gerratt, Garellek, Samlan, & Zhang, 2014).
# Iseli & Alwan's (2004) formula is used to compensate for the effect of the vocal tract filter and ascertain harmonic amplitudes as in the unfiltered glottal source.
# This makes unnecessary the previous application of an inverse filter.

# REFERENCES
# Gobl, C., & Ní Chasaide, A. (2010). Voice source variation and its communicative functions. In W. J. Hardcastle, J. Laver, & F. E. Gibbon (Eds.), The handbook of phonetic sciences (2nd ed., pp. 378–423). Oxford: Wiley-Blackwell.
# Hanson, H. M. (1997). Glottal characteristics of females speakers: acoustic correlates. Journal of the Acoustical Society of America, 101(1), 466–481.
# Hanson, H. M., & Chuang, E. S. (1999). Glottal characteristics of male speakers: acoustic correlates and comparison with female data. Journal of the Acoustical Society of America, 106(2), 1064–1077.
# Iseli, M., & Alwan, A. (2004). An improved correction formula for the estimation of harmonic magnitudes and its application to open quotient estimation. In Proceedings of the IEEE International Conference on Acoustics, Speech, and Signal Processing.
# Kreiman, J., Gerratt, B. R., & Antoñanzas-Barroso, N. (2007). Measures of the glottal source spectrum. Journal of Speech, Language and Hearing Research, 50(3), 595–610.
# Kreiman, J., Gerratt, B. R., Garellek, M., Samlan, R., & Zhang, Z. (2014). Toward a unified theory of voice production and perception. Loquens, 1(1), e009.

include auxiliary.praat

##{ Get time selection to analyze
selini = Get start of selection
selend = Get end of selection
issel = if (selini=selend) then 0 else 1 fi
##}

@getinfo: 1
endeditor

@getsegmentid

##{ Form
beginPause: "Get spectral slope..."
comment: "You may save results to a csv instead of having them in the info window."
boolean: "save_results_to_csv", 0
optionMenu: "get_corrected_measures", 2
option: "only uncorrected"
option: "only corrected"
option: "both uncorrected & corrected"
boolean: "get_raw_measures", 0
choice: "sex", 1
option: "male"
option: "female"
choice: "voice_register", 1
option: "modal"
option: "creak"
option: "falsetto"
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

@parsex: 'sex', 'voice_register'

##{ Write headings
results$ = ""
pulses$ = ""
if save_results_to_csv
results_name$ = data_name$ + ".csv"
result$ = chooseWriteFile$: "Save as comma-separated file...", results_name$
if result$ = ""
exit You must choose a .csv file to write results.
else
extension$ = right$(result$,4)
if extension$ != ".csv"
result$ = result$ + ".csv"
endif
filedelete 'result$'
fileappend "'result$'" data_name;time
if get_corrected_measures = 1 or get_corrected_measures = 3
fileappend "'result$'" ;h1h2;h2h4;h4h2k;h2kh5k;h1a1
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
fileappend "'result$'" ;h1h2c;h2h4c;h4h2kc;h2kh5kc;h1a1c
endif
if get_raw_measures
if get_corrected_measures = 1 or get_corrected_measures = 3
fileappend "'result$'" ;h1;h2;h4;h2k;h5k;a1
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
fileappend "'result$'" ;h1c;h2c;h4c;h2kc;a1c
endif
endif
fileappend "'result$'" 'newline$'
endif

else
clearinfo
print data_name'tab$'time
if get_corrected_measures = 1 or get_corrected_measures = 3
print 'tab$'h1h2'tab$'h2h4'tab$'h4h2k'tab$'h2kh5k'tab$'h1a1
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
print 'tab$'h1h2c'tab$'h2h4c'tab$'h4h2kc'tab$'h2kh5kc'tab$'h1a1c
endif
if get_raw_measures
if get_corrected_measures = 1 or get_corrected_measures = 3
print 'tab$'h1'tab$'h2'tab$'h4'tab$'h2k'tab$'h5k'tab$'a1
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
print 'tab$'h1c'tab$'h2c'tab$'h4c'tab$'h2kc'tab$'a1c
endif
endif
print 'newline$'

endif
##}

@selobj: 1, 0
fs = Get sampling frequency

##{ Create analysis objects
@selobj: 1, 0
pitch = noprogress To Pitch... 0 'pitch_floor' 'pitch_ceiling'
@selobj: 1, 0
@toaltfn

if results$ != ""
pulses$ = result$ - ".csv" + ".PointProcess"
endif
@selobj: 1, 0
@topulses
##}

##{ Get time window for analysis
# If there is a long enough selection, the analysis is performed on successive windows (each comprising 7 glottal cycles).
if issel = 1
select pulses
inipulse = Get high index... selini
endpulse = Get low index... selend
npulse = endpulse - inipulse + 1
if npulse < 9
issel = 0
else
for localendpulse from inipulse+7 to endpulse
localinipulse = localendpulse-7
select pulses
t1 = Get time from index... localinipulse
t2 = Get time from index... localendpulse
t = (t1+t2)/2
@this_analysis
@this_write
endfor
endif
endif ; issel = 1

# Otherwise, the analysis is performed on one single 7-cycle window, centered on t.
if issel = 0
t = (selini+selend)/2
t1 = t
t2 = t
@this_analysis
@this_write
endif ; issel = 0
##}

##{ Restore original workspace
select pitch
plus fn
plus altfn
plus pulses
nocheck plus socopy
Remove

@restorews
##}

####################

procedure this_analysis

select pitch
f0 = Get value at time... t Hertz Linear
@f0_check: f0, t1, t2, pulses
f0 = f0_check.f0

select fn
@getformants: t, segment_id$, nasal_context$

@spectral_analysis: t, f0, f1, b1, f2, b2, f3, b3
h1 = spectral_analysis.h1
h2 = spectral_analysis.h2
h4 = spectral_analysis.h4
h2k = spectral_analysis.h2k
h5k = spectral_analysis.h5k
a1 = spectral_analysis.a1

h1c = spectral_analysis.h1c
h2c = spectral_analysis.h2c
h4c = spectral_analysis.h4c
h2kc = spectral_analysis.h2kc
a1c = spectral_analysis.a1c

h1h2 = spectral_analysis.h1h2
h2h4 = spectral_analysis.h2h4
h4h2k = spectral_analysis.h4h2k
h2kh5k = spectral_analysis.h2kh5k
h1a1 = spectral_analysis.h1a1

h1h2c = spectral_analysis.h1h2c
h2h4c = spectral_analysis.h2h4c
h4h2kc = spectral_analysis.h4h2kc
h2kh5kc = spectral_analysis.h2kh5kc
h1a1c = spectral_analysis.h1a1c

endproc

procedure this_write
# Write results
if save_results_to_csv
fileappend "'result$'" 'data_name$';'t:3'
if get_corrected_measures = 1 or get_corrected_measures = 3
fileappend "'result$'" ;'h1h2:1';'h2h4:1';'h4h2k:1';'h2kh5k:1';'h1a1:1'
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
fileappend "'result$'" ;'h1h2c:1';'h2h4c:1';'h4h2kc:1';'h2kh5kc:1';'h1a1c:1'
endif
if get_raw_measures
if get_corrected_measures = 1 or get_corrected_measures = 3
fileappend "'result$'" ;'h1:1';'h2:1';'h4:1';'h2k:1';'h5k:1';'a1:1'
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
fileappend "'result$'" ;'h1c:1';'h2c:1';'h4c:1';'h2kc:1';'a1c:1'
endif
endif
fileappend "'result$'" 'newline$'

else
print 'data_name$''tab$''t:3'
if get_corrected_measures = 1 or get_corrected_measures = 3
print 'tab$''h1h2:1''tab$''h2h4:1''tab$''h4h2k:1''tab$''h2kh5k:1''tab$''h1a1:1'
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
print 'tab$''h1h2c:1''tab$''h2h4c:1''tab$''h4h2kc:1''tab$''h2kh5kc:1''tab$''h1a1c:1'
endif
if get_raw_measures
if get_corrected_measures = 1 or get_corrected_measures = 3
print 'tab$''h1:1''tab$''h2:1''tab$''h4:1''tab$''h2k:1''tab$''h5k:1''tab$''a1:1'
endif
if get_corrected_measures = 2 or get_corrected_measures = 3
print 'tab$''h1c:1''tab$''h2c:1''tab$''h4c:1''tab$''h2kc:1''tab$''a1c:1'
endif
endif
print 'newline$'

endif
endproc
