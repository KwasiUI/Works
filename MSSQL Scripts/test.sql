/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct av.[gkey],ag.cvcvd_gkey,ag.id,[eta],[etd]
      ,[time_discharge_complete]
  FROM [sparcsn4].[dbo].[argo_visit_details] av left join  argo_carrier_visit ag on av.gkey=ag.cvcvd_gkey
  left join inv_move_event inv on ag.gkey=inv.carrier_gkey
  where ata>='06-01-2020'
  and time_discharge_complete is null
  and move_kind='DSCH' and  ag.phase NOT IN ('10CREATED','80CANCELED','90ARCHIVED') 
  and ag.carrier_mode='Vessel'

