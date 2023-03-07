#!/usr/bin/env bash

# Notes:
#  - Shchema: https://github.com/trufflesuite/truffle/tree/develop/packages/truffle-contract-schema
#  - bytecode vs deployedBytecode: https://ethereum.stackexchange.com/questions/32234/difference-between-bytecode-and-runtime-bytecode
for i in build/contracts/*.json;do
  [ -z "${i%%*.min.json}" ] && continue # already minified
  m=${i%%.json}.min.json
  echo "Minimizing truffle json artifact: $i"
  echo "Original size: $(wc -c "$i")"
  jq 'del(.ast,.generatedSources,.deployedGeneratedSources,.immutableReferences,.legacyAST,.source,.deployedSourceMap,.userdoc,.sourcePath,.bytecode,.deployedBytecode,.sourceMap,.metadata,.compiler,.devdoc,.schemaVersion,.updatedAt)' $i > $m
  echo "Minimized size: $(wc -c "$m")"
  # mv "$m" build/contracts 
done
