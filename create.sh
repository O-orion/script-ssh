#!/usr/bin/env bash
# create.sh — cria chave ed25519 com prefixo fixo "id_ed25519_" e imprime a pública
# Uso: ./create.sh <nome_da_chave> <email> [--nopass] [--force]
# Exemplo:
#   ./create.sh turma02 meu@email
#   ./create.sh turma02 --nopass  # Sem passphrase
#   ./create.sh turma02 --force  # Sobrescreve chave existente

set -euo pipefail


KEY_SUFFIX="${1:-}"

EMAIL="${2:-}"

NOPASS=false
FORCE=false


if [[ -z "$KEY_SUFFIX" ]]; then
  echo "ERRO: informe o nome da chave (ex: turma02)"
  exit 1
fi

# Detecta flags
for arg in "${@:3}"; do
  case "$arg" in
    --nopass) NOPASS=true ;;
    --force) FORCE=true ;;
    *) EMAIL="$arg" ;;
  esac
done


EMAIL="${EMAIL:-$USER@$(hostname)}"

# Prefixo fixo
KEY_BN="id_ed25519_$KEY_SUFFIX"

SSH_DIR="$HOME/.ssh"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

PRIVATE="$SSH_DIR/$KEY_BN"
PUBLIC="$PRIVATE.pub"

if [[ -e "$PRIVATE" || -e "$PUBLIC" ]]; then
  if ! $FORCE ; then
    echo "ERRO: $PRIVATE ou $PUBLIC já existem. Use --force para sobrescrever."
    exit 1
  else
    echo "Aviso: sobrescrevendo $PRIVATE e $PUBLIC"
    rm -f "$PRIVATE" "$PUBLIC"
  fi
fi


if $NOPASS; then
  ssh-keygen -t ed25519 -f "$PRIVATE" -C "$EMAIL" -N ""
else
  ssh-keygen -t ed25519 -f "$PRIVATE" -C "$EMAIL"
fi

chmod 600 "$PRIVATE" || true
chmod 644 "$PUBLIC" || true

echo
echo "Chave criada: $PRIVATE"
echo
echo "----- CHAVE PÚBLICA ($PUBLIC) -----"
cat "$PUBLIC"
echo "-----------------------------------"
echo
echo "Para carregar e testar: ./load.sh \"$PRIVATE\" [user@host]"