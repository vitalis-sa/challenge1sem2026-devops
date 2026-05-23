# PetHub - API Veterinária 🐾

O **PetHub** é uma solução desenvolvida em **Java (Spring Boot 3.4+) e C#(.NET)** (para a matéria de “DEVOPS TOOLS & CLOUD COMPUTING“, apresentaremos apenas a API Java) projetada para centralizar o ecossistema de clínicas veterinárias, tutores, pets, agendamentos de consultas e diagnósticos.

Este repositório também foi **conteinerizado e estruturado** para atender aos requisitos da disciplina **DevOps Tools & Cloud Computing**.

---

## 👥 Equipe e Links Importantes

| RM | Nome Completo | Turma |
|:---:|:---|:---:|
| RM561489 | Ana Flavia Camelo | 2TDSPV |
| RM562745 | Gustavo Kenji Terada | 2TDSPV |
| RM566234 | João Guilherme Carvalho Novaes | 2TDSPV |
| RM565154 | Pedro Chasci Puga | 2TDSPV |
| RM561342 |Lucas Figueiredo Vieira | 2TDSPV |

- **Link para o Repositório GitHub**: https://github.com/vitalis-sa/challenge1sem2026-devops
- **Link para o Vídeo no YouTube**: https://www.youtube.com/watch?v=N18_M9Ll8lE

---

## 📝 Descrição do Projeto

O **PetHub** é um ecossistema digital integrado projetado para revolucionar a gestão de cuidados veterinários, conectando de forma inteligente clínicas, veterinários, tutores e os próprios pets. O coração dessa arquitetura é uma API robusta desenvolvida em **Spring Boot 3.4+**, que interage com uma base de dados relacional **Oracle Database** para centralizar informações clínicas críticas e automatizar rotinas operacionais e preventivas.

O sistema destaca-se pelas seguintes capacidades e domínios de negócio:

* **Prontuário e Histórico Clínico Unificado**: Gerenciamento completo de **Pets** (identificação, espécie, raça, idade e peso), **Tutores** (vinculados e integrados com microsserviços legados) e **Veterinários** (perfis profissionais com controle de CRMV e especialidades).
* **Gestão de Atendimento e Consultas**: Agendamento completo de consultas médicas integrando fluxos de notificação ativa para os tutores sobre datas e preparações necessárias.
* **Diagnósticos Clínicos e Inteligência Artificial**: Cadastro detalhado de consultas e diagnósticos clínicos. A API é estruturada para suportar modelos de Machine Learning e Inteligência Artificial Generativa, registrando sintomas específicos (como perda de apetite, tosse, alterações de temperatura e dificuldades respiratórias), gerando predições de patologias com níveis de confiança (`doenca_predita` e `confianca_predicao`) e armazenando análises clínicas detalhadas geradas por GenAI (`analise_gen_ai`).
* **Medicina Preventiva e Lembretes (Vacinas e Tratamentos)**: Controle de aplicação de vacinas, medicamentos e procedimentos terapêuticos, monitorando a necessidade de doses futuras e integrando-se a canais de mensageria para alertar os tutores.
* **Prescrições e Pedidos Médicos**: Registro centralizado de exames solicitados e medicamentos receitados para acompanhamento em domicílio.
* **Monitoramento Contínuo via IoT (Wearables)**: A plataforma está preparada para receber telemetria contínua vinda de coleiras ou de outros dispositivos vestíveis (*wearables*). A API processa e armazena leituras de temperatura corporal e frequência cardíaca dos animais em tempo real, disparando alertas automáticos caso sejam detectadas anomalias nos sinais vitais.

---

## 🚀 Benefícios para o Negócio

1. **Centralização do Histórico Clínico**: Facilita o acesso rápido e unificado aos registros de saúde do pet, evitando perda de informações entre diferentes clínicas e veterinários.
2. **Assistente de IA**: Nas tele consultas que serão possíveis de serem realizadas pelo nosso app, teremos um assistente que escutará a chamada e identificará sintomas, gerando um diagnóstico prévio.
3. **Notificações**: Implementaremos um sistema de notificações para notificar os tutores via Whatsapp sobre as consultas agendadas, lembretes de vacinas e tratamentos, e alertas sobre a saúde de seus pets.
---

## 🏗️ Arquitetura Macro da Solução (Nuvem)

Abaixo está o diagrama macro representando a infraestrutura do PetHub:

