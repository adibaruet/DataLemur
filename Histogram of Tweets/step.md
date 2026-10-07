
### Step 1: আগে 2022 সালের tweet নেব

```sql
WHERE tweet_date >= '2022-01-01'
AND tweet_date < '2023-01-01'
```

মানে শুধু 2022 সালের tweets।

### Step 2: প্রত্যেক user কতগুলো tweet করেছে সেটা count করব

```sql
SELECT user_id, COUNT(*) AS tweet_count
FROM tweets
WHERE tweet_date >= '2022-01-01'
AND tweet_date < '2023-01-01'
GROUP BY user_id
```

এতে এমন result আসবে:

| user_id | tweet_count |
| ------- | ----------: |
| 111     |           2 |
| 254     |           1 |
| 148     |           1 |

এখন আমরা জানি কে কতটা tweet করেছে।

### Step 3: এখন একই tweet count-এর কতজন user আছে সেটা count করব

এটাই আসল trick।

আমাদের দরকার:

> **1টা tweet করেছে কতজন?**
> **2টা tweet করেছে কতজন?**
> **3টা tweet করেছে কতজন?**

তাই উপরের query-টাকে একটা subquery বানিয়ে আবার `GROUP BY tweet_count` করব।

### Final Query

```sql
SELECT
    tweet_count AS tweet_bucket,
    COUNT(*) AS users_num
FROM (
    SELECT
        user_id,
        COUNT(*) AS tweet_count
    FROM tweets
    WHERE tweet_date >= '2022-01-01'
      AND tweet_date < '2023-01-01'
    GROUP BY user_id
) AS user_tweets
GROUP BY tweet_count
ORDER BY tweet_count;
```

### সহজভাবে মনে রাখো

**প্রথম GROUP BY:**

> `user_id` → একজন user কত tweet করেছে?

**দ্বিতীয় GROUP BY:**

> `tweet_count` → ঐ সংখ্যক tweet করা কতজন user আছে?

So the pattern is:

```text
tweets
 ↓
GROUP BY user_id
 ↓
tweet count per user
 ↓
GROUP BY tweet_count
 ↓
number of users
```

এই প্রশ্নের **main trick হলো দুইবার GROUP BY করা**।
