# Get pitch range (st)
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

# This script gets the pitch range of a selection in semitones.
# This is an Editor script.

maxpitch = Get maximum pitch
minpitch = Get minimum pitch

pitchrange = (12 / log10 (2)) * log10 (maxpitch / minpitch)

echo 'pitchrange:2' semitones of pitch range