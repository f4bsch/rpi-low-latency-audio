#!/bin/bash
#
#   util.sh - general utility functions
#
#   Copyright (c) 2006-2016 Pacman Development Team <pacman-dev@archlinux.org>
#   Copyright (c) 2002-2006 by Judd Vinet <jvinet@zeroflux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

[[ -n "$LIBMAKEPKG_UTIL_UTIL_SH" ]] && return
LIBMAKEPKG_UTIL_UTIL_SH=1


##
#  usage : in_array( $needle, $haystack )
# return : 0 - found
#          1 - not found
##
in_array() {
	local needle=$1; shift
	local item
	for item in "$@"; do
		[[ $item = "$needle" ]] && return 0 # Found
	done
	return 1 # Not Found
}

# Canonicalize a directory path if it exists
canonicalize_path() {
	local path="$1";

	if [[ -d $path ]]; then
		(
			cd_safe "$path"
			pwd -P
		)
	else
		printf "%s\n" "$path"
	fi
}

dir_is_empty() {
	(
		shopt -s dotglob nullglob
		files=("$1"/*)
		(( ${#files} == 0 ))
	)
}

cd_safe() {
	if ! cd "$1"; then
		error "$(gettext "Failed to change to directory %s")" "$1"
		plain "$(gettext "Aborting...")"
		exit 1
	fi
}
