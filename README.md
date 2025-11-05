# Projeto SCOM/LCON I (Equipe 2) - Guia Rápido

Este repositório armazena a API (`.php`) e o Banco de Dados (`.sql`) para coletar dados do ESP32.

## 1. O que é Necessário para o Servidor

Você precisa de um PC com XAMPP para atuar como servidor.

1.  **Clone este Repositório:** Coloque os arquivos deste projeto dentro da pasta `C:\xampp\htdocs\`.
2.  **Inicie o XAMPP:** Abra o Painel de Controle do XAMPP e inicie os serviços **Apache** e **MySQL**.
4.  **Importe o Banco de Dados:**
    * Abra `http://localhost/phpmyadmin` no navegador.
    * Clique em "Novo" (New), crie um banco de dados chamado `projetointegrador`.
    * Clique no banco `projetointegrador` (na esquerda), vá na aba "Importar".
    * Escolha o arquivo `projetointegrador.sql` (deste repositório) e clique em "Executar".

**Seu servidor está pronto.**

## 2. O que é Necessário para Coletar Dados (ESP32)

Para o ESP32 enviar dados, ele precisa "saber" o IP do seu servidor.

1.  **Descubra o IP do seu PC:**
    * Abra o **CMD** (Prompt de Comando).
    * Digite `ipconfig`.
    * Anote o **Endereço IPv4** da sua rede Wi-Fi (ex: `192.168.1.10`).
2.  **Configure o Código do ESP32 (.ino):**
    * Abra o código-fonte do ESP32.
    * Modifique estas 4 variáveis no topo do código:
    ```cpp
    const char* ssid = "NOME_DA_SUA_REDE_WIFI";
    const char* password = "SENHA_DA_SUA_REDE_WIFI";
    const char* serverIp = "192.168.1.10"; // <-- SEU IP AQUI
    const int MINHA_MALHA_ID = 1;          // 1 para Tanque 1, 2 para Tanque 2
    ```
3.  **Faça o Upload:** Envie o código para o ESP32.

## 3. Como Visualizar os Dados

1.  Com o ESP32 rodando, abra o **Serial Monitor** (115200 baud) para ver os logs de "POST".
2.  No seu PC, abra o **phpMyAdmin** no navegador:
    `http://localhost/phpmyadmin`
3.  A tabela contendo os dados da esp se chamará `HistoricoDados`.
4.  Atualize a página (F5). **Você verá os dados do ESP32 aparecendo em tempo real.**
