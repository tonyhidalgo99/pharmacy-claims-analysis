## 8-29-26 Tot_Benes suppression
Noticed ~54.5% of rows have NULL Tot_Benes (15,265,060 of 28,023,892). Confirmed this is CMS suppressing beneficiary counts under 11 for privacy — expected, given the data is granular (one row per prescriber/drug), so most combos naturally involve few patients.

Checked whether suppressed rows are also low-volume in general:

```
SELECT MIN(Tot_Clms), MAX(Tot_Clms), AVG(Tot_Clms)
FROM claims WHERE Tot_Benes IS NULL;
-- min 11, max 625, avg ~20.6
```

Not necessarily — max of 625 claims on a suppressed row. Pulled it up: clozapine, which requires weekly blood monitoring, so it's dispensed in short cycles instead of a normal 30-day fill. Few patients + weekly fills = high claim count.

Checked the top 20 suppressed rows by claims and found common maintenance drugs (simvastatin, pravastatin, warfarin, gabapentin) with no monitoring requirement, also showing high claim counts. Days' supply per claim (Tot_Day_Suply / Tot_Clms) averaged ~5 days — pointed to long-term care short-cycle dispensing (nursing facilities dispensing in 7-day increments to cut waste).

Takeaway: suppressed ≠ low-volume. Can't drop/zero-out NULL Tot_Benes rows in cost-per-claim analysis without losing over half the table — need a real plan for handling them.
