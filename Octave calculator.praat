# Octave calculator
# José María Lahoz-Bengoechea (jmlahoz@ucm.es)
# Version 2021-10-07

# LICENSE
# (C) 2021 José María Lahoz-Bengoechea
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

# This script gives the distance in octaves (and semitones) between two frequencies.
# Alternatively, it gives a frequency that is X octaves apart from another frequency.

form Octave calculator...
comment Frequency 1 is required. Then either frequency 2 or octave jump are required.
comment Octave jump can be positive or negative.
positive frequency_1 
positive frequency_2 1
real octave_jump 0
endform

clearinfo

if octave_jump = 0
	octaves = log2 (frequency_2 / frequency_1)
	semitones = 12*octaves
	if octaves != 1
		printline There is a jump of 'octaves:2' octaves ('semitones' st) from 'frequency_1' Hz to 'frequency_2' Hz
	else
		printline There is a jump of 'octaves' octave ('semitones' st) from 'frequency_1' Hz to 'frequency_2' Hz
	endif
else
	frequency_2 = frequency_1 * (2^octave_jump)
	cents = 12*octave_jump
	if octave_jump >= 0
		if octave_jump != 1
			printline The frequency 'frequency_2:1' Hz is 'octave_jump:2' octaves ('semitones' st) above 'frequency_1' Hz
		else
			printline The frequency 'frequency_2:1' Hz is 'octave_jump' octave ('semitones' st) above 'frequency_1' Hz
		endif
	else
		octave_jump = abs(octave_jump)
		if octave_jump != 1
			printline The frequency 'frequency_2:1' Hz is 'octave_jump:2' octaves ('semitones' st) below 'frequency_1' Hz
		else
			printline The frequency 'frequency_2:1' Hz is 'octave_jump' octave ('semitones' st) below 'frequency_1' Hz
		endif
	endif
endif

printline  
printline Remember: an octave is the interval between two frequencies such that the second doubles (in Hz) the first one.
printline octaves = log2 (frequency_2 / frequency_1)
printline frequency_2 = frequency_1 * (2^octaves)
printline  
printline An octave equals 12 semitones (st). Below is the equivalence between semitones and intervals.
printline  
printline St'tab$'Interval
printline 0'tab$'Unison
printline 1'tab$'Semitone or minor second
printline 2'tab$'Whole tone or major second
printline 3'tab$'Minor third
printline 4'tab$'Major third
printline 5'tab$'Perfect fourth
printline 6'tab$'Augmented fourth / Diminished fifth
printline 7'tab$'Perfect fifth
printline 8'tab$'Minor sixth
printline 9'tab$'Major sixth
printline 10'tab$'Minor seventh
printline 11'tab$'Major seventh
printline 12'tab$'Octave
