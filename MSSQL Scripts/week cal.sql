select acv.id as 'Vessel' ,count(mve_gkey)
from argo_carrier_visit acv join inv_move_event me on acv.gkey=me.carrier_gkey
where acv.carrier_mode='Vessel' and me.move_kind in ('Load','Dsch') and (acv.ata>='05-01-2022' and acv.ata<='05-31-2022')
and acv.id in ('MDAN22221E','MCAL22219N','SANT22218N','MIYO22215W','MNUR22220R','MROW22220R','MCOL22221N','KSAT22057E','AWYO22ACIN','KSEJ22057E','CCLE22DOE1','CCHV22221R')
group by acv.id 

