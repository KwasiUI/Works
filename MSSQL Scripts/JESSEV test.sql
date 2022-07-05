with cte as (select distinct un.id as 'Container', acv.id as  'Vessel Visit', fcy.time_out as 'Time Out',fcy.time_load 'Unit Deliver',avd.time_discharge_complete as 'Vessel Discharge Complete',
'Dwell days'= case when  DATEDIFF(day, time_discharge_complete,fcy.time_load)< 0 then 0 else DATEDIFF(day, time_discharge_complete,fcy.time_load) end,un.flex_string01 as 'Group Codes'
from inv_unit un join inv_unit_fcy_visit fcy on  un.gkey=fcy.unit_gkey
join inv_move_event me on fcy.gkey= me.ufv_gkey 
join srv_event se on fcy.unit_gkey = se.applied_to_gkey
join argo_carrier_visit acv on acv.gkey =me.carrier_gkey 
join argo_visit_details avd on avd.gkey=acv.cvcvd_gkey

where un.category='IMPRT' 
and se.event_type_gkey=32 and 
acv.carrier_mode='Vessel' and   time_load>='06-01-2020' 
)

select * from cte 
where [Dwell days]>0 
and [Group Codes] in ('RFY','RFT')
order by [Dwell days] desc
