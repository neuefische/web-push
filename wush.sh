
# Handle user inputs
cohort_id=$1
session=$2


# Interactive mode if no cohort id is provided
if [ $# -lt 1 ]; then
  echo -n "Enter cohort id (hh-test-24-1): "
  read cohort_id
fi

if [ "$cohort_id" = "" ]; then
  echo "Error: You must provide a cohort id."
  exit 1
fi


# Interactive mode if no session name is provided
if [ $# -lt 2 ]; then
  echo -n "Enter session name (shell-basics):"
  read session
fi

if [ $session = '' ]; then
  echo "Error: You must provide a session name."
  exit 1
fi


# Check if current folder is a git repository
if [ ! -d ".git" ]; then
  echo "This directory is not a git repository. Initialize one? [Y/n]: "
  read git_init

  if ["$git_init" = 'n' || "$git_init" = 'no']; then
    echo "Error: This command needs to be executed in a git repository you want to upload."
    exit 1
  fi

  git init
fi


# Let user check for spelling mistakes
echo -n "A new remote repository '$cohort_id-$session' will be created. Proceed? [Y/n]: "
read continue

if [[ "$continue" = "n" || "$continue" = "no" ]]; then
  echo "Abort..."
  exit 0
fi

exit 0

# Commit everything and upload the repository
git add . && git commit -m "initial commit"
gh repo create -s=. --push --public --remote=origin neuefische-web-demos/"$cohort_id"-"$session"

if [ $? -eq 0 ]; then
  echo -e "\e[32mRepository created: https://github.com/neuefische-web-demos/$1\e[0m"
else
  echo -e "\e[31mFailed to create repository. Please check if 'gh' command is installed.\e[0m"
fi
