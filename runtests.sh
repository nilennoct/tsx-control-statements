#!/usr/bin/env bash

mkdir -p ./test-output

yarn && yarn build

readonly TSC_VERSIONS=(2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2)

EXIT_CODE=0
for v in ${TSC_VERSIONS[*]}; do
#	rm -rf ./node_modules/typescript
	echo "================= TESTING VERSION $v.* ======================="

	yarn upgrade typescript@$v > /dev/null

	yarn test

	CURRENT_EXIT_CODE=$?
	[[ $CURRENT_EXIT_CODE != 0 ]] && EXIT_CODE=1

	echo "Build and tests for $v.* exited with code $CURRENT_EXIT_CODE"
done

exit $EXIT_CODE
