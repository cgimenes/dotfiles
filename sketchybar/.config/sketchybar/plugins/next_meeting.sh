#!/bin/sh

WHITE="0xffffffff";
FLAMINGO="0xFFf2cdcd";
BASE="0xe61e1e2e";
SURFACE="0x9c623b20";

NEXT_MEETING_JSON=$(shortcuts run "Get Nearest Event Details" -o /dev/stdout)

TITLE=$(echo $NEXT_MEETING_JSON | jq -r '.title')
CUT_TITLE=$(echo $TITLE | cut -c1-30)

START=$(echo $NEXT_MEETING_JSON | jq -r '.start')
START_TIME=$(date -jf "%Y-%m-%dT%H:%M:%S" "${START}" +"%H:%M")
START_TIMESTAMP=$(date -jf "%Y-%m-%dT%H:%M:%S" "${START}" +%s)
NOW_TIMESTAMP=$(date +%s)
TIME_DIFF="$(($START_TIMESTAMP-$NOW_TIMESTAMP))"

echo "Start Timestamp: $START_TIMESTAMP"
echo "Now Timestamp: $NOW_TIMESTAMP"
echo "Time Diff: $TIME_DIFF"

LINK=$(echo $NEXT_MEETING_JSON | jq -r '.link')

# Nothing
if [ "$TITLE" = "" ]; then
  sketchybar --set meeting label.drawing=off icon.drawing=off
  exit 0
fi

# Event in Future
if [ $TIME_DIFF -ge 0 ]; then
  sketchybar --set meeting \
    label.drawing=on \
    icon.drawing=on \
    label="$CUT_TITLE" \
    icon="$START_TIME" \
    icon.background.height=26 \
    icon.background.color=$FLAMINGO \
    icon.font.size=14.0 \
    icon.padding_right=8 \
    icon.padding_left=8 \
    icon.color=$BASE \
    icon.background.corner_radius=2 \
    label.background.corner_radius=2 \
    label.background.height=24 \
    label.padding_left=8 \
    label.padding_right=8 \
    label.background.color=$SURFACE \
    label.color=$WHITE \
    click_script="open $LINK"
  exit 0
fi

# Ongoing Meeting
sketchybar --set meeting \
  label.drawing=on \
  icon.drawing=off \
  label="$CUT_TITLE" \
  label.padding_left=8 \
  label.color=$BASE \
  label.background.color=$FLAMINGO \
  label.background.height=24 \
  label.background.corner_radius=4 \
  label.font.size=14.0 \
  click_script="open $LINK"
