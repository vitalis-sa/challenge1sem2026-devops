# PetHub - API Veterinária 🐾

O **PetHub** é uma solução backend (API RESTful) desenvolvida em **Java (Spring Boot 3.4+)** projetada para centralizar o ecossistema de clínicas veterinárias, tutores, pets, agendamentos de consultas, diagnósticos e integrações com dispositivos wearable (IoT) para monitoramento em tempo real da saúde dos pets.

Este repositório também foi **conteinerizado e estruturado** para atender aos requisitos da disciplina **DevOps Tools & Cloud Computing**.

---

## 👥 Equipe e Links Importantes

| RM | Nome Completo | Turma |
|:---:|:---|:---:|
| RMXXXXXX | [Insira seu Nome Aqui] | [Insira sua Turma Aqui] |
| RMXXXXXX | [Insira o Nome Aqui] | [Insira sua Turma Aqui] |

- **Link para o Repositório GitHub**: [Cole o link aqui]
- **Link para o Vídeo no YouTube**: [Cole o link aqui]

---

## 🚀 Benefícios para o Negócio

1. **Centralização do Histórico Clínico**: Facilita o acesso rápido e unificado aos registros de saúde do pet, evitando perda de informações entre diferentes clínicas e veterinários.
2. **Prevenção e Monitoramento (IoT)**: Com a leitura de dados de wearables, os veterinários podem acompanhar métricas vitais de forma contínua, permitindo ações preventivas mais precisas.
3. **Escalabilidade em Nuvem**: A arquitetura provisionada em nuvem permite que o negócio escale rapidamente conforme o aumento da base de tutores e pets.
4. **Resiliência e Portabilidade**: O uso de containers Docker garante que a aplicação execute de forma idêntica tanto no ambiente local do desenvolvedor quanto no servidor de produção, minimizando falhas de deploy.

---

## 🏗️ Arquitetura Macro da Solução (Nuvem)

Abaixo está o diagrama macro representando a infraestrutura do PetHub quando implantada na Nuvem (Azure), de acordo com os requisitos de DevOps.

![Desenho da Arquitetura Macro](./ARQUITETURA_PLACEHOLDER.jpeg)
*(Substitua o arquivo ARQUITETURA_PLACEHOLDER.jpeg na pasta raiz pelo print final do seu diagrama feito no Draw.io ou Visual Paradigm).*

---

## 💻 Instalação da Solução (How-to)

O projeto foi totalmente configurado para subir através do **Docker Compose**. Siga os passos abaixo para executar a aplicação localmente ou na sua VM na Azure.

### Pré-requisitos
- Git
- Docker e Docker Compose instalados.

### Passos para Execução:

1. **Clone este repositório:**
   ```bash
   git clone https://github.com/SEU_USUARIO/pethub-java.git
   cd pethub-java
   ```

2. **Configure as Variáveis de Ambiente:**
   Copie o arquivo de exemplo e edite as credenciais caso queira:
   ```bash
   cp .env.example .env
   ```

3. **Inicie os Contêineres em Background (Daemon):**
   Execute o comando abaixo na raiz do projeto. Ele vai realizar o build do `.jar` via Maven dentro do Docker, construir a imagem final (com usuário não-root) e iniciar o Banco de Dados Oracle.
   ```bash
   docker compose up -d --build
   ```

4. **Acompanhe os logs (Opcional):**
   ```bash
   docker compose logs -f
   ```

5. **Acesse a API:**
   Aguarde alguns instantes até que o banco de dados inicialize completamente. O status da aplicação e a documentação interativa estarão disponíveis em:
   - **Swagger Local:** `http://localhost:8080/swagger-ui.html`
   - **Swagger na Nuvem:** `http://<IP_PUBLICO_DA_SUA_VM>:8080/swagger-ui.html`

> [!TIP]
> **Teste pela Nuvem:** Se você provisionou o ambiente na Azure utilizando o nosso script `provision_azure.sh`, a porta 8080 já está aberta no NSG. Você pode testar e fazer requisições (Curl, Postman, Insomnia ou via Swagger) utilizando diretamente o IP Público da sua Máquina Virtual, demonstrando o funcionamento real em Cloud!

> [!IMPORTANT]
> **Atenção (Requisito 2 Inserts):** Para o vídeo de entrega, utilize ferramentas como Postman, Insomnia ou o próprio painel interativo do Swagger para **inserir pelo menos 2 registros**. Faça um `GET` em seguida para comprovar a persistência no banco de dados.

---

## 🛠️ Artefatos DevOps Entregues

Para fins de avaliação da disciplina de DevOps, este repositório conta com:

- [**provision_azure.sh**](./provision_azure.sh): Script do Azure CLI completo que provisiona a VM Linux, libera a porta 8080 (NSG) e executa a instalação blindada do Docker, Git e dependências necessárias de forma 100% automatizada.
- [**Dockerfile**](./Dockerfile): Responsável por criar a imagem da aplicação. Utiliza *Multi-stage build* (compila com Maven, roda com JRE enxuto). Atende ao requisito de segurança configurando a execução sob um **usuário com restrições (não-root)** (`USER springuser`, `UID 1001`).
- [**docker-compose.yml**](./docker-compose.yml): Orquestra a subida conjunta da API (Java) e do Banco de Dados conteinerizado (Oracle XE). Possui as amarrações de **Healthcheck**, redes e configura o **Volume Nomeado** (`oracle-data`) para garantir a persistência dos dados entre reinicializações.

---

## 🗺️ Rotas da API (Visão Geral)

O sistema PetHub conta com um vasto conjunto de rotas para gerenciamento do ecossistema clínico. Todas as entidades suportam as operações padrão de **CRUD** (`GET`, `POST`, `PUT`, `DELETE`). 

Abaixo está o mapeamento dos Controllers disponíveis na aplicação. Para verificar os campos exatos (JSON) necessários para cada operação, acesse o **Swagger-UI** da aplicação em execução.

| Entidade | Base Path (Endpoint) | Métodos Disponíveis |
|---|---|---|
| **Pets** | `/api/pets` | `GET`, `GET /{id}`, `GET /tutor`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Tutores** | `/api/tutores` | `GET`, `GET /{id}`, `GET /buscar`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Veterinários** | `/api/veterinarios` | `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Unidades Veterinárias** | `/api/unidades` | `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Consultas** | `/api/consultas` | `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Diagnósticos** | `/api/diagnosticos` | `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Exames** | `/api/exames` | `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Pedidos Médicos** | `/api/pedidos-medicos` | `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Vacinas e Tratamentos** | `/api/vacinas-tratamentos` | `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}` |
| **Leituras Wearable (IoT)** | `/api/leituras-wearable` | `GET`, `GET /{id}`, `POST`, `DELETE /{id}` |
