#!/bin/bash

tmp_var="`pgrep -u $(whoami) $1`"; kill -s 9 $tmp_var &> /dev/null; unset tmp_var

