#!/bin/bash

echo "=== Atualizando MT5-Docker para versão mais recente ==="

# Verificar se o Docker está disponível
if ! command -v docker &> /dev/null; then
    echo "Docker não está instalado. Instalando..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker $USER
    echo "Docker instalado. Por favor, faça logout e login novamente."
    exit 1
fi

# Parar e remover containers antigos
echo "Removendo containers antigos..."
docker stop ejtradermt 2>/dev/null || true
docker rm ejtradermt 2>/dev/null || true

# Remover imagem antiga
echo "Removendo imagem antiga..."
docker rmi ejtradermt 2>/dev/null || true

# Construir nova imagem
echo "Construindo nova imagem atualizada..."
docker build -t ejtradermt .

# Executar container atualizado
echo "Executando container atualizado..."
docker run --rm -dit \
    -p 5900:5900 \
    -p 15555:15555 \
    -p 15556:15556 \
    -p 15557:15557 \
    -p 15558:15558 \
    --name ejtradermt \
    -v ejtradermt:/data \
    ejtradermt

echo "=== MT5-Docker atualizado com sucesso! ==="
echo "Para conectar via VNC:"
echo "  - Host: localhost"
echo "  - Port: 5900"
echo "  - Login: root"
echo "  - Password: root"
echo ""
echo "Para acessar o shell do container:"
echo "  docker exec -it ejtradermt bash"