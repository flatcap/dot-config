#!/bin/bash

cd /home

chown -R  flatcap.flatcap flatcap
chown -R  example.src     example
chown -R     work.src     work

chmod -R g+rwX example
chmod -R g+rwX work

chcon -R system_u:object_r:public_content_t:s0 example
chcon -R system_u:object_r:public_content_t:s0 work

