with cte as 
(
SELECT  ime.che_fetch_login_name as Staff_id,mve_gkey,xe.name as name ,xch.short_name as CHE,xch.gkey,

      'Duration_per_Moves'= CASE
        WHEN ime.che_fetch_login_name is not null and move_kind= 'DSCH' then DATEDIFF(s,t_dispatch,t_put)
		WHEN ime.che_fetch_login_name is not null and move_kind= 'RECV' then DATEDIFF(s,t_dispatch,t_put)
		WHEN ime.che_fetch_login_name is not null and move_kind= 'DLVR' then DATEDIFF(s,t_dispatch,t_put)
		WHEN ime.che_fetch_login_name is not null and move_kind= 'LOAD' then DATEDIFF(s,t_dispatch,t_carry_fetch_ready)
      --  WHEN ime.che_fetch_login_name is not null THEN ime.t_fetch 
      END,

	  'just_day'= CASE
         WHEN ime.che_fetch_login_name is NULL THEN cast(ime.t_put as date) 
        WHEN ime.che_fetch_login_name is not null THEN cast(ime.t_fetch as date)
      END,

	 -- 'Move_Count'=count(mve_gkey)OVER(PARTITION BY xe.name,DATEPART(hour, ime.t_fetch),xch.short_name,cast(ime.t_fetch as date)),

	--'Time_hour'= DATEPART(hour, ime.t_fetch)
	
	
  FROM [sparcsn4].[dbo].[inv_move_event] ime , [xps_ecuser] xe, [xps_che] xch where ime.che_fetch_login_name=xe.user_id
  AND ime.che_fetch=xch.gkey and (ime.t_fetch >= DATEADD(month, -8, getdate()))


  union all

  SELECT  ime.che_put_login_name as Staff_id,mve_gkey,xe.name as name ,xch.short_name as CHE,xch.gkey,

      'Duration_per_Moves'= CASE
        WHEN ime.che_put_login_name is not null and move_kind= 'DSCH' then DATEDIFF(s,t_dispatch,t_put)
		WHEN ime.che_put_login_name is not null and move_kind= 'RECV' then DATEDIFF(s,t_dispatch,t_put)
		WHEN ime.che_put_login_name is not null and move_kind= 'DLVR' then DATEDIFF(s,t_dispatch,t_put)
		WHEN ime.che_put_login_name is not null and move_kind= 'LOAD' then DATEDIFF(s,t_dispatch,t_carry_put_ready)
      --  WHEN ime.che_fetch_login_name is not null THEN ime.t_fetch 
      END,

	
	   'just_day'= CASE
          WHEN ime.che_put_login_name is NULL THEN cast(ime.t_fetch as date)
         WHEN ime.che_put_login_name is not null THEN cast(ime.t_put as date)
      END,

	 -- 'Move_Count'=count(mve_gkey)OVER(PARTITION BY xe.name,DATEPART(hour, ime.t_fetch),xch.short_name,cast(ime.t_fetch as date)),

	'Time_hour'= DATEPART(hour, ime.t_put)
	
	
  FROM [sparcsn4].[dbo].[inv_move_event] ime , [xps_ecuser] xe, [xps_che] xch where ime.che_put_login_name=xe.user_id
  AND ime.che_put=xch.gkey and (ime.t_put >= DATEADD(month, -8, getdate()))

 )
 select   distinct  name,staff_id,che,Time_hour,just_day,
 'Move_count'=count(mve_gkey)OVER(PARTITION BY name,Time_hour,che,just_day)
,'Duration'=sum(Duration_per_Moves)OVER(PARTITION BY name,Time_hour,che,just_day)

from  cte order by name,just_day,Time_hour


SELECT [gkey]
      ,[absolute_start_time]
      ,[positioning_obj]
      ,[duration]
      ,[user_defined]
  FROM [sparcsn4].[dbo].[xps_craneactivity]
  WHERE [absolute_start_time] >= DATEADD(minute, 1140, DATEADD(day, DATEDIFF(day, '', GETDATE())-1, '')) AND [absolute_start_time] < DATEADD(hour, 7, DATEADD(day, DATEDIFF(day, '', GETDATE()), ''))
  ORDER BY [absolute_start_time] asc