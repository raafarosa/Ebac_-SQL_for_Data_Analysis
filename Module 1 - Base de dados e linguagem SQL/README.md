[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 1** | Base de dados e linguagem SQL

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---
### **1 - Criação da tabela de clientes** <br>[Script](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/blob/main/Module%201%20-%20Base%20de%20dados%20e%20linguagem%20SQL/Query/Create_table.sql)

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
  qtd_transacoes_12m BIGINT) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar' = ',', 'quoteChar' = '"', 'escapeChar' = '\\')
STORED AS TEXTFILE
LOCATION 's3://ebac-rafaelrosa-modulo-1/'
```
---
### **2 - Explorando os dados da tabela de clientes**
---

#### **Query 1:** <br>[Script](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/blob/main/Module%201%20-%20Base%20de%20dados%20e%20linguagem%20SQL/Query/Query_1.sql)
```sql
SELECT * FROM clientes
```
---
#### **Query 2:** <br>[Script](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/blob/main/Module%201%20-%20Base%20de%20dados%20e%20linguagem%20SQL/Query/Query_2.sql)
```sql
SELECT id, idade, limite_credito, * FROM clientes WHERE sexo = 'M' ORDER BY 1 DESC
```
---
#### **Query 3:** <br>[Script](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/blob/main/Module%201%20-%20Base%20de%20dados%20e%20linguagem%20SQL/Query/Query_3.sql)
```sql
SELECT sexo, AVG(idade) AS "media_idade_por_sexo" * FROM clientes GROUP BY sexo
```
---

### **3 - Resultados gerados:**
---

#### **Query 1:** <br> [Result](https://raw.githubusercontent.com/raafarosa/Ebac_SQL_for_Data_Analysis/main/Module%201%20-%20Base%20de%20dados%20e%20linguagem%20SQL/Results/Result_Query_1.csv)

|id                                                                                                                             |idade|sexo|dependentes|escolaridade|tipo_cartao|limite_credito|valor_transacoes_12m|qtd_transacoes_12m|
|-------------------------------------------------------------------------------------------------------------------------------|-----|----|-----------|------------|-----------|--------------|--------------------|------------------|
|768805383                                                                                                                      |45   |M   |3          |ensino medio|blue       |12691.51      |1144.9              |42                |
|818770008                                                                                                                      |49   |F   |5          |mestrado    |solteiro   |8256.96       |1291.45             |33                |
|713982108                                                                                                                      |51   |M   |3          |mestrado    |casado     |3418.56       |1887.72             |20                |

---
#### **Query 2:** <br> [Result](https://raw.githubusercontent.com/raafarosa/Ebac_SQL_for_Data_Analysis/main/Module%201%20-%20Base%20de%20dados%20e%20linguagem%20SQL/Results/Result_Query_2.csv)
|id                                                                                                                             |idade|limite_credito|
|-------------------------------------------------------------------------------------------------------------------------------|-----|--------------|
|713982108                                                                                                                      |51   |3418.56       |
|768805383                                                                                                                      |45   |12691.51      |

---

#### **Query 3:** <br> [Result](https://raw.githubusercontent.com/raafarosa/Ebac_SQL_for_Data_Analysis/main/Module%201%20-%20Base%20de%20dados%20e%20linguagem%20SQL/Results/Result_Query_3.csv)
|sexo                                                                                                                           |media_idade_por_sexo|
|-------------------------------------------------------------------------------------------------------------------------------|--------------------|
|M                                                                                                                              |48.0                |
|F                                                                                                                              |49.0                |
---