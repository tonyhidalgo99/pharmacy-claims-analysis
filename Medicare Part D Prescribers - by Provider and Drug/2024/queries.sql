-- Top 10 states by total drug cost (all drugs combined)
SELECT
	Prscrbr_State_Abrvtn,
	SUM(Tot_Drug_Cst) AS total_cost
FROM claims
GROUP BY Prscrbr_State_Abrvtn
ORDER BY total_cost DESC
LIMIT 10;

-- Next: filter to CA, group by Gnrc_Name, find top-cost drugs
SELECT 
	