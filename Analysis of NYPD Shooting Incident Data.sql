--NYPD Shooting Incident Data Analysis

--Viewing all the dataset
SELECT *
FROM
[dbo].[NYPD_Shooting_Incident_Data];


--Grouping the victim's age group by the number of deaths per victim's age group
SELECT Vic_Age_Group, COUNT
(Vic_Age_Group) AS No_Deaths_Per_Vic_Age_Group
FROM
[dbo].[NYPD_Shooting_Incident_Data]
GROUP BY
Vic_Age_Group;


--Creating a temporary name to store victim's age group and number of deaths per victim's age group
USE [NYPD_Shooting];
SELECT Vic_Age_Group, COUNT
(Vic_Age_Group) AS No_Deaths_Per_Vic_Age_Group
INTO ##Deaths_AGE 
FROM
[dbo].[NYPD_Shooting_Incident_Data]
GROUP BY
Vic_Age_Group;



--Selecting all the dataset in the temp table
SELECT *
FROM
##Deaths_AGE;

--Calculating the total of deaths
SELECT (SUM(##Deaths_AGE.No_Deaths_Per_Vic_Age_Group)) AS TotalDeaths
FROM
##Deaths_AGE

--Calculating the percentage of number of deaths by victim's age group
SELECT ##Deaths_AGE.Vic_Age_Group, ##Deaths_AGE.No_Deaths_Per_Vic_Age_Group, CAST(##Deaths_AGE.No_Deaths_Per_Vic_Age_Group/CAST(23568 AS FLOAT) AS NUMERIC(5, 4)) * 100 AS Percent_DAG
FROM
##Deaths_AGE
ORDER BY 2;

--Solution 2

--Viewing all the dataset
SELECT *
FROM
[dbo].[NYPD_Shooting_Incident_Data];


--Grouping the victim's age group by the number of deaths per victim's age group
SELECT Vic_Age_Group, COUNT
(Vic_Age_Group) AS No_Deaths_Per_Vic_Age_Group
FROM
[dbo].[NYPD_Shooting_Incident_Data]
GROUP BY
Vic_Age_Group;

--Calculating the total of deaths
SELECT COUNT(INCIDENT_KEY) AS TotalDeaths
FROM
[dbo].[NYPD_Shooting_Incident_Data];



--Calculating the percentage of number of deaths by victim's age group
SELECT Vic_Age_Group, No_Deaths_Per_Vic_Age_Group, CAST(No_Deaths_Per_Vic_Age_Group/CAST(23568 AS FLOAT) AS NUMERIC(5, 4)) * 100 AS Percent_DAG
FROM
(SELECT Vic_Age_Group, COUNT
(Vic_Age_Group) AS No_Deaths_Per_Vic_Age_Group
FROM
[dbo].[NYPD_Shooting_Incident_Data]
GROUP BY
Vic_Age_Group) AS Original
ORDER BY No_Deaths_Per_Vic_Age_Group, Percent_DAG;

--Creating view for data visualization
CREATE VIEW PercentDeath_VicAgeGroup AS 
SELECT Vic_Age_Group, No_Deaths_Per_Vic_Age_Group, CAST(No_Deaths_Per_Vic_Age_Group/CAST(23568 AS FLOAT) AS NUMERIC(5, 4)) * 100 AS Percent_DAG
FROM
(SELECT Vic_Age_Group, COUNT
(Vic_Age_Group) AS No_Deaths_Per_Vic_Age_Group
FROM
[dbo].[NYPD_Shooting_Incident_Data]
GROUP BY
Vic_Age_Group) AS Original
--ORDER BY No_Deaths_Per_Vic_Age_Group, Percent_DAG;

SELECT *
FROM
[dbo].[PercentDeath_VicAgeGroup];
