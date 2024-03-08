#subroutines

function printError() {
  echo -e "\e[31m$1\e[0m"
}

function highlightText() {
  echo -e "\e[32m$1\e[0m"
}

function is_yes() {
  if [[ $1 = '' || $1 = "y" || $1 = "Y" ]]; then
    return 0
  else
    return 1
  fi
}

function confirm() {
  valid_options=("y" "Y" "n" "N" "")

  is_valid_option() {
    local input=$1

    for option in "${valid_options[@]}"; do
      if [[ "$input" = "$option" ]]; then
        return 0
      fi
    done
    return 1
  }

  while true; do
    read user_input
    if is_valid_option "$user_input"; then
      break
    fi
  done

  if is_yes $user_input; then
    return 0
  else
    return 1
  fi
}
