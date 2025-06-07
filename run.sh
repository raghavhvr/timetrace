#!/bin/bash
MAX_WEEKS=104

rm -rf .git
git init

cat <<EOF > README.md
# Time Traveler

Want to improve your GitHub vanity metrics?
Run \`run.sh\`.
It will create one commit per week for the last $MAX_WEEKS weeks.

## Commits for the last $MAX_WEEKS weeks:
EOF

git add .
git commit --date "now" -m "Initial commit"

# Loop from oldest week to most recent
weeks=$(seq $MAX_WEEKS | tac)
for week in $weeks; do
    # Pick a random day within the week
    days_ago=$((week * 7 + RANDOM % 7))
    date="$days_ago days ago"
    message="Weekly new commit $date"
    echo "- Added new commit $message" >> README.md
    git add .
    git commit --date "$date" -m "$message"
done

git log --oneline | tac

cat <<EOF

# Now push to GitHub with something like...

git remote add origin https://github.com/raghavhvr/timetrace/.git/
git branch -M main
git push -u origin main
EOF