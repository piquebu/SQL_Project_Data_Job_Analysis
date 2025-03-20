# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
The data job market is evolving rapidly, with demand for data analysts growing across industries. Salaries vary widely depending on skills, location, and industry, making it crucial to identify which skills and roles offer the highest pay.

This project analyzes top-paying data analyst jobs using real-world job postings, focusing on:

Salary trends in the data analytics field
In-demand technical skills that lead to higher salaries
Job market insights for analysts seeking top-paying opportunities
By leveraging SQL and data visualization, this study uncovers patterns in high-paying job listings, must-have skills, and career opportunities in data analytics. 🚀
# Tools I Used
For this project, I utilized the following tools:

- SQL: Used for querying and processing job listing data, identifying trends, and extracting key insights about salaries, roles, and required skills.
- PostgreSQL: Leveraged this powerful relational database to store and manage the data, enabling efficient querying and data manipulation.
- Visual Studio Code: This code editor was essential for writing and testing SQL queries, as well as for managing and organizing project files.
- Git & GitHub: Used for version control and collaboration, ensuring that project progress was well-managed and code changes were tracked throughout the process.

These tools helped streamline the workflow, from data collection to analysis and version control.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

## 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\1_top_paying_roles.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

## 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```

### Here's the breakdown of the most demanded skills for data analyst in 2023, based on job postings:

- **SQL (8 mentions):** The most frequently required skill, highlighting its importance in data querying and management.
- **Python (7 mentions):** A strong second, emphasizing the growing need for programming in data analysis.
- **Tableau (6 mentions):** A popular data visualization tool, indicating a demand for analysts who can present insights effectively.

### Other Notable Skills

- **R (4 mentions):** Still relevant, particularly in statistical analysis and research-heavy roles.
- **Snowflake, Pandas, Excel (3 mentions each):** Snowflake for cloud-based data warehousing, Pandas for data manipulation in Python, and Excel as a foundational tool.
Azure, AWS, Databricks, Pyspark: Cloud and big data technologies are increasingly important.

### Collaboration & Version Control Tools

- **Bitbucket, GitLab, Confluence, Jira, Atlassian (2 mentions each):** Collaboration tools are valuable, showing a preference for analysts who work in agile and DevOps environments.

