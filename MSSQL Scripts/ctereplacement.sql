
			 select distinct  Operator ID,Operator, TRUCK,min(timestamp)OVER (PARTITION BY WDAY,OPERATOR,TRUCK) 'LOG ON'
			 ,max(timestamp)OVER (PARTITION BY OPERATOR,TRUCK) 'LOG ON'
			 from 
			 
			 (SELECT  ece.operator_name as 'Operator ID', eu.name as 'Operator',ece.che_name AS 'TRUCK', 
timestamp,type_description, 'WDAY'=cast(ece.timestamp as date)
  from xps_ecevent ece join xps_ecuser eu  on ece.operator_name = eu.user_id
                
  where type_description in ('LGON','LGOF')
  and (
		 (che_name like 'A2%')  or (che_name like 'C3%' ) or (che_name like 'D0%')or (che_name like 'DJ%') or (che_name like 'E0%')
		 or (che_name like 'G2%') or (che_name like 'M0%')
	 )

		)a		
          		
