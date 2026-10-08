SELECT user_id,
MAX(post_date)::date - MIN(post_date)::date AS days_between
FROM posts
WHERE post_date >= '2021-01-01'
AND post_date < '2022-01-01'
GROUP BY user_id
HAVING COUNT(*) >= 2; a
