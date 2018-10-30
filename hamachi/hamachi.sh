#!/bin/bash
start_daemon(){
  /opt/logmein-hamachi/hamachid -c /config
  while [ 1 ]; do
    out=$(hamachi)
    [[ $out =~ *version* ]] && sleep 1 || break
  done
}

check_login(){
  IFS=$'\n';
  regex_status="status.*?: (.*?)"
  regex_account="lmi account:(.*?)"
  for line in $(hamachi); do
    if [[ $line =~ $regex_status ]]; then
      if [[ ${BASH_REMATCH[1]} == offline ]]; then
        while [ 1 ]; do
          out=$(hamachi login)
          [[ $out =~ ok ]] && break || sleep 1
        done
      fi
    fi
  done
  while [ 1 ]; do
    out=$(hamachi)
    [[ $out =~ "loggin in" ]] && sleep 1
    [[ $out =~ "logged in" ]] && break
  done
}

check_account(){
  IFS=$'\n';
  regex_status="status.*?: (.*?)"
  regex_account="lmi account: (.*)"
  for line in $(hamachi); do
    if [[ $line =~ $regex_account ]]; then
      if [[ ${BASH_REMATCH[1]} != $ACCOUNT ]]; then
        hamachi attach $ACCOUNT
      fi
    fi
  done
}

do_join(){
    if [[ ${HAMACHI_LOGIN} && ${HAMACHI_PASSWORD} ]]; then
        echo doing join
        hamachi join $HAMACHI_LOGIN $HAMACHI_PASSWORD
    fi
}

start_daemon
check_login
check_account
do_join

while pgrep hamachid >/dev/null; do
  sleep 10
done
