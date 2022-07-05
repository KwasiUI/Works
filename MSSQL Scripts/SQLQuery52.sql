/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Creator
      ,[placed_time],
	  'Reefer Setting Recorded' as 'Event Type'
      ,[applied_to_natural_key],
     'Created Day'=  cast(created as date)
  FROM [sparcsn4].[dbo].[srv_event] where event_type_gkey=148 and 
  (created >= DATEADD(month, -4, GETDATE()))  and (placed_by not like 'camco%') and  (placed_by not like 'xps%')
