#!/usr/bin/env bash

enc(){

  mkdir -p ${test}/encrypted_content

  for i in $(ls);do
    if [[ ! -d $i ]]; then
      echo "Encrypting $i ...";
      openssl enc -e -aes-256-cbc -in "${path}${i}" -out "${pth}/encrypted_content/${i}.enc" -k "$pass"
    fi
  done
}


if [[ $# -eq 0 ]]; then
  read -p "Enter the folder you want to encrypt" pth
  enc;
else
  while [[ $# -ge 2 ]]; do
    a=$1
    case $a in
      "--passphrase")
        pass=$2
        shift
        ;;
      "--path")
        pth=$2
        shift
        ;;
      *) if test ! -z "$pass" && test ! -z "$pth";then enc;fi
      ;;
    esac
    shift
  done
  enc;
fi
