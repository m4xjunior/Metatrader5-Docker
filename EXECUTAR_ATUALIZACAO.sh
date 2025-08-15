#!/bin/bash

echo "=== Executando Atualização do MT5-Docker ==="

# Verificar se o Docker está funcionando
if ! docker ps >/dev/null 2>&1; then
    echo "❌ Docker não está funcionando. Tente:"
    echo "   sudo service docker start"
    echo "   sudo usermod -aG docker \$USER"
    echo "   newgrp docker"
    exit 1
fi

echo "✅ Docker está funcionando!"

# Parar e remover containers antigos
echo "🔄 Removendo containers antigos..."
docker stop ejtradermt 2>/dev/null || true
docker rm ejtradermt 2>/dev/null || true

# Remover imagem antiga
echo "🔄 Removendo imagem antiga..."
docker rmi ejtradermt 2>/dev/null || true

# Construir nova imagem
echo "🔨 Construindo nova imagem atualizada..."
docker build -t ejtradermt .

if [ $? -eq 0 ]; then
    echo "✅ Imagem construída com sucesso!"
    
    # Executar container atualizado
    echo "🚀 Executando container atualizado..."
    docker run --rm -dit \
        -p 5900:5900 \
        -p 15555:15555 \
        -p 15556:15556 \
        -p 15557:15557 \
        -p 15558:15558 \
        --name ejtradermt \
        -v ejtradermt:/data \
        ejtradermt
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 MT5-Docker atualizado com sucesso!"
        echo ""
        echo "📋 Informações de conexão:"
        echo "   VNC: localhost:5900"
        echo "   Login: root"
        echo "   Senha: root"
        echo ""
        echo "🔧 Comandos úteis:"
        echo "   Acessar shell: docker exec -it ejtradermt bash"
        echo "   Ver logs: docker logs ejtradermt"
        echo "   Parar: docker stop ejtradermt"
    else
        echo "❌ Erro ao executar o container"
        exit 1
    fi
else
    echo "❌ Erro ao construir a imagem"
    exit 1
fi