#!/bin/bash
set -x
if [ $TRAVIS_BRANCH == 'master' ] ; then
    echo "deploying"
else
    echo "Not deploying, since this branch isn't master."
fi
