#! /bin/bash

# CLI ARGS
# FIRST ARG: bacon.yourdomain.com
# SECOND ARG: num minutes to check for connectivity on each Bacon port
fqdn=$1
check_timer=$2

# Bacon Ports
declare -a port_array=("4505" "4506" "4507" "4508")


# Do all for listed ports
for val in "${port_array[@]}"; do
  count=0
  success=0
  failed=0
  
  # Define data collection file
  tmpfile=/tmp/port_check_outfile_$val.tmp
  echo "" > $tmpfile
  echo starting scan on port $val
  
  # Set timer val
  end=$((SECONDS+($check_timer*60)))
  
  # Loop through timer
  while [ $SECONDS -lt $end ]; do
  
    # NetCat call to detect port access
    # NetCat output pushed to file because output bounces between STDOUT and STDERR
    nc -vz $fqdn $val -w 2  &>> $tmpfile
    count=$((count+1))
  done
  
  # Get Stat Counts
  num_failed=$(grep -o -i failed $tmpfile | wc -l)
  num_timedout=$(grep -o -i "timed out" $tmpfile | wc -l)
  num_timedout=$((num_timedout-num_failed))
  num_passed=$(grep -o -i succeeded $tmpfile | wc -l)
  
  # Echo Final Results per Port
  echo "Port Connectivity Results: Succeeded: ($num_passed/$count). Timed out: ($num_timedout/$count). Failed: ($num_failed/$count)."
  
  # delete the tmp output file
  rm -f $tmpfile
done
