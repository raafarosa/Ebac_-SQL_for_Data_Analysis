[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 6** | Múltiplas tabelas

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---

### [Link para Querys](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%205%20-%20Agrega%C3%A7%C3%B5es/Query) <br>
### [Link para Results](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%205%20-%20Agrega%C3%A7%C3%B5es/Results)

---
### **1 - Criação do database**: <br>

```sql
---Base clientes
CREATE EXTERNAL TABLE IF NOT EXISTS default.cliente (
	`id_cliente` int,
	`nome` string,
	`valor_compra` double,
	`loja_cadastro` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
	'serialization.format' = ',',
	'field.delim' = ','
)
LOCATION 's3://module7-rafaelrosa-ebac/cliente/'
TBLPROPERTIES ('has_encrypted_data' = 'false');
```

```sql
---Base Transacoes
CREATE EXTERNAL TABLE IF NOT EXISTS default.transacoes (
	`id_cliente` int,
	`id_transacao` bigint,
	`valor_compra` double,
	`id_loja` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
	'serialization.format' = ',',
	'field.delim' = ','
)
LOCATION 's3://module7-rafaelrosa-ebac/transacoes/'
TBLPROPERTIES ('has_encrypted_data' = 'false');
```
---

### **2 - Subqueries**: <br>

#### **Query 1:**
```sql
SELECT id_loja,
	id_cliente,
	id_transacao
FROM transacoes
WHERE id_loja IN (
		SELECT cliente.loja_cadastro
		FROM cliente
		WHERE cliente.valor_compra > 160
	);
```
---
### **3 - Particionamento**: <br>

```sql
CREATE EXTERNAL TABLE transacoes_part(
	id_cliente BIGINT,
	id_transacoes BIGINT,
	valor DOUBLE
)
PARTITIONED BY (id_loja string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
	'serialization.format' = ',',
	'field.delim' = ','
)
LOCATION 's3://transacoes-partition-rafaelrosa/';
```

```sql
MSCK REPAIR TABLE transacoes_part;
```

```sql
select count(*) from transacoes;
select count(*) from transacoes_part;
```

#### **Query 2:**
```sql
SELECT *
FROM transacoes_part
WHERE id_loja = 'magalu';
```
```sql
SELECT *
FROM transacoes
WHERE id_loja = 'magalu';
```

---
### **4 - Explorando dados com as Junções: left/right**: <br>

#### **Query 3:**
```sql
CREATE VIEW transacoesV100 AS
SELECT id_cliente,
	valor_compra,
	id_loja AS nome_loja
FROM transacoes
WHERE valor_compra > 100;
```
```sql
SELECT * FROM transacoesv100;
```
#### **Query 4:** <br>
```sql
CREATE VIEW clientevalor AS
SELECT id_cliente,
	valor_compra
FROM transacoes
ORDER BY valor_compra DESC
LIMIT 2;
```
```sql
SELECT * FROM clientevalor;
```
---
### **5 - Results**: <br>

#### **Result 1:**
|id_loja   |id_cliente|id_transacao|
|----------|----------|------------|
|magalu    |1         |768805383   |
|postoshell|3         |818770008   |
|magalu    |1         |76856563    |

---

#### **Result 2:**
|id_cliente|id_transacoes|valor    |id_loja|
|----------|-------------|---------|-------|
|1         |768805383    |50.74    |magalu |
|1         |76856563     |2000.9   |magalu |

---

#### **Result 3:**
|id_cliente|valor_compra|nome_loja|
|----------|------------|---------|
|3         |110.0       |postoshell|
|1         |2000.9      |magalu   |
|3         |1100.0      |shopee   |

---

#### **Result 4:**
|id_cliente|valor_compra|
|----------|------------|
|1         |2000.9      |
|3         |1100.0      |

---
