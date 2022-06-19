# Get cursor (min-sec)
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

# This script gives the cursor position in minutes:seconds.
# This is an Editor script.

t = Get cursor

t_min = floor(t/60)
t_sec = floor(t-(t_min*60))

t_min$ = string$(t_min)

if t_sec < 10
t_sec$ = "0" + string$(t_sec)
else
t_sec$ = string$(t_sec)
endif

echo 't_min$':'t_sec$'