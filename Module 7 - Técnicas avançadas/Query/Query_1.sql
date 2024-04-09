SELECT id_loja,
	id_cliente,
	id_transacao
FROM transacoes
WHERE id_loja IN (
		SELECT cliente.loja_cadastro
		FROM cliente
		WHERE cliente.valor_compra > 160
	);