<img width="1482" height="981" alt="Prototype VITALIS-temp-arquitetura" src="https://github.com/user-attachments/assets/1aefb809-c3ef-43cd-8f44-0a59b1d1a248" />

## 💻 Instalação da Solução (How-to)

O projeto foi totalmente configurado para subir através do **Docker Compose**. Siga os passos abaixo para executar a aplicação localmente ou na sua VM na Azure.

### Pré-requisitos
- Git
- Docker e Docker Compose instalados.

### Passos para Execução:

1. **Clone este repositório:**
   ```bash
   git clone https://github.com/vitalis-sa/challenge1sem2026-devops.git
   cd challenge1sem2026-devops
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

Aqui está o resumo completo dos endpoints em markdown. Mantive bastante coluna — é só remover o que não usar.

### 🐾 Pets — `/api/pets`
**Tag:** Pets — Gerenciamento de pets

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/pets` | Listar pets | Lista paginada, filtrável por nome ou veterinário responsável | `nome?` (String), `veterinarioId?` (Long), `Pageable` | — | — | 200 |
| GET | `/api/pets/tutor` | Listar pets por CPF do tutor | — | `cpf` (String, req), `Pageable` | — | — | 200, 404 (Tutor) |
| GET | `/api/pets/{id}` | Buscar pet por ID | — | — | `id` (Long) | — | 200, 404 |
| POST | `/api/pets` | Cadastrar pet | Busca tutor pelo CPF e vincula ao pet | — | — | `PetRequest` | 201, 400, 404 (Tutor/Vet) |
| PUT | `/api/pets/{id}` | Atualizar pet | — | — | `id` | `PetRequest` | 200, 404 |
| DELETE | `/api/pets/{id}` | Remover pet | — | — | `id` | — | 204, 404 |

---

### 👨‍⚕️ Veterinários — `/api/veterinarios`
**Tag:** Veterinários — Gerenciamento de veterinários

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/veterinarios` | Listar veterinários | Paginada, filtrável por nome ou ativo | `nome?`, `ativo?` (Boolean), `Pageable` | — | — | 200, 400 |
| GET | `/api/veterinarios/{id}` | Buscar veterinário por ID | — | — | `id` | — | 200, 404 |
| POST | `/api/veterinarios` | Cadastrar veterinário | — | — | — | `VeterinarioRequest` | 201, 400, 409 (CRMV/email duplicado) |
| PUT | `/api/veterinarios/{id}` | Atualizar veterinário | — | — | `id` | `VeterinarioRequest` | 200, 404 |
| DELETE | `/api/veterinarios/{id}` | Remover veterinário | — | — | `id` | — | 204, 404 |

---

### 🏥 Unidades Veterinárias — `/api/unidades`
**Tag:** Unidades Veterinárias — Gerenciamento de clínicas e estabelecimentos

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/unidades` | Listar unidades | Paginada, filtrável por veterinário | `veterinarioId?`, `Pageable` | — | — | 200 |
| GET | `/api/unidades/{id}` | Buscar unidade por ID | — | — | `id` | — | 200, 404 |
| POST | `/api/unidades` | Cadastrar unidade | — | — | — | `UnidadeVeterinarioRequest` | 201, 400, 404 (Vet) |
| PUT | `/api/unidades/{id}` | Atualizar unidade | — | — | `id` | `UnidadeVeterinarioRequest` | 200, 404 |
| DELETE | `/api/unidades/{id}` | Remover unidade | — | — | `id` | — | 204, 404 |

---

