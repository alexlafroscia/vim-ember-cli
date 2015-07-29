#/bin/bash

cd '../test-app/node_modules/ember-cli/blueprints'
for d in */; do
  cd ${d}
  rm -rf *
  touch .gitkeep
  cd ..
done
