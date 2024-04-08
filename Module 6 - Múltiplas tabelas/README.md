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
LOCATION 's3://modulo6-rafaelrosa-ebac/cliente/'
TBLPROPERTIES ('has_encrypted_data' = 'false');
```

```sql
---Base Transacoes
CREATE EXTERNAL TABLE IF NOT EXISTS default.transacoes (
	`id_cliente` int,
	`id_transacao` int,
	`valor_compra` double,
	`id_loja` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
	'serialization.format' = ',',
	'field.delim' = ','
)
LOCATION 's3://modulo6-rafaelrosa-ebac/transacoes/'
TBLPROPERTIES ('has_encrypted_data' = 'false');
```
---

### **2 - Explorando dados com a função UNION**: <br>

#### **Query 1:**
```sql
SELECT id_cliente FROM transacoes UNION SELECT id_cliente FROM cliente;
```
---
### **3 - Explorando dados com as Junções inner/cross**: <br>

#### **Query 2:**
```sql
SELECT transacoes.id_cliente,	cliente.nome FROM transacoes INNER JOIN cliente ON transacoes.id_cliente = cliente.id_cliente;
```
#### **Query 3:**
```sql
SELECT * FROM cliente CROSS JOIN transacoes;
```
---
### **4 - Explorando dados com as Junções: left/right**: <br>

#### **Query 4:**
```sql
SELECT * FROM transacoes LEFT JOIN cliente ON cliente.id_cliente = transacoes.id_cliente;
```
#### **Query 5:** <br>
```sql
SELECT * FROM transacoes RIGHT JOIN cliente ON cliente.id_cliente = transacoes.id_cliente;
```
---
### **5 - Results**: <br>

#### **Result 1:**
|id_cliente|
|----------|
|3         |
|1         |
|6         |
|5         |
|2         |
|4         |
---

#### **Result 2:**
|id_cliente|nome     |
|----------|---------|
|1         |maria    |
|2         |valentina|
|1         |maria    |
|1         |maria    |
|4         |joana    |
|5         |jose     |
---

#### **Result 3:**
|id_cliente|nome     |valor_compra|loja_cadastro|id_cliente|id_transacao|valor_compra|id_loja    |
|----------|---------|------------|-------------|----------|------------|------------|-----------|
|5         |jose     |500.43      |cea          |1         |768805383   |50.74       |magalu     |
|5         |jose     |500.43      |cea          |2         |768805399   |30.9        |giraffas   |
|5         |jose     |500.43      |cea          |3         |818770008   |110.0       |postoshell |
|5         |jose     |500.43      |cea          |1         |76856563    |2000.9      |magalu     |
|5         |jose     |500.43      |cea          |1         |767573759   |15.7        |subway     |
|5         |jose     |500.43      |cea          |3         |818575758   |2.99        |seveneleven|
|5         |jose     |500.43      |cea          |4         |764545534   |50.74       |extra      |
|5         |jose     |500.43      |cea          |5         |76766789    |10.0        |subway     |
|5         |jose     |500.43      |cea          |3         |959569      |1100.0      |shopee     |
|1         |maria    |150.7       |riachuelo    |1         |768805383   |50.74       |magalu     |
|1         |maria    |150.7       |riachuelo    |2         |768805399   |30.9        |giraffas   |
|1         |maria    |150.7       |riachuelo    |3         |818770008   |110.0       |postoshell |
|1         |maria    |150.7       |riachuelo    |1         |76856563    |2000.9      |magalu     |
|1         |maria    |150.7       |riachuelo    |1         |767573759   |15.7        |subway     |
|1         |maria    |150.7       |riachuelo    |3         |818575758   |2.99        |seveneleven|
|1         |maria    |150.7       |riachuelo    |4         |764545534   |50.74       |extra      |
|1         |maria    |150.7       |riachuelo    |5         |76766789    |10.0        |subway     |
|1         |maria    |150.7       |riachuelo    |3         |959569      |1100.0      |shopee     |
|2         |valentina|210.99      |zara         |1         |768805383   |50.74       |magalu     |
|2         |valentina|210.99      |zara         |2         |768805399   |30.9        |giraffas   |
|2         |valentina|210.99      |zara         |3         |818770008   |110.0       |postoshell |
|2         |valentina|210.99      |zara         |1         |76856563    |2000.9      |magalu     |
|2         |valentina|210.99      |zara         |1         |767573759   |15.7        |subway     |
|2         |valentina|210.99      |zara         |3         |818575758   |2.99        |seveneleven|
|2         |valentina|210.99      |zara         |4         |764545534   |50.74       |extra      |
|2         |valentina|210.99      |zara         |5         |76766789    |10.0        |subway     |
|2         |valentina|210.99      |zara         |3         |959569      |1100.0      |shopee     |
|4         |joana    |1300.5      |pontofrio    |1         |768805383   |50.74       |magalu     |
|4         |joana    |1300.5      |pontofrio    |2         |768805399   |30.9        |giraffas   |
|4         |joana    |1300.5      |pontofrio    |3         |818770008   |110.0       |postoshell |
|4         |joana    |1300.5      |pontofrio    |1         |76856563    |2000.9      |magalu     |
|4         |joana    |1300.5      |pontofrio    |1         |767573759   |15.7        |subway     |
|4         |joana    |1300.5      |pontofrio    |3         |818575758   |2.99        |seveneleven|
|4         |joana    |1300.5      |pontofrio    |4         |764545534   |50.74       |extra      |
|4         |joana    |1300.5      |pontofrio    |5         |76766789    |10.0        |subway     |
|4         |joana    |1300.5      |pontofrio    |3         |959569      |1100.0      |shopee     |
|6         |fernando |86.55       |pontofrio    |1         |768805383   |50.74       |magalu     |
|6         |fernando |86.55       |pontofrio    |2         |768805399   |30.9        |giraffas   |
|6         |fernando |86.55       |pontofrio    |3         |818770008   |110.0       |postoshell |
|6         |fernando |86.55       |pontofrio    |1         |76856563    |2000.9      |magalu     |
|6         |fernando |86.55       |pontofrio    |1         |767573759   |15.7        |subway     |
|6         |fernando |86.55       |pontofrio    |3         |818575758   |2.99        |seveneleven|
|6         |fernando |86.55       |pontofrio    |4         |764545534   |50.74       |extra      |
|6         |fernando |86.55       |pontofrio    |5         |76766789    |10.0        |subway     |
|6         |fernando |86.55       |pontofrio    |3         |959569      |1100.0      |shopee     |
---

#### **Result 4:**
|id_cliente|id_transacao|valor_compra|id_loja   |id_cliente|nome     |valor_compra|loja_cadastro|
|----------|------------|------------|----------|----------|---------|------------|-------------|
|1         |768805383   |50.74       |magalu    |1         |maria    |150.7       |riachuelo    |
|2         |768805399   |30.9        |giraffas  |2         |valentina|210.99      |zara         |
|3         |818770008   |110.0       |postoshell|          |         |            |             |
|1         |76856563    |2000.9      |magalu    |1         |maria    |150.7       |riachuelo    |
|1         |767573759   |15.7        |subway    |1         |maria    |150.7       |riachuelo    |
|3         |818575758   |2.99        |seveneleven|          |         |            |             |
|4         |764545534   |50.74       |extra     |4         |joana    |1300.5      |pontofrio    |
|5         |76766789    |10.0        |subway    |5         |jose     |500.43      |cea          |
|3         |959569      |1100.0      |shopee    |          |         |            |             |
---

#### **Result 5:**
|id_cliente|id_transacao|valor_compra|id_loja   |id_cliente|nome     |valor_compra|loja_cadastro|
|----------|------------|------------|----------|----------|---------|------------|-------------|
|1         |768805383   |50.74       |magalu    |1         |maria    |150.7       |riachuelo    |
|2         |768805399   |30.9        |giraffas  |2         |valentina|210.99      |zara         |
|1         |76856563    |2000.9      |magalu    |1         |maria    |150.7       |riachuelo    |
|1         |767573759   |15.7        |subway    |1         |maria    |150.7       |riachuelo    |
|4         |764545534   |50.74       |extra     |4         |joana    |1300.5      |pontofrio    |
|5         |76766789    |10.0        |subway    |5         |jose     |500.43      |cea          |
|          |            |            |          |6         |fernando |86.55       |pontofrio    |
---