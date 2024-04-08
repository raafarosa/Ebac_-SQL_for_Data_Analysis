[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 2** | Trabalhando com Tabelas

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---
### **1 - Explorando os dados da tabela de clientes**: <br>
#### **Query 1:**

```sql
SELECT id, idade, sexo, dependentes FROM clientes;
```
#### **Query 2:**

```sql
SELECT id, valor_transacoes_12m FROM clientes WHERE escolaridade = 'mestrado' and sexo = 'F';
```
#### **Query 3:**
```sql
SELECT sexo, AVG(idade) AS "media_idade_por_sexo" FROM clientes GROUP BY sexo;
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
LOCATION 'ebac-rafaelrosa-partitioned'
```
```sql
MSCK REPAIR TABLE clientes_part;
```
```sql
select * from clientes_part where sexo = 'F';
```

#### **Query 6:** <br>
```sql
SELECT id,idade,limite_credito FROM clientes_part WHERE sexo = 'M' ORDER BY limite_credito DESC;
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
### **5 - Results**: <br>

#### **Query 1:**

| id        | idade | sexo | dependentes |
|-----------|-------|------|---|
| 768805383 | 45    | M    | 3 | 
| 818770008 | 49    | F    | 5 | 
| 713982108 | 51    | M    | 3 |

----

#### **Query 2:**

| id        | valor_transacoes_12m |
|-----------|--------------------|
| 818770008 |1291.45    |

---

#### **Query 3:**

| sexo | media_idade_por_sexo |
|------|----------------------|
| F    | 49                   |
| M    | 48                   |

---

#### **Query 4:**

|id       |idade|sexo|dependentes|escolaridade|tipo_cartao|limite_credito|valor_transacoes_12m|qtd_transacoes_12m|
|---------|-----|----|-----------|------------|-----------|--------------|--------------------|------------------|
|768805383|45   |M   |3          |ensino medio|blue       |12691.51      |1144.9              |42                |
|818770008|49   |F   |5          |mestrado    |solteiro   |8256.96       |1291.45             |33                |
|713982108|51   |M   |3          |mestrado    |casado     |3418.56       |1887.72             |20                |
|768805451|56   |M   |6          |ensino medio|casado     |7591.51       |1564.9              |50                |
|456556   |30   |F   |0          |mestrado    |solteiro   |5526.96       |55251.45            |10                |
|545      |49   |F   |2          |doutorado   |blue       |3417.55       |555.72              |7                 |

---

#### **Query 5:**

|	id	|idade|	dependentes	|escolaridade|	tipo_cartao	|limite_credito	|valor_transacoes_12m	|qtd_transacoes_12m	|sexo|
|---|-|-|-|-|-|-|-|-|
| 456556|	30|	0|	mestrado|	solteiro|	5526.96|	55251.45	|10|	F|
|	545	|49|	2|	doutorado|	blue	|3417.55|	555.72	|7|	F|
|	818770008	|49|	5 |	mestrado|	solteiro|		8256.96|	1291.45|	33|	F|

---

#### **Query 6:**

|id       |idade|limite_credito|
|---------|-----|--------------|
|768805383|45   |12691.51      |
|768805451|56   |7591.51       |
|713982108|51   |3418.56       |


---

#### **Query 7:**

|id       |idade|sexo|dependentes|escolaridade|tipo_cartao|limite_credito|valor_transacoes_12m|qtd_transacoes_12m|estado|
|---------|-----|----|-----------|------------|-----------|--------------|--------------------|------------------|------|
|768805451|56   |M   |6          |ensino medio|casado     |7591.51       |1564.90             |50                |      |
|456556   |30   |F   |0          |mestrado    |solteiro   |5526.96       |55251.45            |10                |      |
|545      |49   |F   |2          |doutorado   |blue       |3417.55       |555.72              |7                 |      |
|768805383|45   |M   |3          |ensino medio|blue       |12691.51      |1144.90             |42                |      |
|818770008|49   |F   |5          |mestrado    |solteiro   |8256.96       |1291.45             |33                |      |
|713982108|51   |M   |3          |mestrado    |casado     |3418.56       |1887.72             |20                |      |


---
