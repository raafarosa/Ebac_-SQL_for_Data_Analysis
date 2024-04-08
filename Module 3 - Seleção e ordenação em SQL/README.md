[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 3** | Seleção e ordenação em SQL

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---

### [Link para Querys](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%203%20-%20Sele%C3%A7%C3%A3o%20e%20ordena%C3%A7%C3%A3o%20em%20SQL/Query) <br>
### [Link para Results](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%203%20-%20Sele%C3%A7%C3%A3o%20e%20ordena%C3%A7%C3%A3o%20em%20SQL/Results)

---
### **1 - Explorando os dados**: <br>
#### **Query 1:**

```sql
CREATE EXTERNAL TABLE transacoes (
	id_cliente BIGINT,
	id_transacao BIGINT,
	valor FLOAT,
	id_loja STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	'separatorChar' = ',',
	'quoteChar' = '"',
	'escapeChar' = '\\'
)
STORED AS TEXTFILE
LOCATION 's3://ebac-rafaelrosa-transacoes'
```
#### **Query 2:**

```sql
SELECT * FROM transacoes
```
#### **Query 3:**
```sql
SELECT id_cliente, valor, id_loja AS nome_loja FROM transacoes;
```
### **2 - Ordenando e limitando dados**: <br>

#### **Query 4:** <br>
```sql
SELECT id_cliente, valor FROM transacoes ORDER BY valor DESC LIMIT 2;
```
---
### **3 - Results**: <br>

#### **Result 1:**

| id        | idade | sexo | dependentes |
|-----------|-------|------|---|
| 768805383 | 45    | M    | 3 | 
| 818770008 | 49    | F    | 5 | 
| 713982108 | 51    | M    | 3 |

----

#### **Result 2:**

| id        | valor_transacoes_12m |
|-----------|--------------------|
| 818770008 |1291.45    |

---

#### **Result 3:**

| sexo | media_idade_por_sexo |
|------|----------------------|
| F    | 49                   |
| M    | 48                   |

---

#### **Result 4:**

|id       |idade|sexo|dependentes|escolaridade|tipo_cartao|limite_credito|valor_transacoes_12m|qtd_transacoes_12m|
|---------|-----|----|-----------|------------|-----------|--------------|--------------------|------------------|
|768805383|45   |M   |3          |ensino medio|blue       |12691.51      |1144.9              |42                |
|818770008|49   |F   |5          |mestrado    |solteiro   |8256.96       |1291.45             |33                |
|713982108|51   |M   |3          |mestrado    |casado     |3418.56       |1887.72             |20                |
|768805451|56   |M   |6          |ensino medio|casado     |7591.51       |1564.9              |50                |
|456556   |30   |F   |0          |mestrado    |solteiro   |5526.96       |55251.45            |10                |
|545      |49   |F   |2          |doutorado   |blue       |3417.55       |555.72              |7                 |

---

#### **Result 5:**

|	id	|idade|	dependentes	|escolaridade|	tipo_cartao	|limite_credito	|valor_transacoes_12m	|qtd_transacoes_12m	|sexo|
|---|-|-|-|-|-|-|-|-|
| 456556|	30|	0|	mestrado|	solteiro|	5526.96|	55251.45	|10|	F|
|	545	|49|	2|	doutorado|	blue	|3417.55|	555.72	|7|	F|
|	818770008	|49|	5 |	mestrado|	solteiro|		8256.96|	1291.45|	33|	F|

---

#### **Result 6:**

|id       |idade|limite_credito|
|---------|-----|--------------|
|768805383|45   |12691.51      |
|768805451|56   |7591.51       |
|713982108|51   |3418.56       |


---

#### **Result 7:**

|id       |idade|sexo|dependentes|escolaridade|tipo_cartao|limite_credito|valor_transacoes_12m|qtd_transacoes_12m|estado|
|---------|-----|----|-----------|------------|-----------|--------------|--------------------|------------------|------|
|768805451|56   |M   |6          |ensino medio|casado     |7591.51       |1564.90             |50                |      |
|456556   |30   |F   |0          |mestrado    |solteiro   |5526.96       |55251.45            |10                |      |
|545      |49   |F   |2          |doutorado   |blue       |3417.55       |555.72              |7                 |      |
|768805383|45   |M   |3          |ensino medio|blue       |12691.51      |1144.90             |42                |      |
|818770008|49   |F   |5          |mestrado    |solteiro   |8256.96       |1291.45             |33                |      |
|713982108|51   |M   |3          |mestrado    |casado     |3418.56       |1887.72             |20                |      |


---
