SELECT  DISTINCT acv.id 'Vessel Visit',acv.cvcvd_gkey 'vvd',
	(SELECT short_name FROM xps_che WHERE gkey=me.che_qc) 'Crane', (SELECT gkey FROM xps_che WHERE gkey=me.che_qc) 'CraneGkey',
	(SELECT sum(minutes) FROM vsl_crane_activity WHERE vv_gkey=acv.cvcvd_gkey AND crane_gkey = (SELECT gkey FROM xps_che WHERE gkey=me.che_qc)
	and crane_delay_type_gkey in (28,27,24,22,21,19,18,17,12,6,5,3)) 'Deductible Delay',
	(SELECT COUNT(mve_gkey) FROM inv_move_event me1 WHERE me1.carrier_gkey=me.carrier_gkey AND me1.che_qc = me.che_qc) 'MoveCount',
	(SELECT MIN(CASE
         WHEN move_kind =  'DSCH' THEN t_fetch
           ELSE t_put
      END) FROM inv_move_event me1 WHERE me1.carrier_gkey=me.carrier_gkey AND me1.che_qc = me.che_qc) 'FirstLift',
	(SELECT MAX(CASE
         WHEN move_kind =  'DSCH' THEN t_fetch
           ELSE t_put
      END) FROM inv_move_event me1 WHERE me1.carrier_gkey=me.carrier_gkey AND me1.che_qc = me.che_qc) 'LastLift'
FROM inv_move_event me
join argo_carrier_visit acv on me.carrier_gkey=acv.gkey
WHERE me.move_kind in ('LOAD','DSCH') and t_put>= '01-01-2022' and acv.carrier_mode='Vessel' 
and (SELECT COUNT(mve_gkey) FROM inv_move_event me1 WHERE me1.carrier_gkey=me.carrier_gkey AND me1.che_qc = me.che_qc)>0

ORDER BY acv.id


