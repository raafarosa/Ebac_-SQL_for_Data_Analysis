CREATE VIEW transacoesV100 AS
SELECT id_cliente,
	valor_compra,
	id_loja AS nome_loja
FROM transacoes
WHERE valor_compra > 100;

SELECT *
FROM transacoesv100;