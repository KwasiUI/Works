with cte as( SELECT distinct  acv.id as 'Vessel Visit',
		acv.phase as 'Vessel Phase'
		,vvd.[off_port_arr] as 'First Line'
        ,vvd.[off_port_dep] as 'Last Line'
		,mve_gkey,'MoveTime' =
      CASE
         WHEN me.move_kind =  'DSCH' THEN me.t_fetch
           ELSE me.t_put
      END
		 
	   
	  FROM [sparcsn4].[dbo].[argo_visit_details] avd 
	  join argo_carrier_visit acv on avd.gkey=acv.cvcvd_gkey
	  join inv_move_event me on   me.carrier_gkey=acv.gkey
	  join vsl_vessel_visit_details vvd on vvd.vvd_gkey=acv.cvcvd_gkey
	  where ata>='01-01-2022' and acv.phase NOT IN ('10CREATED','80CANCELED','90ARCHIVED','20INBOUND','30ARRIVED') 
	 ),

	 data as( select distinct [Vessel Visit],[First Line],[Last Line],
	 'First Lift'=min(MoveTime) OVER(PARTITION BY[Vessel Visit]),
	'Last Lift'=max(MoveTime) OVER(PARTITION BY[Vessel Visit])--,
	  from cte 
	  )
	 select [Vessel Visit],[First Line],[Last Line],[First Lift],[Last Lift] 
	 ,'Idle Time Depature'= DATEDIFF(MINUTE,[Last Lift],[Last Line])
	 ,'Idle Arrival Depature'= DATEDIFF(MINUTE,[First Line],[First Lift])
	 from data