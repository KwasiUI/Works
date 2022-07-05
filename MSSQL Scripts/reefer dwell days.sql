/****** Script for SelectTopNRows command from SSMS  ******/
with cte as (SELECT cue.gkey,ib_intended_id
	  ,cue.time_discharge_complete
      ,avd.time_discharge_complete as 'Vessel Discharge Complete'
	  ,equipment_id
      ,time_load,event_start_time,flex_string01
	  ,'Dwell days'=  DATEDIFF(day, avd.time_discharge_complete,cue.time_load)
	 

      FROM argo_chargeable_unit_events cue join argo_carrier_visit acv on cue.ib_intended_id=acv.id 
		join  argo_visit_details avd on avd.gkey=acv.cvcvd_gkey 
		where
			event_type='Reefer' and category='IMPRT' and flex_string01 in ('RFT','RFY')
			and time_load>='06-01-2020' 
)
select  ib_intended_id as 'Vessel', equipment_id as'Container',[Vessel Discharge Complete],time_load as 'Unit Deliver',[Dwell days]

from cte

order by [Dwell days] desc
