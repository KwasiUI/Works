with FLAGLIFT as(
 SELECT    carrier_gkey,mve_gkey,me.che_qc, move_kind,se.flex_string01 as Flag,
'MoveTime' =
      CASE
         WHEN me.move_kind =  'DSCH' THEN me.t_fetch
           ELSE me.t_put
      END, 

'LastLift'=min(
      CASE
         WHEN me.move_kind =  'DSCH'  and se.flex_string01='LL' THEN me.t_fetch
		 WHEN me.move_kind =  'LOAD'  and se.flex_string01='LL' THEN me.t_put
         
      END) OVER(PARTITION BY carrier_gkey, che_qc ORDER BY carrier_gkey, che_qc )

      
  FROM [sparcsn4].[dbo].[inv_move_event] me, 
       [sparcsn4].[dbo].inv_unit_fcy_visit ufv,
          [sparcsn4].[dbo].[srv_event] se 
		,[argo_carrier_visit] av 


  where (me.move_kind = 'DSCH' 
        OR 
        me.move_kind = 'LOAD'  )

	 and se.flex_string01 in( 'LL','FL')
  and ufv.unit_gkey = se.applied_to_gkey
  and ufv.gkey = me.ufv_gkey
  and me.move_kind in ('LOAD','DSCH')
  and av.gkey=carrier_gkey
 and av.phase = '40WORKING'
  ),
  Lastlift_movetime_join as(
  SELECT FL.carrier_gkey, FL.che_qc,LastLift,'MoveTimestamp' =
      CASE
         WHEN me.move_kind =  'DSCH' THEN me.t_fetch
           ELSE me.t_put
      END 
	  
	   FROM FLAGLIFT FL,[inv_move_event] me WHERE
  
        (me.move_kind = 'DSCH'          
        OR 
        me.move_kind = 'LOAD'                 
      )
	
		and me.move_kind in ('LOAD','DSCH') and FL.carrier_gkey=me.carrier_gkey
  
 )
 select distinct carrier_gkey,che_qc,LastLift,'FirstLift'=
min(
      CASE
         WHEN MoveTimestamp>Lastlift then MoveTimestamp
          
      END)OVER(PARTITION BY carrier_gkey, che_qc ORDER BY carrier_gkey, che_qc )

 from Lastlift_movetime_join