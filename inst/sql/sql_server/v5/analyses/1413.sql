-- 1413	Number of persons by number of payer plan periods

--HINT DISTRIBUTE_ON_KEY(analysis_id)
select 1413 as analysis_id,  
	CAST(ppp1.num_periods AS VARCHAR(255)) as stratum_1,
	null as stratum_2, null as stratum_3, null as stratum_4, null as stratum_5,
	COUNT_BIG(distinct p1.PERSON_ID) as count_value
into @scratchDatabaseSchema@schemaDelim@tempAchillesPrefix_1413
from
	@cdmDatabaseSchema.PERSON p1
	inner join (select person_id, COUNT_BIG(payer_plan_period_start_date) as num_periods from @cdmDatabaseSchema.payer_plan_period group by PERSON_ID) ppp1
	on p1.person_id = ppp1.person_id
group by ppp1.num_periods
;