![Top Paying Job Skills](assets\2_top_paying_roles_skills.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

## 3. In-Demand Skills for Data Analysts
This SQL query identifies the top 5 most in-demand skills for Data Analyst positions specifically in Denmark. By joining job posting data with skills information and filtering for Data Analyst roles in Denmark, it provides targeted insight into which skills are most valuable in this specific job market. The results are ordered by frequency of appearance in job listings, offering clear direction on which skills to prioritize when preparing for a career as a Data Analyst in Denmark.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Denmark'
GROUP BY
    skills
ORDER BY demand_count DESC
LIMIT 5;
```

### Here's the breakdown of the most demanded skills for data analysts in Denmark:

- **SQL (103 mentions)** is the most in-demand skill, demonstrating the critical importance of database querying capabilities for data analysts in the Danish job market.
- **Excel (77 mentions)** remains a fundamental requirement, highlighting that spreadsheet proficiency continues to be a core expectation despite the rise of more advanced tools.
- **Python (74 mentions)** follows closely behind Excel, showing the growing importance of programming skills for data analysis and automation.
- **Power BI (66 mentions)** ranks fourth, indicating the significant demand for dashboard creation and business intelligence visualization capabilities.
- **Tableau (44 mentions)** completes the top five, further emphasizing that data visualization tools are essential for modern data analysts.

This skills distribution suggests that Danish employers value a combination of traditional data manipulation skills (SQL, Excel) alongside more technical programming capabilities (Python) and modern visualization tools (Power BI, Tableau) for effective data storytelling and decision support.

![Top Demanded Skills](assets\3_top_demanded_skills.png)

*Table of the demand for the top 5 skills in data analyst job postings in Denmark*

## 4. Job Distribution of Data Analyst Jobs in Denmark

Understanding the distribution of job types helps job seekers navigate the Danish data job market more effectively. This analysis categorizes Data Analyst job postings in Denmark by employment type, highlighting the most common job schedules available.

```sql
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
```

### Here's the breakdown of job schedule types for data analysts in Denmark

- **Full-time (213 mentions)** is the most common job schedule type, indicating that the majority of positions require a full-time commitment.

- **Internship (12 mentions)** follows, showing that there are opportunities for those seeking temporary or entry-level positions.

- **Full-time and Part-time (5 mentions)** and Part-time (5 mentions) are equally represented, suggesting that some roles offer flexibility in working hours.

- **Full-time and Internship (2 mentions)** and **Full-time and Contractor (2 mentions)** are less common, highlighting niche opportunities that combine different types of work arrangements.

- **Contractor (1 mention)** is the least common, indicating limited demand for contract-based roles in this dataset.

### 🔍 Key Findings:
- **Full-time roles** dominate the market, making up the majority of available positions.
- **Internship** opportunities are available but significantly lower in volume.
- **Part-time and contract** roles exist but are less common compared to full-time positions.

By analyzing these trends, job seekers can align their expectations with the market demand and optimize their job search strategy. 🚀

![Job Distributions: Data Analyst Jobs in Denmark](assets\4_job_distribution.png)
*A visualization of the job types available for Data Analysts in Denmark; ChatGPT generated this graph from my SQL query results* 

## 5. Top-Paying Skills for Data Analysts

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

*(TLDR: Big Data & Cloud Skills Dominate)*

```sql
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
```

- **PySpark ($208K), Databricks ($141K), Airflow ($126K), GCP ($122K)** → These indicate that expertise in big data processing and cloud platforms is highly valued.
Companies are investing in distributed computing for handling massive datasets.
Version Control & DevOps Matter

- **Bitbucket ($189K), GitLab ($154K), Jenkins ($125K), Kubernetes ($132K)** → High salaries for DevOps and CI/CD tools show that data analysts with engineering skills are in demand.
Jenkins & Kubernetes hint at integration with machine learning models in production.
AI & Machine Learning Boost Salaries

- **DataRobot ($155K), Scikit-Learn ($125K), Watson ($160K)** → AI-focused platforms and frameworks are paying well.
AI-driven automation in analytics is becoming a key differentiator for high earners.
Programming & Data Processing Still King

- **Python Libraries (Pandas $151K, Numpy $143K, Jupyter $152K, Scikit-Learn $125K)** → Strong Python-based skills are highly paid, reinforcing Python’s dominance in analytics.
Scala ($124K) and Golang ($145K) suggest backend & performance-heavy analytics roles also pay well.
BI & Analytics Tools Are Still Valuable

- **PostgreSQL ($123K), MicroStrategy ($121K), Notion ($125K)** → SQL-based skills remain relevant, while modern BI tools (like Notion) are gaining traction.
Conclusion:
High-paying data analysts are those who blend data engineering, AI, and DevOps skills into their toolkit.
Cloud, automation, and big data expertise lead to higher salaries.
Pure analytics skills (BI, SQL) are still valuable but not at the highest tier.

### Why it matters?
- High-performance languages (Golang) and CI/CD tools (Jenkins) cater to roles blending analytics with software engineering.

### Key Takeaways
- **Cloud + Big Data = $$$:** Skills in cloud platforms (GCP) and distributed systems (PySpark) are 20–30% higher than traditional BI tools.

- **Remote Work Premium:** DevOps/AI skills are disproportionately rewarded in remote roles, likely due to their alignment with scalable, automated workflows.

- **Beyond Dashboards:** While SQL/BI tools (PostgreSQL: $123K, Tableau: Not in top 50) are foundational, they lag behind engineering-focused skills.

### Recommendations
- **Upskill in Cloud Platforms:** Certifications in GCP/AWS or Databricks can boost salary potential.

- **Learn Automation Tools:** Master Airflow for pipeline orchestration or Kubernetes for deployment.

- **Bridge the AI Gap:** Add Scikit-Learn or Watson to your toolkit to stay competitive.

**Note:** *Salaries reflect averages from remote roles with disclosed pay. Results may skew toward niche skills with fewer high-paying postings.*

![Top Paying Skills](assets\5_top_paying_skills.png)

*Table of the average salary for the top 10 paying skills for data analysts*

## 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

![Most Optimal Skills](assets\6_optimal_skills.png)
*Table of the most optimal skills for data analyst sorted by salary*

### Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- 📊 **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- 💡 **Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

#### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
