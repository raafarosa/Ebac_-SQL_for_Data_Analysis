[![](https://raw.githubusercontent.com/raafarosa/Ebac_Data_Scientist_General/main/utilities/newebac_logo_black_half.png)](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis)
---
# **Módulo 5** | Agregações

**Aluno:** [Rafael Rosa](https://www.linkedin.com/in/rafael-rosa-alves/)<br>

---

### [Link para Querys](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%205%20-%20Agrega%C3%A7%C3%B5es/Query) <br>
### [Link para Results](https://github.com/raafarosa/Ebac_SQL_for_Data_Analysis/tree/main/Module%205%20-%20Agrega%C3%A7%C3%B5es/Results)

---
### **1 - Criação do database**: <br>

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS default.heartattack (
	`age` int,
	`sex` int,
	`cp` int,
	`trtbps` int,
	`chol` int,
	`fbs` int,
	`restecg` int,
	`thalachh` int,
	`exng` int,
	`oldpeak` double,
	`slp` int,
	`caa` int,
	`thall` int,
	`output` int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
	'serialization.format' = ',',
	'field.delim' = ','
)
LOCATION 's3://heart-attack-rafaelrosa-ebac/'
TBLPROPERTIES ('has_encrypted_data' = 'false');
```
---

### **2 - Explorando os dados com a função COUNT e GROUP BY**: <br>

#### **Query 1:**

```sql
SELECT * FROM heartattack limit 10;
```
#### **Query 2:**
```sql
SELECT COUNT(age) AS QUANTIDADE_LINHAS FROM heartattack;
```
#### **Query 3:**
```sql
SELECT COUNT(age) AS QUANTIDADE, CASE WHEN output = 1 THEN 'more chance of heart attack' ELSE 'less chance of heart attack' END AS output FROM heartattack GROUP BY output;
```

---
### **3 - Explorando os dados com a função MIN/MAX/SUM/AVG**: <br>

#### **Query 4:**
```sql
SELECT MAX(age),MIN(age),AVG(age), output FROM heartattack GROUP BY output;
```

#### **Query 5:** <br>
```sql
SELECT MAX(age),MIN(age),AVG(age),output,sex FROM heartattack GROUP BY output,sex;
```
---
### **4 - Explorando os dados com a função HAVING**: <br>

#### **Query 6:** <br>
```sql
SELECT COUNT(output), output, sex FROM heartattack GROUP BY output, sex HAVING COUNT(output) > 25;
```
---
### **5 - Results**: <br>

#### **Result 1:**
|age|sex|cp |trtbps|chol|fbs|restecg|thalachh|exng|oldpeak|slp|caa|thall|output|
|---|---|---|------|----|---|-------|--------|----|-------|---|---|-----|------|
|63 |1  |3  |145   |233 |1  |0      |150     |0   |2.3    |0  |0  |1    |1     |
|37 |1  |2  |130   |250 |0  |1      |187     |0   |3.5    |0  |0  |2    |1     |
|41 |0  |1  |130   |204 |0  |0      |172     |0   |1.4    |2  |0  |2    |1     |
|56 |1  |1  |120   |236 |0  |1      |178     |0   |0.8    |2  |0  |2    |1     |
|57 |0  |0  |120   |354 |0  |1      |163     |1   |0.6    |2  |0  |2    |1     |
|57 |1  |0  |140   |192 |0  |1      |148     |0   |0.4    |1  |0  |1    |1     |
|56 |0  |1  |140   |294 |0  |0      |153     |0   |1.3    |1  |0  |2    |1     |
|44 |1  |1  |120   |263 |0  |1      |173     |0   |0.0    |2  |0  |3    |1     |
|52 |1  |2  |172   |199 |1  |1      |162     |0   |0.5    |2  |0  |3    |1     |
|57 |1  |2  |150   |168 |0  |1      |174     |0   |1.6    |2  |0  |2    |1     |


----

#### **Result 2:**
|QUANTIDADE_LINHAS|
|-----------------|
|303              |

---

#### **Result 3:**
|QUANTIDADE|output                     |
|----------|---------------------------|
|138       |less chance of heart attack|
|165       |more chance of heart attack|


---

#### **Result 4:**
|_col0|_col1                      |_col2            |output|
|-----|---------------------------|-----------------|------|
|76   |29                         |52.4969696969697 |1     |
|77   |35                         |56.60144927536232|0     |


---

#### **Result 5:**
|_col0|_col1                      |_col2            |output|sex|
|-----|---------------------------|-----------------|------|---|
|76   |34                         |54.55555555555556|1     |0  |
|66   |43                         |59.041666666666664|0     |0  |
|70   |29                         |50.903225806451616|1     |1  |
|77   |35                         |56.08771929824562|0     |1  |


---

#### **Result 6:**
|_col0|output                     |sex              |
|-----|---------------------------|-----------------|
|93   |1                          |1                |
|114  |0                          |1                |
|72   |1                          |0                |


---
