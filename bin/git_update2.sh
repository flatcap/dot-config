#!/bin/bash

cd /root/system
./g pull > /dev/null

cd /etc
git push --quiet

