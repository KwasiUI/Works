  with cte as(
 select eu.name as Driver,ime.mve_gkey,move_kind,xch.short_name as Truck,eu.user_id,ime.che_carry_login_name ,xch.gkey,ime.che_carry,
 'Timestamp'= t_carry_complete,
 	'H'=  DATEPART(hour, t_carry_complete) , 
	'MDay'=  cast(ime.t_carry_complete as date)
        
 
 FROM [sparcsn4].[dbo].[inv_move_event] ime  join  [xps_che] xch on Xch.gkey=Ime.che_carry  full outer  join [xps_ecuser] eu
  on ime.che_carry_login_name = eu.user_id where Xch.operating_mode_enum='Truck' 
 and  t_carry_complete>'01-01-2022'
 )
 
select distinct  Truck,MDay,H,
'Moves'=count(mve_gkey)OVER(PARTITION BY Truck,MDay,H),
'Start'=min(Timestamp)OVER(PARTITION BY Truck,MDay,H),
'End'= max(Timestamp)OVER(PARTITION BY Truck,MDay,H)
 from cte order by MDay,Truck