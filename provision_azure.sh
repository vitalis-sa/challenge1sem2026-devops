#!/usr/bin/env bash
set -euo pipefail

# =========================================================
# Checkpoint FIAP - Provisionamento de infraestrutura na Azure
# Este script cria Resource Group, VM Ubuntu e configura portas/softwares.
# =========================================================

# -----------------------------
# Variáveis de configuração
# -----------------------------
RESOURCE_GROUP="rg-fiap-devops-challange3sem2026"
LOCATION="canadacentral"
VM_NAME="vm-fiap-devops-java-oracle-challange3sem2026"
VM_SIZE="Standard_B2ls_v2"
ADMIN_USER="azureuser"
IMAGE="Ubuntu2204"

# -----------------------------
# 1) Criação do Resource Group
# -----------------------------
echo "[1/5] Criando Resource Group em ${LOCATION}..."
az group create \
  --name "${RESOURCE_GROUP}" \
  --location "${LOCATION}"

# -----------------------------
# 2) Criação da VM Ubuntu
# -----------------------------
echo "[2/5] Criando VM ${VM_NAME} com size ${VM_SIZE}..."
az vm create \
  --resource-group "${RESOURCE_GROUP}" \
  --name "${VM_NAME}" \
  --image "${IMAGE}" \
  --size "${VM_SIZE}" \
  --admin-username "${ADMIN_USER}" \
  --generate-ssh-keys \
  --public-ip-sku Standard

# ----------------------------------------------------------
# 3) Descoberta do NSG vinculado à VM
# ----------------------------------------------------------
echo "[3/5] Identificando NSG vinculado à VM..."
NIC_ID=$(az vm show \
  --resource-group "${RESOURCE_GROUP}" \
  --name "${VM_NAME}" \
  --show-details \
  --query "networkProfile.networkInterfaces[0].id" \
  -o tsv)

NSG_ID=$(az network nic show \
  --ids "${NIC_ID}" \
  --query "networkSecurityGroup.id" \
  -o tsv)

NSG_NAME=$(basename "${NSG_ID}")

# ----------------------------------------------------------
# 4) Abertura EXCLUSIVA da porta 8080 (API)
# ----------------------------------------------------------
echo "[4/5] Criando regra de entrada APENAS para porta 8080 (API)..."
az network nsg rule create \
  --resource-group "${RESOURCE_GROUP}" \
  --nsg-name "${NSG_NAME}" \
  --name "allow-8080-api" \
  --priority 1010 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-ranges 8080

# -----------------------------------------------------------------
# 5) Instalação Blindada via Repositório Oficial do Docker
# -----------------------------------------------------------------
echo "[5/5] Instalando Docker Oficial na VM via run-command..."
az vm run-command invoke \
  --resource-group "${RESOURCE_GROUP}" \
  --name "${VM_NAME}" \
  --command-id RunShellScript \
  --scripts "
set -e
export DEBIAN_FRONTEND=noninteractive

# Aguarda pacientemente qualquer processo de boot do Ubuntu
while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 || sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do 
  echo 'Aguardando liberação do apt-get pelo SO...'
  sleep 10
done

# Instala pré-requisitos e adiciona a chave GPG oficial do Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl git nano
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adiciona o repositório oficial na lista do apt
echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \$(. /etc/os-release && echo \"\$VERSION_CODENAME\") stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instala o Docker CE e o plugin do Compose V2
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker

# Permissão do usuário
sudo groupadd docker || true
sudo usermod -aG docker ${ADMIN_USER}
"

# -----------------------------
# Finalização
# -----------------------------
echo "========================================================="
echo "Provisionamento concluído com sucesso e Docker instalado!"
echo "Acesse a VM com: ssh ${ADMIN_USER}@$(az vm show -d -g ${RESOURCE_GROUP} -n ${VM_NAME} --query publicIps -o tsv)"
echo "========================================================="