#subroutines
isYes() {
  if [[ $1 = '' || $1 = "y" || $1 = "Y" ]]; then
    echo true
  else 
    echo false
  fi
}

printError() {
  echo -e "\e[31m$1\e[0m"
}

highlightText() {
  echo -e "\e[32m$1\e[0m"
}



# Handle user inputs
cohort_id=$1
session=$2


# Interactive mode if no cohort id is provided
if [ $# -lt 1 ]; then
  echo -n "Enter cohort id (hh-test-24-1): " 
  read cohort_id
fi

if [ "$cohort_id" = "" ]; then
  echo $(printError "Error: You must provide a cohort id.")
  exit 1
fi


# Interactive mode if no session name is provided
if [ $# -lt 2 ]; then
  echo -n "Enter session name (shell-basics): "
  read session
fi

if [ "$session" = '' ]; then
  echo $(printError "Error: You must provide a session name.")
  exit 1
fi


# Check if current folder is a git repository
if [ ! -d ".git" ]; then
  echo -n "This directory is not a git repository. Initialize one? [Y/n]: "
  read git_init

  if ! $(isYes $git_init); then
    echo $(printError "Error: This command needs to be executed in a git repository you want to upload.")
    exit 1
  fi

  git init
fi


# Let user check for spelling mistakes
echo -n -e "\nA new remote repository $(highlightText "$cohort_id-$session") will be created. Proceed? [Y/n]: "
read continue

if ! $(isYes $continue); then
  echo "Abort..."
  exit 0
fi

repository_name="$cohort_id"-"$session"

# Commit everything and upload the repository
git add . && git commit -m "initial commit"
gh repo create -s=. --push --public --remote=origin neuefische-web-demos/"$repository_name"

if [ $? -eq 0 ]; then
  echo $(highligthText "Repository created: https://github.com/neuefische-web-demos/$repository_name")
else
  echo $(printError "Failed to create repository. Please check if 'gh' command is installed.")
fi

