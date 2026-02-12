function tli() {
  ENTRY=$(grep -E "^[io]" $TIMELOG_DIR/current.timeclock | tail -1 | grep "^i")
  if [ -n "$ENTRY" ]; then
    echo "Error: There is already an open entry"
    return 1
  fi

  if [ $# -eq 0 ]; then
    DESCRIPTION=$(grep -E "^i" $TIMELOG_DIR/current.timeclock | sed 's/^i [0-9-]* [0-9:]* //' | sort | uniq -c | sort -rn | sed 's/^ *[0-9]* //' | gum choose)
    if [ -z "$DESCRIPTION" ]; then
      echo "No description selected"
      return 1
    fi
  else
    DESCRIPTION="$*"
  fi

  echo "\ni" `date "+%Y-%m-%d %H:%M:%S"` $DESCRIPTION >>$TIMELOG_DIR/current.timeclock
}

function tlo() {
  ENTRY=$(grep -E "^[io]" $TIMELOG_DIR/current.timeclock | tail -1 | grep "^i")
  if [ -z "$ENTRY" ]; then
    echo "Error: There is no open entry"
    return 1
  fi

  echo "o `date "+%Y-%m-%d %H:%M:%S"`" >>$TIMELOG_DIR/current.timeclock
}

function tle() {
  nvim $TIMELOG_DIR/current.timeclock
}

function tlb() {
  hledger -f $TIMELOG_DIR/current.journal bal -D
}

function tlbm() {
  hledger -f $TIMELOG_DIR/current.journal bal -Xm -D
}

function tlp() {
  hledger -f $TIMELOG_DIR/current.journal print
}

function tlpm() {
  hledger -f $TIMELOG_DIR/current.journal print -Xm
}

function tls() {
  ENTRY=$(grep -E "^[io]" $TIMELOG_DIR/current.timeclock | tail -1 | grep "^i")

  if [ -n "$ENTRY" ]; then
    echo $ENTRY
    echo "Running"
  else
    echo "Stopped"
  fi
}
