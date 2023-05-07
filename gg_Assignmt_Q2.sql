-- offer Initiation by users
with t1 as
(select us.app_id, uo.user_id,count(uo.offer_id) as total from q2_user_offer_data as uo
JOIN q2_users_signup as us on uo.user_id= us.user_id
GROUP BY user_id)
SELECT app_id, sum(total) as num_offers_initiated
from t1
GROUP BY app_id ;

-- Offer Completion by users
with t2 as
(select user_id 
from q2_user_offer_data 
where status = "completed" 
  GROUP BY user_id
)
SELECT app_id, count(*)
 from q2_users_signup
 where user_id in (SELECT * from t2)
 GROUP BY 1;
 
-- Rewards earned by users and Revenue generated

select  sum(rd.total_payout_in_paise) as payout, sum(rd.total_revenue_in_paise) as revenue, oc.app_id from q2_rewards_details as rd
join q2_user_offer_completion_data as oc
on rd.reward_id=oc.reward_id
GROUP BY oc.app_id