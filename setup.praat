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

if praatVersion >= 6215
spectrum_menu$ = "Spectrogram"
query_menu$ = "Time"
formant_menu$ = "Formants"
else
spectrum_menu$ = "Spectrum"
query_menu$ = "Query"
formant_menu$ = "Formant"
endif

Add menu command... "SoundEditor" "'spectrum_menu$'" "Get COG of selection" "View spectral slice" 0 Get COG of selection.praat
Add menu command... "TextGridEditor" "'spectrum_menu$'" "Get COG of selection" "" 0 Get COG of selection.praat
Add menu command... "SoundEditor" "'spectrum_menu$'" "Get spectral slope..." "" 0 Get spectral slope.praat
Add menu command... "TextGridEditor" "'spectrum_menu$'" "Get spectral slope..." "" 0 Get spectral slope.praat
Add menu command... "SoundEditor" "'query_menu$'" "Get cursor (min:sec)" "Get cursor" 0 Get cursor (min-sec).praat
Add menu command... "TextGridEditor" "'query_menu$'" "Get cursor (min:sec)" "Get cursor" 0 Get cursor (min-sec).praat
Add menu command... "SoundEditor" "'query_menu$'" "Get value at cursor" "Get selection length" 0 Get value at cursor.praat
Add menu command... "TextGridEditor" "'query_menu$'" "Get value at cursor" "Get selection length" 0 Get value at cursor.praat
Add menu command... "SoundEditor" "'query_menu$'" "Get maximum" "Get value at cursor" 0 Get maximum.praat
Add menu command... "TextGridEditor" "'query_menu$'" "Get maximum" "Get value at cursor" 0 Get maximum.praat
Add menu command... "SoundEditor" "'query_menu$'" "Get mean of selection" "Get minimum" 0 Get mean of selection.praat
Add menu command... "TextGridEditor" "'query_menu$'" "Get mean of selection" "Get minimum" 0 Get mean of selection.praat
Add menu command... "SoundEditor" "'query_menu$'" "Get minimum" "Get maximum" 0 Get minimum.praat
Add menu command... "TextGridEditor" "'query_menu$'" "Get minimum" "Get maximum" 0 Get minimum.praat
Add menu command... "SoundEditor" "'query_menu$'" "Get RMS amplitude of selection" "" 0 Get RMS amplitude of selection.praat
Add menu command... "TextGridEditor" "'query_menu$'" "Get RMS amplitude of selection" "" 0 Get RMS amplitude of selection.praat
Add menu command... "SoundEditor" "'formant_menu$'" "Get formant info..." "" 0 Get formant info.praat
Add menu command... "TextGridEditor" "'formant_menu$'" "Get formant info..." "" 0 Get formant info.praat
Add menu command... "SoundEditor" "Pitch" "Get pitch range (st)" "" 0 Get pitch range (st).praat
Add menu command... "TextGridEditor" "Pitch" "Get pitch range (st)" "" 0 Get pitch range (st).praat
Add menu command... "Objects" "Praat" "Octave calculator..." "Goodies" 1 Octave calculator.praat
Add menu command... "SoundEditor" "Pitch" "Octave calculator..." "" 0 Octave calculator.praat
Add menu command... "TextGridEditor" "Pitch" "Octave calculator..." "" 0 Octave calculator.praat
Add action command... Sound 1 "" 0 "" 0 "Get jitter & shimmer..." "Autocorrelate..." 1 Get jitter & shimmer (Objects).praat
Add menu command... "SoundEditor" "Pulses" "Get jitter & shimmer..." "" 0 Get jitter & shimmer.praat
Add menu command... "TextGridEditor" "Pulses" "Get jitter & shimmer..." "" 0 Get jitter & shimmer.praat
