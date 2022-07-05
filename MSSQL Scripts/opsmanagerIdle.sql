/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  acv.id as 'Vessel Visit',
		acv.phase as 'Vessel Phase'
		,[off_port_arr] as 'First Line'
        ,[off_port_dep] as 'Last Line',
	    acv.atd
       ,[time_discharge_complete],
	   'IDLE TIME DEPATURE'=datediff(MINUTE,[time_discharge_complete],[off_port_dep])
	   ,[labor_on_board]
       ,[labor_off_board],[start_work]
       ,[end_work]
	   
	  FROM [sparcsn4].[dbo].[argo_visit_details] avd 
	  join argo_carrier_visit acv on avd.gkey=acv.cvcvd_gkey
	  join vsl_vessel_visit_details vvd on vvd.vvd_gkey=acv.cvcvd_gkey
	  where eta>='06-01-2022' and acv.phase NOT IN ('10CREATED','80CANCELED','90ARCHIVED','20INBOUND') 
	  order by  datediff(MINUTE,[time_discharge_complete],[off_port_dep]) desc