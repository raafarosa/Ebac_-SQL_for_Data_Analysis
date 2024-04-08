[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 5** | Agregações

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---

### [Link para Querys](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%204%20-%20Filtragem%20e%20sele%C3%A7%C3%A3o%20condicional/Query) <br>
### [Link para Results](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%204%20-%20Filtragem%20e%20sele%C3%A7%C3%A3o%20condicional/Results)

---
### **1 - Criação do database**: <br>

```sql
CREATE EXTERNAL TABLE transacoes(
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
---

### **2 - Explorando os dados**: <br>

#### **Query 1:**

```sql
SELECT *
FROM transacoes WHERE valor > 30 AND id_loja = 'magalu';
```
#### **Query 2:**
```sql
SELECT * FROM transacoes WHERE valor > 30 OR id_loja = 'magalu';
```
#### **Query 3:**
```sql
SELECT * FROM transacoes WHERE id_loja IN ('magalu', 'subway') AND valor > 10;
```

#### **Query 4:**
```sql
SELECT * FROM transacoes WHERE valor BETWEEN 60.0 AND 1000.0;
```
---

### **3 - Filtro like e wildcards**: <br>

#### **Query 5:** <br>
```sql
SELECT * FROM transacoes WHERE id_loja LIKE 'mag%';
```

#### **Query 6:** <br>
```sql
SELECT * FROM transacoes WHERE id_loja LIKE '%sh%';
```

---

### **4 - Seleção condicional**: <br>

#### **Query 7:** <br>
```sql
SELECT id_cliente,
	id_loja,
	valor,
	CASE
		WHEN valor > 1000 THEN 'Compra com alto valor'
		WHEN valor < 1000 THEN 'Compra com baixo valor'
	END AS classeValor,
	CASE
		WHEN id_loja IN ('giraffas', 'subway') THEN 'alimentacao'
		WHEN id_loja IN ('magalu', 'extra') THEN 'variedade'
		WHEN id_loja IN ('postoshell', 'seveneleven') THEN '24horas' ELSE 'outros'
	END AS tipo_compra
FROM transacoes;
```

---
### **5 - Results**: <br>

#### **Result 1:**
|id_cliente|id_transacao|valor |id_loja|
|----------|------------|------|-------|
|1         |768805383   |50.74 |magalu |
|1         |76856563    |2000.9|magalu |

----

#### **Result 2:**
|id_cliente|id_transacao|valor |id_loja|
|----------|------------|------|-------|
|1         |768805383   |50.74 |magalu |
|2         |768805399   |30.9  |giraffas|
|3         |818770008   |110.0 |postoshell|
|1         |76856563    |2000.9|magalu |
|4         |764545534   |50.74 |extra  |
|3         |8154567758  |1100.0|shopee |

---

#### **Result 3:**
|id_cliente|id_transacao|valor |id_loja|
|----------|------------|------|-------|
|1         |768805383   |50.74 |magalu |
|1         |76856563    |2000.9|magalu |
|1         |767573759   |15.7  |subway |

---

#### **Result 4:**
|id_cliente|id_transacao|valor |id_loja|
|----------|------------|------|-------|
|3         |818770008   |110.0 |postoshell|

---

#### **Result 5:**
|id_cliente|id_transacao|valor |id_loja|
|----------|------------|------|-------|
|1         |768805383   |50.74 |magalu |
|1         |76856563    |2000.9|magalu |

---

#### **Result 6:**
|id_cliente|id_transacao|valor |id_loja|
|----------|------------|------|-------|
|3         |818770008   |110.0 |postoshell|
|3         |8154567758  |1100.0|shopee |

---

#### **Result 7:**
|id_cliente|id_loja  |valor |classeValor|tipo_compra|
|----------|---------|------|-----------|-----------|
|1         |magalu   |50.74 |Compra com baixo valor|variedade  |
|2         |giraffas |30.9  |Compra com baixo valor|alimentacao|
|3         |postoshell|110.0 |Compra com baixo valor|24horas    |
|1         |magalu   |2000.9|Compra com alto valor|variedade  |
|1         |subway   |15.7  |Compra com baixo valor|alimentacao|
|3         |seveneleven|2.99  |Compra com baixo valor|24horas    |
|4         |extra    |50.74 |Compra com baixo valor|variedade  |
|5         |subway   |10.0  |Compra com baixo valor|alimentacao|
|3         |shopee   |1100.0|Compra com alto valor|outros     |

---