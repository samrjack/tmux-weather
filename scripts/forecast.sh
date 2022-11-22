#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_forecast() {

  # https://github.com/chubin/wttr.in#one-line-output
  local format=$(get_tmux_option @forecast-format "%C+%t+%w")

  local location=$(get_tmux_option @forecast-location "") # Let wttr.in figure out the location

  local char_limit=$(get_tmux_option @forecast-char-limit 75)

  # https://github.com/chubin/wttr.in#weather-units
  local units=$(get_tmux_option @forecast-units "") # Let wttr.in figure out the units

  local forecast=$(curl -G -d ${units} -d "format=${format}" http://wttr.in/${location})

  # Only print a temp when successful so it doesn't clog up the line with an error
  [ $? -eq 0 ] && echo ${forecast:0:$char_limit} || echo "??"
}

main() {
  print_forecast
}

main
