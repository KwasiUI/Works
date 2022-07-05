 with cte as(
 select ime.che_fetch_login_name as Staff_id, xe.name as Operator, ime.mve_gkey,xch.short_name as CHE, xe.user_id,
 'Timestamp'= ime.t_fetch ,
 	'H'=  DATEPART(hour, ime.t_fetch) , 
	'MDay'=  cast(ime.t_fetch as date)
        
 FROM [sparcsn4].[dbo].[inv_move_event] ime join  [xps_che] xch on ime.che_fetch=xch.gkey 
  join [xps_ecuser] xe on ime.che_fetch_login_name=xe.user_id 
 where   t_fetch >= '01-01-2022' and short_name not like 'QC%'


  union all 

 select ime.che_put_login_name as Staff_id,xe.name as Operator, ime.mve_gkey,xch.short_name as CHE,  xe.user_id,
 'Timestamp'= ime.t_put ,
 	'H'=  DATEPART(hour, ime.t_put), 
	'MDay'= cast(ime.t_put as date)
         
 FROM [sparcsn4].[dbo].[inv_move_event] ime  join  [xps_che] xch on ime.che_put=xch.gkey 
 join [xps_ecuser] xe on ime.che_put_login_name=xe.user_id 
 where   t_put >= '01-01-2022' and short_name not like 'QC%'
 ),
 CHEDATA AS(
  select distinct Staff_id, CHE, MDay,H,'Work Hours'=1.0,
'Moves'=count(mve_gkey)OVER(PARTITION BY staff_id, CHE,MDay,H),
 'Start'=min(TimeStamp)OVER(PARTITION BY staff_id, CHE,MDay,H),
'End'= max(TimeStamp)OVER(PARTITION BY staff_id, CHE,MDay,H)
 from CTE  
 )
 SELECT * FROM CHEDATA  order by MDay,CHE 