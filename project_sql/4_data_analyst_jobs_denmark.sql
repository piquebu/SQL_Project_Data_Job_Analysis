/*
Question: What are the available Data Analyst job postings in Denmark?
- Retrieve job postings for Data Analyst roles located in Denmark.
- Include job title, company name, job schedule type, and a direct application link.
- Why? To provide insights into employment opportunities for Data Analysts in Denmark, helping candidates find relevant job openings.
*/

SELECT
    job_title_short,
    job_location,
    name AS company_name,
    job_schedule_type,
    link
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_location = 'Denmark' AND
    job_title_short = 'Data Analyst'
GROUP BY
    job_title_short,
    job_location,
    company_name,
    job_schedule_type,
    link;