#!/bin/bash

STYLE_BOLD='\e[1m'
STYLE_COLOR_RED='\e[0;31m'
STYLE_RESET='\e[0m'

SVG_FOLDER_NAME='.svg'
D2_FILE_EXTENSION='d2'

function error_title {
  echo "${STYLE_COLOR_RED}${STYLE_BOLD}Error:${STYLE_RESET}"
}

function log_error_no_file_abspath {
  echo -e "$(error_title) File absolute path is required"
}

function log_error_wrong_file_extension {
  echo -e "$(error_title) Active file needs to have extension '${D2_FILE_EXTENSION}'"
}

function d2_watch() {
  file_abspath=$1
  if [ -z "$file_abspath" ]; then
    log_error_no_file_abspath
    exit 1
  fi

  working_directory=$(pwd)
  file_relpath=${file_abspath/#${working_directory}}
  file_relpath=${file_relpath/#\/}
  file_basename=${file_relpath//*\/}
  file_name=${file_basename/%.*}
  file_extension=${file_basename/#*.}
  folder_relpath=${file_relpath/%$file_basename}
  folder_relpath=${folder_relpath/%\/}

  svg_folder_relpath="${folder_relpath}/${SVG_FOLDER_NAME}"
  svg_file_basename="${file_name}.svg"
  svg_file_relpath="${svg_folder_relpath}/${svg_file_basename}"

  if [ "${file_extension}" != "${D2_FILE_EXTENSION}" ]; then
    log_error_wrong_file_extension
    exit 2 
  fi

  mkdir -p "${svg_folder_relpath}"

  d2 -w --theme 200 --layout elk -p 8000 --browser 0 -c "${file_abspath}" "${svg_file_relpath}"
}

d2_watch $@
