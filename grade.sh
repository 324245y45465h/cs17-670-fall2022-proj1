#!/bin/bash

T=/tmp/$USER/cs17670/$STUDENT/proj1-test/

mkdir -p $T

if [ $# = 0 ]; then
    TESTS=$(ls tests/*.wasm)
else
    TESTS=$@
fi

# strips comments and converts all blanks to newlines
function tokenize {
    sed '-es/;.*//g' $1 | tr '\n' ' ' | sed '-es/[[:blank:]][[:blank:]]*/\n/g' 
}

# substitute for the "timeout" command on MacOS
function xtimeout {
  timeout=$1
  shift
  command=("$@")
  (
    "${command[@]}" &
    runnerpid=$!
    trap -- '' SIGTERM
    ( # killer job
      sleep $timeout
      if ps -p $runnerpid > /dev/null; then
        kill -SIGKILL $runnerpid 2>/dev/null
      fi
    ) &
    killerpid=$!
    wait $runnerpid
    kill -SIGKILL $killerpid
  )
}

for f in $TESTS; do
    t=${f/\//_}
    e=${f/%.wasm/.expect}
    printf "##+%s\n" $t
    RAW=$T/$t.raw
    OUT=$T/$t.out
    ERR=$T/$t.err
    EXP=$T/$t.expect
    
    xtimeout 5s ./weedis $f > $RAW 2>$ERR
    tokenize $RAW > $OUT
    tokenize $e > $EXP
    diff $OUT $EXP
    if [ $? = 0 ]; then
	printf "##-ok\n"
    else
	printf "##-fail\n"
    fi
done
