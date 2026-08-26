# Pharmacy Claims Analysis (CMS Medicare Part D)

## Status:  In Progress (early state)

## Overview
Exploring 2024 CMS Medicare Part D prescriber and drug claims data using SQL, with a focus on cost-per-claim trends and beneficiary count patterns. This project is part of a self-directed transition from pharmacy practice into healthcare data analytics.

## Data Source
CMS Medicare Part D Prescribers - by Provider and Drug (2024)
https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider-and-drug

Raw file:  ~4GB CSV, 28M+ rows. Not included in this repo due to size.

## Tools
- SQL (SQLite via DB Browser for SQLite)
- Python and Excel planned as project develops

## Setup
1. Download the CSV from the CMS link above.
2. Load into a SQLite database (schema in 'queries.sql')
3. Table name used in this project:  'claims'

## Current Work
Early stage query-writing: basic SELECT/WHERE/GROUP BY exploration of the dataset structure, working toward cost-per-claim and beneficiary suppression analysis.

## Notes
This project involved rebuilding the database from scratch after an early tooling issue caused data loss.  The current schema was hand written as a result.