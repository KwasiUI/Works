 select count(*) as Totals from road_truck_transactions
  where created  > '01-01-2022'
  and flex_string01='MPS'
  and status='COMPLETE'
  and sub_type='DI'


  with cte as (
  select truck_visit_gkey, count(*) as Totals from road_truck_transactions
  where created  > '01-01-2022'
  and flex_string01='MPS'
  and status='COMPLETE'
  and sub_type='DI'
  group by truck_visit_gkey
  having count(*)>1
  ) select count(*) as TwinMoves from cte

   ; with cte2 as (
  select truck_visit_gkey, count(*) as Totals from road_truck_transactions
  where created  > '01-01-2022'
  and flex_string01='MPS'
  and status='COMPLETE'
  and sub_type='DI'
  group by truck_visit_gkey
  having count(*) =1
  ) select count(*) as Single from cte2



