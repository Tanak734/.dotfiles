#!/bin/bash

case "$1" in
"main")
  walker --provider plugins:menu_principal
  ;;
"configs")
  walker --provider plugins:menu_configs
  ;;
esac
