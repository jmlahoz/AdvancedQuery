# Get minimum
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

# This script gets the minimum amplitude value of a wave within a selection.
# This is an Editor script.

include auxiliary.praat

ini = Get start of selection
end = Get end of selection

@getinfo: 1
endeditor
@selobj: 1, 0

if ini = end
ini = 0
end = 0
endif

value = Get minimum... ini end Sinc70

select socopy
Remove

@restorews

echo 'value:4'
