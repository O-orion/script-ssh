# 🔐 Gerenciando Chaves SSH com `create.sh` e `load.sh`

## 📘 Resumo
Este repositório contém dois scripts simples e didáticos para **criar**, **carregar** e **testar** chaves SSH com o GitHub.

| Script | Função Principal |
|---------|------------------|
| `create.sh` | Cria uma nova chave SSH `ed25519` com opções de senha e sobrescrita |
| `load.sh` | Carrega a chave no `ssh-agent` e testa automaticamente a conexão com o GitHub |

---

## 🧩 Estrutura dos Arquivos
create.sh → cria uma nova chave SSH
load.sh → carrega a chave no agente SSH e testa a conexão

## ⚙️ 1️⃣ Preparar o Ambiente
Antes de usar, dê permissão de execução aos scripts:

```bash
chmod +x create.sh load.sh
```

##🔑 2️⃣ Criar uma Nova Chave SSH
🧠 Sintaxe:
```bash
./create.sh <nome_da_chave> <seu_email>
```
## 🧭 Exemplos de Uso

```bash 
# Cria uma chave com senha
./create.sh turma01 meuemail@exemplo.com

# Cria sem senha
./create.sh turma01 meuemail@exemplo.com --nopass

# Sobrescreve chave existente
./create.sh turma01 meuemail@exemplo.com --force

```

Após a execução, os arquivos serão criados em ~/.ssh/
O terminal mostrará a chave pública e um lembrete para carregá-la com o load.sh.

## 🌐 3️⃣ Adicionar a Chave Pública ao GitHub

* Copie a chave pública exibida no terminal (começa com ssh-ed25519).
* Vá em GitHub → Settings → SSH and GPG keys → New SSH key.
* Cole a chave no campo Key.
* Dê um nome, ex: id_ed25519_turma01.
* Clique em Add SSH key ✅

## 🚀 4️⃣ Carregar e Testar a Chave

Use o script load.sh para carregar sua chave e verificar a conexão.

```bash
./load.sh ~/.ssh/id_ed25519_turma01
```

O script faz automaticamente:
* Inicia o ssh-agent (se necessário).
* Adiciona a chave com ssh-add.
* Testa a autenticação com o GitHub.
* Se tudo estiver certo, você verá:
  
Hi <seu_usuario>! You've successfully authenticated, but GitHub does not provide shell access.
