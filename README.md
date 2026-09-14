# Credit Risk & Pricing Strategy Analysis
Credit risk and risk-based pricing analysis of a LendingClub loan portfolio using SQL and Power BI.
## Overview
This project analyses approximately 2.26 million LendingClub loans to evaluate credit risk, portfolio exposure, borrower segmentation and risk-based pricing.
The analysis was designed around practical credit analyst questions:
- How does observed credit risk vary across borrower risk grades?
- How does loan term relate to observed credit performance?
- Does pricing increase as observed risk increases?
- Which sub-grade transitions warrant further pricing investigation?
## Key Findings
- Observed Credit Loss / Default rates increase substantially across risk grades, from approximately 3.3% for Grade A to 38.1% for Grade G.
- Credit Loss / Default loans represent 11.91% of the portfolio by loan count and approximately 12.31% of original loan exposure.
- Higher-risk grades, particularly Grades E–G, show substantially higher default exposure rates.
- Average interest rates generally increase alongside observed risk at sub-grade level, indicating strong risk-based pricing differentiation.
- Selected sub-grade transitions were identified for further pricing review where changes in default exposure appeared disproportionate to changes in average interest rates.
- The analysis highlights that loan term should be evaluated alongside borrower risk, as the relationship between term and observed credit performance differs across risk grades.
## Analytical Approach
The analysis covers:
1. Dataset exploration and validation
2. Loan outcome classification
3. Data quality assessment
4. Credit risk analysis by grade and loan term
5. Borrower credit and financial profiling
6. Sub-grade pricing analysis
7. Default exposure analysis
8. Pricing alignment screening using sub-grade changes
## Tools
- **SQL** — data exploration, classification, aggregation, segmentation and pricing analysis
- **Power BI** — portfolio risk dashboard and visual analysis
- **SQLite** — data environment for analytical queries
## Repository Structure
```text
credit-risk-pricing-analysis/
│
├── README.md
│
├── SQL/
│   ├── 01_dataset_exploration.sql
│   ├── 02_loan_outcome_classification.sql
│   ├── 03_data_quality.sql
│   ├── 04_credit_risk_analysis.sql
│   └── 05_pricing_strategy_analysis.sql
│
├── Dashboard/
│   ├── Credit Risk Dashboard.pbix
│   ├── 01_Portfolio Overview.png
│   ├── 02_Risk Segmentation.png
│   ├── 03_Risk Based Pricing.png
│   └── 04_Definitions.png
│
└── Analysis/
   └── Credit Risk & Pricing Strategy Analysis.pdf
