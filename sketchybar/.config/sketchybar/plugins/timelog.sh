#!/bin/sh

WHITE="0xffffffff"
FLAMINGO="0xFFf2cdcd"
BASE="0xe61e1e2e"
SURFACE="0x9c623b20"
TIMELOG_DIR="${TIMELOG_DIR:-$HOME/Public/Timeclock}"

DATA=$(grep -E "^[io]" $TIMELOG_DIR/current.timeclock | tail -1 | grep "^i")

if [ "$DATA" == "" ]; then
  sketchybar --set timelog \
    label.drawing=off \
    icon.drawing=off
  exit 0
fi

# Extract time and project info
START_TIME=$(echo "$DATA" | awk '{print $3}' | cut -d: -f1,2)
PROJECT=$(echo "$DATA" | awk '{print $4}')

# Calculate duration
START_SECONDS=$(date -jf "%Y-%m-%d %H:%M:%S" "$(echo $DATA | awk '{print $2, $3}')" +%s 2>/dev/null)
CURRENT_SECONDS=$(date +%s)
DURATION_SECONDS=$((CURRENT_SECONDS - START_SECONDS))
HOURS=$((DURATION_SECONDS / 3600))
MINUTES=$(((DURATION_SECONDS % 3600) / 60))

if [ $HOURS -gt 0 ]; then
  DURATION="${HOURS}h ${MINUTES}m"
else
  DURATION="${MINUTES}m"
fi

sketchybar --set timelog \
  label.drawing=on \
  icon.drawing=on \
  icon="$DURATION" \
  icon.background.height=26 \
  icon.background.color=$FLAMINGO \
  icon.font.size=14.0 \
  icon.padding_right=8 \
  icon.padding_left=8 \
  icon.color=$BASE \
  icon.background.corner_radius=2 \
  label.background.corner_radius=2 \
  label.background.height=24 \
  label="$PROJECT" \
  label.padding_left=8 \
  label.padding_right=8 \
  label.background.color=$SURFACE \
  label.color=$WHITE
