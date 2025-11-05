-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05/11/2025 às 17:30
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `projetointegrador`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `historicodados`
--

CREATE TABLE `historicodados` (
  `log_id` bigint(20) NOT NULL,
  `malha_id` int(11) NOT NULL,
  `timestamp` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `nivel_sensor_medido` float DEFAULT NULL,
  `saida_atuador_calculada` float DEFAULT NULL,
  `setpoint_no_momento` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `malhasdecontrole`
--

CREATE TABLE `malhasdecontrole` (
  `malha_id` int(11) NOT NULL,
  `nome_malha` varchar(50) NOT NULL,
  `setpoint` float DEFAULT 0,
  `modo_operacao` enum('automatico','manual') NOT NULL DEFAULT 'manual',
  `saida_manual_percent` float DEFAULT 0,
  `param_kp` float DEFAULT 0,
  `param_ki` float DEFAULT 0,
  `param_kd` float DEFAULT 0,
  `ultima_modificacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modificado_por_usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `malhasdecontrole`
--

INSERT INTO `malhasdecontrole` (`malha_id`, `nome_malha`, `setpoint`, `modo_operacao`, `saida_manual_percent`, `param_kp`, `param_ki`, `param_kd`, `ultima_modificacao`, `modificado_por_usuario_id`) VALUES
(1, 'Tanque 1', 0, 'manual', 0, 0, 0, 0, '2025-11-04 21:09:45', NULL),
(2, 'Tanque 2', 0, 'manual', 0, 0, 0, 0, '2025-11-04 21:09:45', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(11) NOT NULL,
  `nome_usuario` varchar(50) NOT NULL,
  `hash_senha` varchar(255) NOT NULL,
  `permissao` enum('admin','operador') NOT NULL DEFAULT 'operador',
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `historicodados`
--
ALTER TABLE `historicodados`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_malha_timestamp` (`malha_id`,`timestamp`);

--
-- Índices de tabela `malhasdecontrole`
--
ALTER TABLE `malhasdecontrole`
  ADD PRIMARY KEY (`malha_id`),
  ADD UNIQUE KEY `nome_malha` (`nome_malha`),
  ADD KEY `modificado_por_usuario_id` (`modificado_por_usuario_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `nome_usuario` (`nome_usuario`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `historicodados`
--
ALTER TABLE `historicodados`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `malhasdecontrole`
--
ALTER TABLE `malhasdecontrole`
  MODIFY `malha_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `historicodados`
--
ALTER TABLE `historicodados`
  ADD CONSTRAINT `historicodados_ibfk_1` FOREIGN KEY (`malha_id`) REFERENCES `malhasdecontrole` (`malha_id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `malhasdecontrole`
--
ALTER TABLE `malhasdecontrole`
  ADD CONSTRAINT `malhasdecontrole_ibfk_1` FOREIGN KEY (`modificado_por_usuario_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
