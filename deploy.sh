#!/usr/bin/env sh

set -e
npm run build

cd dist

git init
git add  -A
git commit -m 'New Deployment'
git push -f git@https://github.com/abberh113/screen-recorder.git master:gh-pages
cd -
