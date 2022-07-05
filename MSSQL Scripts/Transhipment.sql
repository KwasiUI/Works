select un.id  as 'Unit CONTAINER',rout.id as 'POD' ,me.move_kind as 'MOVE KIND',bzu.id as 'Line Operator',un.category,me.t_put as 'TIME COMPLETED',eqt.nominal_length as 'Length',eq.id_full as 'Eq Container'
,'Date'=  cast(me.t_put as date)
,'TEU Count'= case when eqt.nominal_length='NOM20' then 1 else 2 end ,
'Move Count'=1
from inv_move_event me join inv_unit_fcy_visit fv on fv.gkey=me.ufv_gkey 
join inv_unit un on un.gkey=fv.unit_gkey join ref_routing_point rout on un.pod1_gkey=rout.gkey
join ref_bizunit_scoped bzu on un.line_op=bzu.gkey
join ref_equipment eq on un.eq_gkey =eq.gkey
JOIN ref_equip_type eqt on eq.eqtyp_gkey=eqt.gkey


where   un.category='TRSHP'
	and  me.t_put>='06-15-2022'
	and me.move_kind in ('LOAD','DSCH')
	--order by me.t_put desc
