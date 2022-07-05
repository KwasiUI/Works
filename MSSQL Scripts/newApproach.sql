select distinct  name,staff_id,che,just_day,
'Start_Time'=min(TimeStamp)OVER(PARTITION BY name,che,just_day ),
'End_Time'= max(TimeStamp)OVER(PARTITION BY name,che,just_day ),
'Move_Count'=count(mve_gkey)OVER(PARTITION BY name,che,just_day) 

from (
SELECT ime.che_fetch_login_name as Staff_id,[mve_gkey],[move_kind],xe.name as name ,xch.short_name as CHE,xch.gkey

       ,'TimeStamp'= CASE
        WHEN ime.che_fetch_login_name is NULL THEN ime.t_put 
        WHEN ime.che_fetch_login_name is not null THEN ime.t_fetch 
      END
	  ,'just_day'= CASE
         WHEN ime.che_fetch_login_name is NULL THEN cast(ime.t_put as date) 
        WHEN ime.che_fetch_login_name is not null THEN cast(ime.t_fetch as date)
      END

	 


  FROM [sparcsn4].[dbo].[inv_move_event] ime , [xps_ecuser] xe, [xps_che] xch where ime.che_fetch_login_name=xe.user_id
  AND ime.che_fetch=xch.gkey and (ime.t_fetch >= DATEADD(month, -8, getdate()))
  
  union all

  SELECT  ime.che_put_login_name as Staff_id,[mve_gkey],[move_kind],xe.name as name ,xch.short_name as CHE,xch.gkey

       ,'TimeStamp'= CASE
         WHEN ime.che_put_login_name is NULL THEN ime.t_fetch
       WHEN ime.che_put_login_name is not null THEN ime.t_put 
      END

	   ,'just_day'= CASE
          WHEN ime.che_put_login_name is NULL THEN cast(ime.t_fetch as date)
         WHEN ime.che_put_login_name is not null THEN cast(ime.t_put as date)
      END


  FROM [sparcsn4].[dbo].[inv_move_event] ime ,  [xps_ecuser] xe, [xps_che] xch where ime.che_put_login_name=xe.user_id
  AND ime.che_put=xch.gkey and (ime.t_fetch >= DATEADD(month, -8, getdate()))
)A