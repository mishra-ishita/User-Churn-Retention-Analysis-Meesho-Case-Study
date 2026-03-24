create database apm;
use apm;

-- check row counts
select count(*) as total_users from users;
select count(*) as total_sessions from sessions;
select count(*) as total_orders from orders;

-- check date ranges
select min(registration_date) as earliest_signup, max(registration_date) as latest_signup from users;
select min(order_date) as first_order, max(order_date) as last_order from orders;

-- check for null values
select 
    count(*) as total_rows,
    sum(case when user_id is null then 1 else 0 end) as null_user_id,
    sum(case when city is null then 1 else 0 end) as null_city,
    sum(case when is_churned is null then 1 else 0 end) as null_churn,
    sum(case when churn_reason is null then 1 else 0 end) as null_reason
from users;

-- query 1: overall churn rate
select 
    count(*) as total_users, 
    sum(is_churned) as churned_users, 
    count(*) - sum(is_churned) as retained_users,
    round(sum(is_churned) * 100.0 / count(*), 1) as churn_rate_pct, 
    round((count(*) - sum(is_churned)) * 100.0 / count(*), 1) as retention_rate_pct 
from users;

-- query 2: one-time vs repeat buyers
select
    count(distinct u.user_id) as total_buyers,
    sum(case when o.order_count = 1 then 1 else 0 end) as one_time_buyers,
    sum(case when o.order_count > 1 then 1 else 0 end) as repeat_buyers,
    round(sum(case when o.order_count = 1 then 1 else 0 end) * 100.0 / count(distinct u.user_id), 1) as one_time_buyer_pct,
    round(sum(case when o.order_count > 1 then 1 else 0 end) * 100.0 / count(distinct u.user_id), 1) as repeat_buyer_pct
from users u
join (
    select user_id, count(*) as order_count
    from orders
    group by user_id
) o on u.user_id = o.user_id;

-- users who never ordered
select
    count(*) as total_users,
    sum(case when o.user_id is null then 1 else 0 end) as never_ordered,
    round(sum(case when o.user_id is null then 1 else 0 end) * 100.0 / count(*), 1) as never_ordered_pct
from users u
left join (
    select distinct user_id from orders
) o on u.user_id = o.user_id;

-- query 3: churn reason breakdown
select
    churn_reason,
    count(*) as users,
    round(count(*) * 100.0 / sum(count(*)) over(), 1) as pct_of_churned
from users
where is_churned = 1 and churn_reason is not null
group by churn_reason
order by users desc;

-- check null distribution in churn_reason
select
    case 
        when is_churned = 0 then 'retained user (null expected)'
        when is_churned = 1 and churn_reason is null then 'churned but reason missing (problem!)'
        when is_churned = 1 and churn_reason is not null then 'churned with reason (good)'
    end as status,
    count(*) as users
from users
group by status;

-- query 4: average orders per user — churned vs retained
select
    case when u.is_churned = 1 then 'churned' else 'retained' end as user_type,
    count(distinct u.user_id) as total_users,
    count(o.order_id) as total_orders,
    round(count(o.order_id) * 1.0 / count(distinct u.user_id), 1) as avg_orders_per_user,
    round(avg(o.gmv), 0) as avg_gmv_per_order,
    round(sum(o.gmv) / count(distinct u.user_id), 0) as avg_revenue_per_user
from users u
left join orders o on u.user_id = o.user_id
group by u.is_churned;

-- query 5: business impact of churn in rupees
select
    round(avg(case when u.is_churned = 0 then user_rev end), 0) as avg_revenue_retained_user,
    round(avg(case when u.is_churned = 1 then user_rev end), 0) as avg_revenue_churned_user,
    round(avg(case when u.is_churned = 0 then user_rev end) - avg(case when u.is_churned = 1 then user_rev end), 0) as revenue_gap_per_user,
    count(case when u.is_churned = 1 then 1 end) as total_churned_users,
    round((avg(case when u.is_churned = 0 then user_rev end) - avg(case when u.is_churned = 1 then user_rev end)) * count(case when u.is_churned = 1 then 1 end), 0) as total_revenue_lost
from users u
left join (
    select user_id, sum(gmv) as user_rev
    from orders
    group by user_id
) rev on u.user_id = rev.user_id;

