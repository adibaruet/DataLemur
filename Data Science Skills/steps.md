### Step 1: আগে required skill ৩টা আলাদা করব

Job-এর জন্য দরকার:

```text
Python
Tableau
PostgreSQL
```

তাই `WHERE IN` ব্যবহার করব:

```sql
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
```

এতে শুধু required skill-গুলো থাকবে।

---

### Step 2: Candidate অনুযায়ী group করব

একজন candidate-এর একাধিক skill আছে।

তাই:

```sql
GROUP BY candidate_id
```

করব।

---

### Step 3: Candidate-এর কয়টা required skill আছে সেটা count করব

আমাদের **৩টা skill-ই** লাগবে।

তাই:

```sql
COUNT(DISTINCT skill)
```

দিয়ে count করব।

তারপর:

```sql
HAVING COUNT(DISTINCT skill) = 3
```

মানে যার ৩টা required skill-ই আছে, শুধু তাকে রাখব।

---

### Step 4: Candidate ID দেখাব এবং ascending order-এ সাজাব

```sql
ORDER BY candidate_id
```

---

### Final Query

```sql
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3
ORDER BY candidate_id;
```

### সহজভাবে মনে রাখব

```text
Required skills
      ↓
WHERE IN
      ↓
Candidate অনুযায়ী GROUP BY
      ↓
কয়টা required skill আছে COUNT
      ↓
যাদের ৩টা আছে HAVING = 3
      ↓
ORDER BY candidate_id
```
