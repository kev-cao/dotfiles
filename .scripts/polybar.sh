#!/bin/bash

# Terminate all running bar instances.
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar --reload black_minimal &
done
