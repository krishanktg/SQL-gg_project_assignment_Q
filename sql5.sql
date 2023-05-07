SELECT 
  us.utm_source,
  COUNT(DISTINCT us.user_id) AS num_users,
  SUM(r.total_revenue_in_paise) AS total_revenue,
  (MAX(us.last_login_at) - MIN(us.created_at)) AS retention_time,
  (SUM(r.total_revenue_in_paise) / COUNT(DISTINCT us.user_id)) * datediff(MAX(us.last_login_at)- MIN(us.created_at)) AS ltv
FROM user_signup us
JOIN user_offer_completion uoc ON us.user_id = uoc.user_id
JOIN rewards_details ON uoc.offer_id = r.offer_id
GROUP BY us.utm_source;