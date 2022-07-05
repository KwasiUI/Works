  with cte as(
 select eu.name as Driver,ime.mve_gkey,xch.short_name as Truck, 
 ime.t_carry_complete as ET,ime.t_carry_dispatch as ST,
 	'H'=  DATEPART(hour, t_carry_complete) , 
	'MDay'=  cast(ime.t_carry_complete as date)
        
 
 FROM [sparcsn4].[dbo].[inv_move_event] ime inner join  [xps_che] xch on Xch.gkey=Ime.che_carry inner join [xps_ecuser] eu
  on ime.che_carry_login_name = eu.user_id where Xch.operating_mode_enum='Truck' 
 and  t_carry_complete>'01-01-2022'
 )
 
select distinct Driver, Truck,MDay,H,
'Moves'=count(mve_gkey)OVER(PARTITION BY Driver,Truck,MDay,H),
'Start'=min(ST)OVER(PARTITION BY Driver,Truck,MDay,H),
'End'= max(ET)OVER(PARTITION BY Driver,Truck,MDay,H)
 from cte order by MDay,Truck


