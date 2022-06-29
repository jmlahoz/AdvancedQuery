# Get jitter & shimmer (Objects)
# José María Lahoz-Bengoechea (jmlahoz@ucm.es)
# Version 2022-06-22

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

# This script calculates jitter & shimmer for a whole sound or a certain stretch of time.
# This is an Objects script.

form Get jitter & shimmer...
real left_time_range 0.0
real right_time_range 0.0 (=all)
choice sex 1
button male
button female
choice vocal_register 1
button modal
button creak
button falsetto
endform

include auxiliary.praat

@parsex: 'sex', 1

so = selected("Sound")
noprogress To Pitch (cc)... 0 'pitch_floor' 15 no 0.03 0.45 0.01 0.35 0.14 'pitch_ceiling'
pitch = selected("Pitch")
plus so
noprogress To PointProcess (cc)
pulses = selected("PointProcess")

jitter = Get jitter (local)... 'left_time_range' 'right_time_range' 0.0001 0.02 1.3
plus so
shimmer = Get shimmer (local)... 'left_time_range' 'right_time_range' 0.0001 0.02 1.3 1.6

select pitch
plus pulses
Remove

select so

echo Jitter  = 'jitter:3'%'tab$''tab$'Threshold for pathology = 1.040%
... 'newline$'Shimmer = 'shimmer:3'%'tab$''tab$'Threshold for pathology = 3.810%