### 👤 Tutores — `/api/tutores`
**Tag:** Tutores — Somente leitura (dados gerenciados pelo backend C#)

| Método | Path | Resumo | Descrição | Query Params | Body | Respostas |
|---|---|---|---|---|---|---|
| GET | `/api/tutores/buscar` | Buscar tutor por CPF | Retorna dados básicos para vinculação de pets | `cpf` (String, req, @NotBlank) | — | 200, 404 |

---

### 📅 Consultas — `/api/consultas`
**Tag:** Consultas — Gerenciamento de consultas veterinárias

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/consultas` | Listar consultas | Filtrável por petId, veterinarioId e status | `petId?`, `veterinarioId?`, `status?` (`StatusConsulta`), `Pageable` | — | — | 200 |
| GET | `/api/consultas/{id}` | Buscar consulta por ID | — | — | `id` | — | 200, 404 |
| POST | `/api/consultas` | Criar consulta | Cria e notifica o tutor via API C# | — | — | `ConsultaRequest` | 201, 400, 404 (Pet/Vet/Unidade) |
| PUT | `/api/consultas/{id}` | Atualizar consulta | — | — | `id` | `ConsultaRequest` | 200, 404 |
| DELETE | `/api/consultas/{id}` | Remover consulta | — | — | `id` | — | 204, 404 |

---

### 🩺 Diagnósticos — `/api/diagnosticos`
**Tag:** Diagnósticos — Gerados pelo veterinário durante a consulta

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/diagnosticos` | Listar diagnósticos | Filtrável por petId ou consultaId | `petId?`, `consultaId?`, `Pageable` | — | — | 200 |
| GET | `/api/diagnosticos/{id}` | Buscar diagnóstico por ID | — | — | `id` | — | 200, 404 |
| POST | `/api/diagnosticos` | Registrar diagnóstico | Vinculado a consulta. Campos ML/GenAI preenchidos pelo assistente de IA | — | — | `DiagnosticoRequest` | 201, 400, 404 |
| PUT | `/api/diagnosticos/{id}` | Atualizar diagnóstico | — | — | `id` | `DiagnosticoRequest` | 200, 404 |
| DELETE | `/api/diagnosticos/{id}` | Remover diagnóstico | — | — | `id` | — | 204, 404 |

---

### 🧪 Exames — `/api/exames`
**Tag:** Exames — Gerenciamento de exames clínicos

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/exames` | Listar exames | Filtrável por petId ou consultaId | `petId?`, `consultaId?`, `Pageable` | — | — | 200 |
| GET | `/api/exames/{id}` | Buscar exame por ID | — | — | `id` | — | 200, 404 |
| POST | `/api/exames` | Registrar exame | — | — | — | `ExameRequest` | 201, 400, 404 (Consulta/Pet) |
| PUT | `/api/exames/{id}` | Atualizar exame | — | — | `id` | `ExameRequest` | 200, 404 |
| DELETE | `/api/exames/{id}` | Remover exame | — | — | `id` | — | 204, 404 |

---

### 💉 Vacinas e Tratamentos — `/api/vacinas-tratamentos`
**Tag:** Vacinas e Tratamentos — Vacinas, medicamentos e procedimentos

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/vacinas-tratamentos` | Listar vacinas/tratamentos | Filtrável por petId e tipo | `petId?`, `tipo?` (`TipoVacinaTratamento`), `Pageable` | — | — | 200 |
| GET | `/api/vacinas-tratamentos/{id}` | Buscar por ID | — | — | `id` | — | 200, 404 |
| POST | `/api/vacinas-tratamentos` | Registrar vacina/tratamento | Se `proximaDose` preenchida, notifica tutor via API C# | — | — | `VacinaTratamentoRequest` | 201, 400, 404 (Pet/Vet/Consulta) |
| PUT | `/api/vacinas-tratamentos/{id}` | Atualizar | — | — | `id` | `VacinaTratamentoRequest` | 200, 404 |
| DELETE | `/api/vacinas-tratamentos/{id}` | Remover | — | — | `id` | — | 204, 404 |

---

### 📋 Pedidos Médicos — `/api/pedidos-medicos`
**Tag:** Pedidos Médicos — Exames solicitados e medicações para execução em casa

| Método | Path | Resumo | Descrição | Query Params | Path Params | Body | Respostas |
|---|---|---|---|---|---|---|---|
| GET | `/api/pedidos-medicos` | Listar pedidos médicos | Filtrável por petId, status, tipo. Consumido pelo app via C# | `petId?`, `status?` (`StatusPedidoMedico`), `tipo?` (`TipoPedidoMedico`), `Pageable` | — | — | 200 |
| GET | `/api/pedidos-medicos/{id}` | Buscar pedido por ID | — | — | `id` | — | 200, 404 |
| POST | `/api/pedidos-medicos` | Criar pedido médico | Notifica tutor via API C# com lembrete (EXAME ou MEDICAMENTO) | — | — | `PedidoMedicoRequest` | 201, 400, 404 (Consulta/Pet) |
| PUT | `/api/pedidos-medicos/{id}` | Atualizar pedido | — | — | `id` | `PedidoMedicoRequest` | 200, 404 |
| DELETE | `/api/pedidos-medicos/{id}` | Remover pedido | — | — | `id` | — | 204, 404 |

---