-- query 6: churn rate by city
select
    city,
    count(*) as total_users,
    sum(is_churned) as churned,
    round(sum(is_churned) * 100.0 / count(*), 1) as churn_rate_pct,
    round(avg(case when is_churned = 0 then 1.0 else 0 end) * 100, 1) as retention_rate_pct
from users
group by city
order by churn_rate_pct desc;

-- query 7: churn rate by acquisition channel
select
    acquisition_channel,
    count(*) as total_users,
    sum(is_churned) as churned_users,
    round(sum(is_churned) * 100.0 / count(*), 1) as churn_rate_pct
from users
group by acquisition_channel
order by churn_rate_pct desc;

-- query 8: churn rate by device type
select
    device_type,
    count(*) as total_users,
    sum(is_churned) as churned_users,
    round(sum(is_churned) * 100.0 / count(*), 1) as churn_rate_pct
from users
group by device_type
order by churn_rate_pct desc;

-- query 9: churn rate by age group
select
    case 
        when age between 18 and 24 then '18-24'
        when age between 25 and 34 then '25-34'
        when age between 35 and 44 then '35-44'
        else '45+'
    end as age_group,
    count(*) as total_users,
    sum(is_churned) as churned_users,
    round(sum(is_churned) * 100.0 / count(*), 1) as churn_rate_pct
from users
group by age_group
order by churn_rate_pct desc;

-- query 10: impact of delivery days on churn
select
    delivery_days,
    count(distinct o.user_id) as users,
    round(avg(u.is_churned) * 100, 1) as churn_rate_pct,
    round(avg(o.rating), 2) as avg_rating,
    round(avg(o.is_returned) * 100, 1) as return_rate_pct
from orders o
join users u on o.user_id = u.user_id
group by delivery_days
order by delivery_days;

-- query 11: impact of delivery fee on churn
select
    case
        when delivery_fee = 0  then 'free delivery'
        when delivery_fee <= 29 then 'low fee (₹1-29)'
        when delivery_fee <= 39 then 'mid fee (₹30-39)'
        else 'high fee (₹40+)'
    end as fee_bucket,
    count(distinct o.user_id) as users,
    round(avg(u.is_churned) * 100, 1) as churn_rate_pct,
    round(avg(o.gmv), 0) as avg_order_value
from orders o
join users u on o.user_id = u.user_id
group by fee_bucket
order by churn_rate_pct desc;

-- query 12: churn rate by first order rating
select
    first_rating,
    count(*) as users,
    round(avg(is_churned) * 100, 1) as churn_rate_pct
from (
    select
        u.user_id,
        u.is_churned,
        o.rating as first_rating
    from users u
    join orders o on u.user_id = o.user_id
    where o.order_number = 1
) first_orders
group by first_rating
order by first_rating;

-- query 13: churned vs retained session behaviour
select
    case when u.is_churned = 1 then 'churned' else 'retained' end as user_type,
    round(avg(s.duration_seconds), 0) as avg_session_duration_sec,
    round(avg(s.pages_viewed), 1) as avg_pages_viewed,
    round(avg(s.added_to_cart) * 100, 1) as cart_add_rate_pct,
    round(avg(s.converted) * 100, 1) as conversion_rate_pct
from users u
join sessions s on u.user_id = s.user_id
group by u.is_churned;

-- query 14: cohort retention by month
select
    cohort_month,
    max(case when months_since_first = 0 then cohort_size end) as cohort_size,
    max(case when months_since_first = 1 then retention_rate end) as month_1_retention,
    max(case when months_since_first = 2 then retention_rate end) as month_2_retention,
    max(case when months_since_first = 3 then retention_rate end) as month_3_retention
from cohort_retention
group by cohort_month
order by cohort_month;

-- query 15: rfm segment breakdown
select
    segment,
    count(*) as users,
    round(count(*) * 100.0 / sum(count(*)) over(), 1) as pct_of_users,
    round(avg(monetary), 0) as avg_revenue,
    round(avg(frequency), 1) as avg_orders,
    round(avg(recency_days), 0) as avg_days_since_last_order
from rfm_segments
group by segment
order by avg_revenue desc;

-- query 16: revenue at stake by rfm segment
select
    segment,
    count(*) as users,
    round(sum(monetary), 0) as total_revenue,
    round(avg(monetary), 0) as avg_revenue_per_user
from rfm_segments
where segment in ('at risk', 'hibernating', 'champions', 'loyal customers')
group by segment
order by total_revenue desc;

