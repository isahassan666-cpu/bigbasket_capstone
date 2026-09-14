
# BigBasket Analytics Capstone Project

An end-to-end data analytics and business intelligence pipeline evaluating category revenue performance, fulfillment trends, and margin benchmarks for BigBasket across H1 2026. This repository encompasses relational database modeling and SQL analysis, spreadsheet cross-validation and target tracking, an interactive executive Tableau dashboard, an automated Python/Pandas data pipeline, and strategic business reporting.

---

## Deliverables & Quick Links

- **Part 1: SQL Analytics** — [SQL Scripts Directory](./sql/)
- **Part 2: Spreadsheet Cross-Check** — [Google Spreadsheet](https://docs.google.com/spreadsheets/d/13K8f0WUpBD6P7VRHM46mGiQW7LwvCANdZbm2wEpAGiY/edit?gid=2115019288#gid=2115019288)
- **Part 3: Tableau Public Dashboard** — [Live Executive Performance Dashboard](https://public.tableau.com/app/profile/isa.sonday/viz/ExecutivePerformanceDashboard_17894214321570/ExecutivePerformanceDashboard)
- **Executive Data Story (Task 7)** — [DATA_STORY.md](./DATA_STORY.md)
- **Part 4: Python/Pandas Notebook** — [Part 4 Notebook](./notebooks/part4_analysis.ipynb) *(update path to match your notebook location)*
- **AI Collaboration Log** — [ai_log.md](./ai_log.md)

---

## Repository Structure

```text
bigbasket_capstone/
├── data/
│   ├── raw/

# Raw exported CSV files
│   └── processed/

# Cleaned datasets
├── notebooks/
│   └── part4_analysis.ipynb

# Python/Pandas data cleaning & analysis notebook
├── sql/
│   ├── schema.sql

# Database schema setup
│   ├── task1_queries.sql

# Category revenue and performance queries
│   └── task2_queries.sql

# Order volume & customer KPI queries
├── generate_data.py

# Script to regenerate database and raw CSV exports
├── DATA_STORY.md

# Task 7 executive narrative & strategic recommendations
├── ai_log.md

# Comprehensive log of AI assistance and prompts
└── README.md

# Project overview and reproduction guide
