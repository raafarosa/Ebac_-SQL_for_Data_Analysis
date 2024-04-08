[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 2** | Trabalhando com Tabelas

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---
### **1 - Explorando os dados da tabela de clientes**: <br>
#### Query 1

```sql
SELECT id,
	idade,
	sexo,
	dependentes
FROM clientes;
```
#### Query 2

```sql
SELECT id,
	valor_transacoes_12m
FROM clientes
WHERE escolaridade = 'mestrado'
	and sexo = 'F';
```
#### Query 3
```sql
SELECT sexo,
	AVG(idade) AS "media_idade_por_sexo"
FROM clientes
GROUP BY sexo;
```
---
### **2 - Inserindo novos dados**:

#### **Query 4:** <br>
```sql
SELECT * FROM clientes;
```
---
### **3 - Criando e trabalhando com partições**:

#### **Query 5:** <br>
```sql
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
LOCATION 'aaaaaaaaaaaaa'
```
```sql
MSCK REPAIR TABLE clientes_part;
```
```sql
select * from clientes_part where sexo = 'F';
```

#### **Query 6:** <br>
```sql
SELECT id,
	idade,
	limite_credito
FROM clientes_part
WHERE sexo = 'M'
ORDER BY limite_credito DESC;
```
---

### **4 - Adicionando colunas:**

#### **Query 7:**

```sql
ALTER TABLE clientes ADD COLUMNS (estado string)
```
#### **Base query:**
```sql
SELECT * from clientes
```

---