# Open server directory
SERVER_DIR=$(<.serverpath)
#
#
if [ ! -d "$SERVER_DIR" ]; then
  echo "Error: Directory '$SERVER_DIR' not found."
  exit 1
fi
cd "$SERVER_DIR" || { echo "Directory not found: $SERVER_DIR"; exit 1; }
#
#
# Prompt for commit message
read -p "Enter a commit message: " COMMIT_MSG
# Remove cache and add all files according to updated .gitignore
git rm -r --cached .
git add .
git commit -m "$COMMIT_MSG"

exit $?