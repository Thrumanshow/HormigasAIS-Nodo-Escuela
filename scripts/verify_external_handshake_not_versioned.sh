#!/bin/sh
if git remote -v | grep -qi gitlab; then
  echo "⛔ LBH BLOQUEO: GitLab no autorizado"
  exit 1
fi
