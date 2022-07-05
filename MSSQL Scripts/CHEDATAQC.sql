
 with cte as(
 select ime.che_fetch_login_name as Staff_id,concat (be.buser_firstName,' ',be.buser_lastName)  as Operator, ime.mve_gkey,xch.short_name as CHE, be.buser_userid,
 'Timestamp'= ime.t_fetch ,
 	'H'=  DATEPART(hour, ime.t_fetch) , 
	'MDay'=  cast(ime.t_fetch as date)
        
 FROM [sparcsn4].[dbo].[inv_move_event] ime join  [xps_che] xch on ime.che_fetch=xch.gkey 
  join base_user be on ime.che_fetch_login_name=be.buser_userid
 where   t_fetch >= '01-01-2022' 


  union all 

 select ime.che_put_login_name as Staff_id,concat (be.buser_firstName,' ',be.buser_lastName) as  Operator, ime.mve_gkey,xch.short_name as CHE,  be.buser_userid,
 'Timestamp'= ime.t_put ,
 	'H'=  DATEPART(hour, ime.t_put), 
	'MDay'= cast(ime.t_put as date)
         
 FROM [sparcsn4].[dbo].[inv_move_event] ime  join  [xps_che] xch on ime.che_put=xch.gkey 
 join base_user be on ime.che_put_login_name=be.buser_userid
 where   t_put >= '01-01-2022' 
 ),
 CHEDATA AS(
  select distinct CHE, MDay,H,'Work Hours'=1.0,
'Moves'=count(mve_gkey)OVER(PARTITION BY  CHE,MDay,H),
 'Start'=min(TimeStamp)OVER(PARTITION BY  CHE,MDay,H),
'End'= max(TimeStamp)OVER(PARTITION BY  CHE,MDay,H)
 from CTE  
 )
 SELECT * FROM CHEDATA order by MDay, CHE

