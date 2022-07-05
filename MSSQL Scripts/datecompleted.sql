/****** Script for SelectTopNRows command from SSMS  ******/
with cte as (
SELECT  [mve_gkey],acv.id 'Vesse Visit'
      ,[move_kind],acv.gkey,inv.carrier_gkey
      ,[ufv_gkey]
      ,[line_op]
      ,[carrier_gkey] as 'Pkey',
	  acv.cvcvd_gkey 'acv_cvcvdgkey',
	  avd.gkey as 'avd_gkey',
     avd.[time_discharge_complete]
	  ,t_put as tp,acv.phase as Phase,acv.carrier_mode

    
  FROM [sparcsn4].[dbo].[inv_move_event] inv, argo_carrier_visit acv ,argo_visit_details avd
     where move_kind='DSCH' and acv.gkey=inv.carrier_gkey and acv.phase NOT IN ('10CREATED','80CANCELED','90ARCHIVED') 
	 and avd.gkey=acv.cvcvd_gkey
  and acv.ata>='06-01-2020' 
  )







  select distinct  [Vesse Visit],[time_discharge_complete]
  ,'New Discharge Complete'=max(tp)  OVER(PARTITION BY Pkey ),carrier_mode,acv_cvcvdgkey,avd_gkey
  

  from cte 
 order by [Vesse Visit],[New Discharge Complete]
