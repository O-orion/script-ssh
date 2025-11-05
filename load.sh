if ! pgrep -x "ssh-agent" > /dev/null; then
  echo "Iniciando o ssh-agent..."
  eval "$(ssh-agent -s)"
else
  echo "ssh-agent já está em execução."
fi

if [ -z "$1" ]; then
  echo "Erro: você precisa fornecer o caminho para a chave privada."
  echo "Uso: ./load.sh /caminho/para/sua/chave"
  exit 1
fi

KEY_PATH="$1"
echo "Adicionando chave ao agente: $KEY_PATH"
ssh-add "$KEY_PATH"

echo "Testando conexão SSH para GitHub..."
ssh -T git@github.com
