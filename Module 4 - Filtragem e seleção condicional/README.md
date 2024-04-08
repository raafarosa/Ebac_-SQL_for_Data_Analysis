[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 4** | Filtragem e seleção condicional

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
### **3 - Results**: <br>

#### **Result 1:**




----

#### **Result 2:**




---

#### **Result 3:**




---

#### **Result 4:**




---

#### **Result 5:**

---

#### **Result 6:**

---

#### **Result 7:**