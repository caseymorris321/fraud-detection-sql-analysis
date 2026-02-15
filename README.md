# Credit Card Fraud Detection: SQL Analysis

Analyzed 1,000 credit card transactions to identify fraud patterns across merchants, card types, banks, and time periods. This is the SQL side of my [Power BI Fraud Detection Dashboard](https://empathycollides.netlify.app). Same dataset, different angle. The dashboard shows the big picture and these queries dig into the specifics.

## What I Found

- **Fraud rate:** 28.6% of transactions were flagged as fraudulent (286 out of 1,000)
- **Most damaging fraud type:** Card Not Present fraud drives the highest total losses
- **Merchant vulnerability:** Zomato leads in fraud count, followed by Big Bazaar and Myntra
- **Card type risk:** Visa cards show the highest fraud rate across all card types
- **Seasonal patterns:** December has the most fraud activity, which lines up with the Q4 spike in the dashboard
- **Fraud score accuracy:** Transactions scored 76-100 have a way higher actual fraud rate, so the scoring model checks out
- **Bank exposure:** Andhra Bank customers show the highest fraud rate by percentage

## Tools

- PostgreSQL + pgAdmin 4
- Dataset: 1,000 transactions with 14 fields (merchant, fraud type, risk level, card type, bank, fraud score, etc.)

## Files

- `fraud_analysis_queries.sql` - All 8 business queries with comments explaining what each one answers

## Connected Project

The Power BI dashboard built from this same dataset lives on my [portfolio site](https://empathycollides.netlify.app). I used these queries to validate the dashboard numbers and look deeper into patterns the charts alone don't show.
