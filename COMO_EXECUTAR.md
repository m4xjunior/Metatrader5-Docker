# Como Executar a Atualização do MT5-Docker

## 🚀 Execução Rápida

Se o Docker estiver funcionando corretamente:

```bash
./EXECUTAR_ATUALIZACAO.sh
```

## 🔧 Se o Docker não estiver funcionando

### 1. Iniciar o Docker
```bash
sudo service docker start
```

### 2. Adicionar usuário ao grupo docker
```bash
sudo usermod -aG docker $USER
newgrp docker
```

### 3. Executar a atualização
```bash
./EXECUTAR_ATUALIZACAO.sh
```

## 📋 O que foi atualizado

### ✅ Problemas Corrigidos:
- **Alpine Linux**: 3.15 → 3.19 (mais recente e estável)
- **Repositórios**: Removidos repositórios antigos problemáticos
- **Wine**: Configuração automática para Windows 10
- **MetaTrader**: Permissões e inicialização corrigidas

### 🔧 Melhorias:
- Script de inicialização aprimorado
- Configuração automática do Wine
- Inicialização condicional
- Modo portable do MetaTrader

## 🌐 Conectar ao MetaTrader

Após a execução bem-sucedida:

- **VNC**: localhost:5900
- **Login**: root
- **Senha**: root

## 🛠️ Comandos Úteis

```bash
# Acessar o shell do container
docker exec -it ejtradermt bash

# Ver logs do container
docker logs ejtradermt

# Parar o container
docker stop ejtradermt

# Reiniciar o container
docker restart ejtradermt
```

## ❗ Troubleshooting

### Se o MetaTrader não iniciar:
1. Acesse o container: `docker exec -it ejtradermt bash`
2. Execute: `wine /root/Metatrader/terminal64.exe /portable`

### Se houver problemas de VNC:
1. Verifique se a porta 5900 está disponível
2. Reinicie: `docker restart ejtradermt`

### Se houver problemas de rede:
1. Verifique as portas 15555-15558
2. Configure o firewall adequadamente