#!/bin/sh

LEN=10
CNT=1

while getopts naAmuL:C: OPT
do
  case $OPT in
    "n" ) FLG_NUMBER="TRUE" ; PATTERN="${PATTERN}12345678" ;;
    "a" ) FLG_small="TRUE" ; PATTERN="${PATTERN}abcdefghijkmnpqrstuvwxyz" ;;
    "A" ) FLG_LARGE="TRUE" ; PATTERN="${PATTERN}ABCDEFGHIJKLMNPQRSTUVWXYZ" ;;
    "m" ) FLG_MINUS="TRUE" ; PATTERN="${PATTERN}\-" ;;
    "u" ) FLG_UBAR="TRUE" ; PATTERN="${PATTERN}_" ;;
    "l" ) FLG_LENGTH="TRUE" ; LEN=$OPTARG ;;
    "L" ) FLG_LENGTH="TRUE" ; LEN=$OPTARG ;;
    "C" ) FLG_COUNT="TRUE" ; CNT=$OPTARG ;;
  esac
done

if [ -z "$FLG_NUMBER" ] && [ -z "$FLG_small" ] && [ -z "$FLG_LARGE" ] ; then
  echo "下記を最低１つ指定してください。"
  echo "[-n] 数字"
  echo "[-a] 英小文字"
  echo "[-A] 英大文字"
else
  if [ -n "$FLG_MINUS" ] && [ -n "$FLG_UBAR" ] ; then
    CONTAIN="\-_"
  elif [ -n "$FLG_UBAR" ] ; then
    CONTAIN="_"
  elif [ -n "$FLG_MINUS" ] ; then
    CONTAIN="\-"
  elif [ -n "$FLG_NUMBER" ] ; then
    CONTAIN="12345678"
  else
    CONTAIN="abcdefghijkmnpqrstuvwxyz"
  fi

  cat /dev/urandom | LC_CTYPE=C tr -dc ${PATTERN} | fold -w ${LEN} | grep -i "[${CONTAIN}]" | grep -e '^[12345678abcdefghijkmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ]' | head -n ${CNT}
fi
