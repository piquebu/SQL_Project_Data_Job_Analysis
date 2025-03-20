/*
Question: What is the distribution of Data Analyst job postings in Denmark by job type?
- Retrieve the number of job postings for Data Analyst roles in Denmark, grouped by job schedule type.
- Focus on understanding how job types (full-time, part-time, contract, internship) are distributed in the Danish job market.
- Why? This analysis helps job seekers understand the most common employment types available for Data Analyst roles in Denmark, aiding in career planning.
*/

SELECT
    job_schedule_type,
    COUNT(*) AS job_count
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_location = 'Denmark' 
    AND job_title_short = 'Data Analyst'
    AND job_schedule_type IS NOT NULL
GROUP BY
    job_schedule_type
ORDER BY
    job_count DESC;
