with cte as(select distinct  [Vessel Visit],Crane, [vvd],[Che Key],
'moves'= count(mve_gkey)OVER(PARTITION BY [Vessel Visit],Crane) ,
--'loads'=case when kind = 'DSCH' then COUNT(mve_gkey)OVER(PARTITION BY [Vessel Visit],Crane) end,
--'Discharge'=case when kind = 'Load' then COUNT(mve_gkey)OVER(PARTITION BY  [Vessel Visit],Crane) end,
'First Lift'=min(movetime) OVER(PARTITION BY[Vessel Visit],Crane),
'Last Lift'=max(movetime) OVER(PARTITION BY[Vessel Visit],Crane)--,
--'delays'=(select sum(minutes)from vsl_crane_activity vca join  argo_carrier_visit acv  on vca.vv_gkey=acv.cvcvd_gkey join xps_che che on che.gkey=vca.crane_gkey )

from ( select distinct me.mve_gkey,acv.id 'Vessel Visit',acv.cvcvd_gkey 'vvd', che.short_name 'Crane',che.gkey 'Che Key',me.move_kind 'kind',   
'MoveTime' =
      CASE
         WHEN me.move_kind =  'DSCH' THEN me.t_fetch
           ELSE me.t_put
      END

from 
inv_move_event me join argo_carrier_visit acv on me.carrier_gkey=acv.gkey
join xps_che che on che.gkey=me.che_qc 
join vsl_crane_activity vca on vca.vv_gkey=acv.cvcvd_gkey and che.gkey=vca.crane_gkey
join ref_crane_delay_types rcd on rcd.gkey=vca.crane_delay_type_gkey 
where move_kind in ('LOAD','DSCH') and t_put>= '01-01-2022'
)a)
select [Vessel Visit],Crane,moves,[vvd],[Che Key],[First Lift],[Last Lift],
'Work Hours'= datediff(SECOND,[First Lift],[Last Lift])/3600.0--, 
--'GMPH'=case when (moves/(datediff(SECOND,[First Lift],[Last Lift])/3600.0))<0 then 0
--else (moves/(datediff(SECOND,[First Lift],[Last Lift])/3600.0))end 
from cte