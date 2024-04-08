[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 3** | Seleção e ordenação em SQL

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---

### [Link para Querys](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%203%20-%20Sele%C3%A7%C3%A3o%20e%20ordena%C3%A7%C3%A3o%20em%20SQL/Query) <br>
### [Link para Results](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%203%20-%20Sele%C3%A7%C3%A3o%20e%20ordena%C3%A7%C3%A3o%20em%20SQL/Results)

---
### **1 - Explorando os dados**: <br>

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
#### **Query 1:**

```sql
SELECT * FROM transacoes
```
#### **Query 2:**
```sql
SELECT id_cliente, valor, id_loja AS nome_loja FROM transacoes;
```
#### **Query 3:**
```sql
SELECT DISTINCT id_loja AS nome_loja FROM transacoes;
```
---

### **2 - Ordenando e limitando dados**: <br>

#### **Query 4:** <br>
```sql
SELECT id_cliente, valor FROM transacoes ORDER BY valor DESC LIMIT 2;
```
---
### **3 - Results**: <br>

#### **Result 1:**

|id_cliente|id_transacao|valor |id_loja    |
|----------|------------|------|-----------|
|1         |768805383   |50.74 |magalu     |
|2         |768805399   |30.9  |giraffas   |
|3         |818770008   |110.0 |postoshell |
|1         |76856563    |2000.9|magalu     |
|1         |767573759   |15.7  |subway     |
|3         |818575758   |2.99  |seveneleven|
|4         |764545534   |50.74 |extra      |
|5         |76766789    |10.0  |subway     |
|3         |8154567758  |1100.0|shopee     |


----

#### **Result 2:**

|id_cliente|valor     |nome_loja|
|----------|----------|---------|
|1         |50.74     |magalu   |
|2         |30.9      |giraffas |
|3         |110.0     |postoshell|
|1         |2000.9    |magalu   |
|1         |15.7      |subway   |
|3         |2.99      |seveneleven|
|4         |50.74     |extra    |
|5         |10.0      |subway   |
|3         |1100.0    |shopee   |


---

#### **Result 3:**

|nome_loja|
|---------|
|seveneleven|
|giraffas |
|magalu   |
|postoshell|
|extra    |
|subway   |
|shopee   |


---

#### **Result 4:**

|id_cliente|valor |
|----------|------|
|1         |2000.9|
|3         |1100.0|


---