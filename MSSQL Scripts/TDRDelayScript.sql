/****** Script for SelectTopNRows command from SSMS  ******/

--delays check--
SELECT  a.[gkey]
      ,[total_moves]
      ,[vvd_gkey]
      ,[crane_gkey]
	  ,b.time
  FROM [sparcsn4].[dbo].[vsl_crane_statistics] a,[sparcsn4].[dbo].[vsl_crane_statistics_delays] b
   
where a.gkey=b.cstat_gkey and a.vvd_gkey='2676868'



--total delays for MSIN222007R
SELECT  sum(b.time)/60000
  FROM [sparcsn4].[dbo].[vsl_crane_statistics] a,[sparcsn4].[dbo].[vsl_crane_statistics_delays] b
   
where a.gkey=b.cstat_gkey and a.vvd_gkey='2676868'


--total delays for MSIN222007R
SELECT  sum(b.time)/60000
  FROM [sparcsn4].[dbo].[vsl_crane_statistics] a,[sparcsn4].[dbo].[vsl_crane_statistics_delays] b, [sparcsn4].[dbo].[ref_crane_delay_types] c
  where a.gkey=b.cstat_gkey and c.gkey=b.crane_delay_type_gkey and  a.vvd_gkey='2676868'
  group by c.delay_category
