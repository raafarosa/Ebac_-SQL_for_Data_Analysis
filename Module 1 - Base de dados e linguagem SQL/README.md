[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_Data_Scientist_General)
---

# **Módulo 1** | Base de dados e linguagem SQL

**Professor:** [André Perez](https://www.linkedin.com/in/andremarcosperez/)<br>
**Por:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---

## Atividades

### **1 Criação da tabela de clientes**

```sql
CREATE EXTERNAL TABLE clientes(
	id BIGINT,
	idade BIGINT,
	sexo STRING,
	dependentes BIGINT,
	escolaridade STRING,
	tipo_cartao STRING,
	limite_credito DOUBLE,
	valor_transacoes_12m DOUBLE,
	qtd_transacoes_12m BIGINT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	'separatorChar' = ',',
	'quoteChar' = '"',
	'escapeChar' = '\\'
)
STORED AS TEXTFILE
LOCATION ''
```

### **2. Explorando os dados da tabela de clientes**
---

#### [**Query 1:**](##URL query)
```sql
SELECT * FROM clientes
```
---
#### [**2.2. Query 2**](##URL query)
```sql
SELECT id, idade, limite_credito, FROM clientes WHERE sexo = 'M' ORDER BY 1 DESC
```
---
#### [**2.3. Query 3**](##URL query)
```sql
SELECT sexo, AVG(idade) AS "media_idade_por_sexo" FROM clientes GROUP BY sexo
```
---
