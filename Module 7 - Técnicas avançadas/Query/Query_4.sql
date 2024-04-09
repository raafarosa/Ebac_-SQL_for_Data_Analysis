CREATE VIEW clientevalor AS
SELECT id_cliente,
	valor_compra
FROM transacoes
ORDER BY valor_compra DESC
LIMIT 2;

SELECT *
FROM clientevalor;