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
	Gnrc_Name,
	SUM(Tot_Drug_Cst) AS total_cost
FROM claims
WHERE Prscrbr_State_Abrvtn = 'CA'
GROUP BY Gnrc_Name
ORDER BY total_cost DESC
LIMIT 10;

--How CMS data is quantified for suppressed values 
SELECT
	COUNT(*)
FROM claims
WHERE Tot_Benes IS NULL;

SELECT COUNT(*)
FROM claims;

--Where Tot_Benes is NULL identify min, max, and average value of Tot_Clms
SELECT
	MIN(Tot_Clms),
	MAX(Tot_Clms),
	AVG(Tot_Clms)
FROM claims
WHERE Tot_Benes IS NULL;

--Max(Tot_Clms) is 625 and Tot_Benes IS NULL
SELECT
	*
FROM claims
WHERE Tot_Clms = 625 AND Tot_Benes IS NULL;

--Top 20 medications where Tot_Clms is high but Tot_Benes IS NULL
SELECT
	*
FROM claims
WHERE Tot_Benes IS NULL
ORDER BY Tot_Clms DESC
LIMIT 20;

--Determine percentage of records where Tot_Benes IS NULL
SELECT
	COUNT (*)
FROM claims
WHERE Tot_Benes IS NULL;

--Determine total number of records
SELECT
	COUNT (*) 
FROM claims;
--54.5% of dataset has Tot_Benes IS NULL

--Determine number of DISTINCT Prscrbr_Type
SELECT		
	COUNT (DISTINCT(Prscrbr_Type))
FROM claims;
--There are 182 DISTINCT specialties in dataset	

--Determine percentage of Tot_Benes IS NULL by Prscrbr_Type
SELECT
	Prscrbr_Type,
	COUNT (*) AS total_rows,
	SUM (CASE WHEN Tot_Benes IS NULL THEN 1 ELSE 0 END) AS null_count
FROM claims
GROUP BY Prscrbr_Type
ORDER BY null_count DESC;

--Before running next query, verify that there are no records with 0 Tot_Clms
SELECT
	COUNT (*)
FROM claims
WHERE Tot_Clms = 0;

--Determine cost_per_claim, which is Tot_Drug_Cst/Tot_Clms
SELECT
	Brnd_Name,
	Gnrc_Name,
	SUM (Tot_Drug_Cst),
	SUM (Tot_Clms),
	SUM(Tot_Drug_Cst)/SUM(Tot_Clms) AS cost_per_claim
FROM claims
GROUP BY Brnd_Name
ORDER BY cost_per_claim DESC
LIMIT 50;

--Determine highest cost medications, not per claim
SELECT
	Brnd_Name,
	Gnrc_Name,
	SUM (Tot_Drug_Cst) AS Total_drug_cost
FROM claims
GROUP BY Brnd_Name
ORDER BY Total_drug_cost DESC
LIMIT 50;

--Determine suppression rate by Prscrbr_Type
SELECT
	Prscrbr_Type,
	COUNT (*) AS total_rows,
	SUM (CASE WHEN Tot_Benes IS NULL THEN 1 ELSE 0 END) AS null_count,
	ROUND (SUM (CASE WHEN Tot_Benes IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT (*), 2) AS percentage 
FROM claims
GROUP BY Prscrbr_Type
ORDER BY total_rows DESC
LIMIT 20;