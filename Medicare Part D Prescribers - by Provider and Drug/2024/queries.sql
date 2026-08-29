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