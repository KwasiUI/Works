/****** Script for SelectTopNRows command from SSMS  ******/
with cte as (SELECT cue.gkey,ib_intended_id
	  ,equipment_id,eq_length,
      --,time_load,
	  event_start_time
	  ,flex_string01,avd.time_discharge_complete as 'Discharge Complete'
	   ,ufv_time_in,
      ufv_time_out
	  ,'Dwell days'= case when (DATEDIFF(MINUTE, cue.ufv_time_in,cue.ufv_time_out) > 0) and (DATEDIFF(day, cue.ufv_time_in,cue.ufv_time_out)<1) then 1
	  else DATEDIFF(day, cue.ufv_time_in,cue.ufv_time_out) end,

	 'Size'=case when eq_length='NOM20' then '20' else '40' end

      FROM argo_chargeable_unit_events cue join argo_carrier_visit acv on cue.ib_intended_id=acv.id 
		join  argo_visit_details avd on avd.gkey=acv.cvcvd_gkey 

		where
			event_type='Reefer' and category='IMPRT' --and flex_string01 in ('RFT','RFY')
			and ufv_time_out>='06-01-2020' 
)
select  ib_intended_id as 'Vessel', equipment_id as'Container',flex_string01 as 'Group Code',eq_length ,Size,
		ufv_time_in as 'Unit In' ,ufv_time_out as 'Unit Out',[Discharge Complete],[Dwell days]

from cte

order by  [Unit Out]  -- [Dwell days] desc
