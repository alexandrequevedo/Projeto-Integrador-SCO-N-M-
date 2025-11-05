<?php
/*
 * gravar_dados.php
 * Recebe dados do ESP32 via HTTP POST e insere no banco de dados "projeto_controle".
 */

// --- 1. Configuração do Banco de Dados ---
// (Estes são os padrões do XAMPP)
$servername = "localhost";
$username = "root";       // Usuário padrão do XAMPP
$password = "";           // Senha padrão do XAMPP (vazia)
$dbname = "projeto_controle"; // O nome do banco que você criou

// --- 2. Coletar Dados do ESP32 ---
// Vamos assumir que o ESP32 enviará os dados via método POST.
// Usamos 'isset()' para verificar se a variável foi enviada.

if (isset($_POST['malha_id']) && 
    isset($_POST['nivel']) && 
    isset($_POST['saida']) &&
    isset($_POST['setpoint'])) 
{
    $malha_id = $_POST['malha_id'];
    $nivel_medido = $_POST['nivel'];
    $saida_calculada = $_POST['saida'];
    $setpoint_momento = $_POST['setpoint'];

    // --- 3. Conectar ao Banco de Dados ---
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Verificar conexão
    if ($conn->connect_error) {
        die("Conexão falhou: " . $conn->connect_error);
    }

    // --- 4. Preparar e Executar o SQL (Forma Segura) ---
    // Usamos "Prepared Statements" (com '?') para evitar injeção de SQL.
    $stmt = $conn->prepare("INSERT INTO HistoricoDados 
                            (malha_id, nivel_sensor_medido, saida_atuador_calculada, setpoint_no_momento) 
                            VALUES (?, ?, ?, ?)");
    
    // 'iddd' significa que as variáveis são: Integer, Double, Double, Double
    $stmt->bind_param("iddd", $malha_id, $nivel_medido, $saida_calculada, $setpoint_momento);

    // Executar o comando
    if ($stmt->execute()) {
        // Se deu certo, responde "OK" para o ESP32 saber que funcionou.
        echo "OK: Dados gravados com sucesso!";
    } else {
        // Se deu erro, responde o erro para o ESP32.
        echo "Erro ao gravar: " . $stmt->error;
    }

    // Fechar tudo
    $stmt->close();
    $conn->close();

} else {
    // Se o ESP32 tentou acessar o script sem enviar todos os dados
    echo "Erro: Dados incompletos. Verifique se 'malha_id', 'nivel', 'saida' e 'setpoint' foram enviados via POST.";
}

?>
