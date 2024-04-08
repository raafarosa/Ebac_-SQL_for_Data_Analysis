CREATE EXTERNAL TABLE clientes_part(
	id BIGINT,
	idade BIGINT,
	dependentes BIGINT,
	escolaridade STRING,
	tipo_cartao STRING,
	limite_credito DOUBLE,
	valor_transacoes_12m DOUBLE,
	qtd_transacoes_12m BIGINT
)
PARTITIONED BY (sexo string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	'separatorChar' = ',',
	'quoteChar' = '"',
	'escapeChar' = '\\'
)
STORED AS TEXTFILE
LOCATION 'ebac-rafaelrosa-partitioned'

MSCK REPAIR TABLE clientes_part;

select * from clientes_part where sexo = 'F';
