/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analysts positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 50;

/*
Key Trends in Top-Paying Data Analyst Skills
Big Data & Cloud Skills Dominate

PySpark ($208K), Databricks ($141K), Airflow ($126K), GCP ($122K) → These indicate that expertise in big data processing and cloud platforms is highly valued.
Companies are investing in distributed computing for handling massive datasets.
Version Control & DevOps Matter

Bitbucket ($189K), GitLab ($154K), Jenkins ($125K), Kubernetes ($132K) → High salaries for DevOps and CI/CD tools show that data analysts with engineering skills are in demand.
Jenkins & Kubernetes hint at integration with machine learning models in production.
AI & Machine Learning Boost Salaries

DataRobot ($155K), Scikit-Learn ($125K), Watson ($160K) → AI-focused platforms and frameworks are paying well.
AI-driven automation in analytics is becoming a key differentiator for high earners.
Programming & Data Processing Still King

Python Libraries (Pandas $151K, Numpy $143K, Jupyter $152K, Scikit-Learn $125K) → Strong Python-based skills are highly paid, reinforcing Python’s dominance in analytics.
Scala ($124K) and Golang ($145K) suggest backend & performance-heavy analytics roles also pay well.
BI & Analytics Tools Are Still Valuable

PostgreSQL ($123K), MicroStrategy ($121K), Notion ($125K) → SQL-based skills remain relevant, while modern BI tools (like Notion) are gaining traction.
Conclusion:
High-paying data analysts are those who blend data engineering, AI, and DevOps skills into their toolkit.
Cloud, automation, and big data expertise lead to higher salaries.
Pure analytics skills (BI, SQL) are still valuable but not at the highest tier.
*/