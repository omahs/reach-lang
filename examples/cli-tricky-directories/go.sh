#!/usr/bin/env bash
set -e

ROOT="$1"
TOUT="$2"

g () {
  printf '\e[0;31m$ \e[1;31mreach %s\e[0m:\n' "$*"
  "$ROOT"/reach "$@"
  echo
}

r="$(find "$3" -name index.rsh | head -n1)"
if [ ! -f "$r" ]; then
  echo "Couldn't find index.rsh file under \"$3\" directory."
  exit 1
fi
x="$(dirname "$r")"

g compile --intermediate-files "$r" main
g clean   "$x" main
g compile --install-pkgs "$r" main --intermediate-files --verify-timeout=2222
g compile "$r" main

(cd "$x" || exit 1
 g scaffold
 if [ -f ./CNAME ]; then
   n="$(grep '"name":[[:space:]]"@reach-sh/' < package.json \
     | sed 's/^[[:space:]]*"name":[[:space:]]*"@reach-sh\///' \
     | sed 's/".*$//')"
   if [ ! "$(cat ./CNAME)" = "$n" ]; then
     printf 'Failed package.json name expectation: \e[0;31m%s\e[0m instead of %s.' "$n" "$(cat ./CNAME)"
     exit 1
   fi
 fi
 g unscaffold)

b="$TOUT/$x"
mkdir -p "$b"

# shellcheck disable=2010
if [ "$REACH_DOCKER" = 0 ] && ls -l "$(command -v goal)" | grep -qe "-> $ROOT/scripts/goal-devnet"; then
  echo "Skipping robust -o|--output[=]-handling since <repo>/scripts/goal-devnet's volume-mapping won't work here."
  echo "Make sure to re-test with \`REACH_DOCKER\` != 0."
else
  printf '\e[1;31mEnsure robust -o|--output[=]-handling... \e[0m'
  set +e
  o="$("$ROOT"/reach compile --intermediate-files "$r" main --output="/foo/bar/$b" 2>&1)"
  set -e
  [ "$o" = "-o|--output must be a relative subdirectory of $(pwd)." ] || (printf '\n%s' "$o"; exit 1)
  printf 'Done.'

  g compile --intermediate-files "$(printf ''%s'' "$r")" main --output="$(printf ''%s'' "${b#"$(pwd)"/}")"
fi
echo
