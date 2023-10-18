# COVID-19 SQL Exploratory Data Analysis Project

## Introduction
This real-world exploratory data analysis project seeks to reveal the most recent insight about COVID-19. COVID-19 was a global pandemic that affected almost every country worldwide, resulting in the deaths of nearly 7 million people globally and the infection of over 700 million people globally. My interest in this project is sponsored partly by my medical affiliation.

## Data Source
 -  [Download here](https://ourworldindata.org/covid-deaths)

## Tools
- Microsoft Excel
   - I used Excel to cut out two tables Covid death and Covid vac table
- SQL Server Management Studio
   -  I used it for explortaory data analysis

## Data Anatomy:
Inspection of the data after download revealed that the data consisted of 63 columns and over 330,000 rows. The data columns included Location, Date, Continent, Population, Total Cases, deaths, new cases and many more.

## Approach

Because of the large nature of the dataset, the data had to be broken into 2 Excel files, which were then imported into SSMS. This was necessary to avoid complications of too much data, which would reduce the speed of operation. Also, there is a need to use more SQL functions, such as Joins. The COVID death data set consisted of Country, Population, New Deaths, New Cases, Total Deaths and many more. At the same time, the COVID vaccination table consisted of Date, Population, Location, New Tests, new vaccinations and many more.


## Exploratory Data Analysis

Using SQL, I revealed the following

- Total deaths per Population
- Total death vs Total Cases ratio
- Percentage of Total Death of total cases
- Percentage of Total Death of total cases by location including (Nigeria, United States, and United Kingdom)
- Total cases vs Population
- Countries with the Highest infection rate
- Countries with the Highest Death Rate
- Countries with the Lowest death rate
- Total deaths per Continent
- Global Numbers
- Covid Vaccination Vs Population
- Increasing Vaccination Count vs Population


## Special SQL Functions in this Project

``` sql
----- Used convert to prevent operation error that would have result error in data type conversion during arithmetic division

SELECT location, date,total_cases, total_deaths, population,
convert(decimal(9, 2), total_deaths) / convert(decimal(11, 2), total_cases) as total_death_per_total_cases 
FROM dbo.CovidDeaths
ORDER BY Location, Date

--- NULLIF was used to nullify the effect of 0 during division

SELECT date, sum(new_cases) as total_cases, sum(new_deaths) as total_death,
NULLIF(sum(new_deaths), 0) / NULLIF(sum(new_cases), 0) * 100 as 'percentage_death'
FROM dbo.CovidDeaths
WHERE continent is not null
group by date
ORDER BY 1, 2

---Made use of Joins to join Covid death to Covid Vacx

SELECT *
FROM dbo.CovidDeaths as CD
JOIN dbo.CovidVacx as CV
On CD.location = CV.location
  and CD.date = CV.date

---Creating views for visualization which will be used for tableau

Create View percentPopulationvac as
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
--Sum(Cast(CV.new_vaccinations as int)) Over (partition by CD.location)
Sum(Convert(decimal(10, 0), CV.new_vaccinations)) Over (partition by CD.location ORDER BY cd.location, cd.date) as increasing_vaccination_count
FROM dbo.CovidDeaths as CD
JOIN dbo.CovidVacx as CV
On CD.location = CV.location
  and CD.date = CV.date
WHERE Cd.continent is not null
----ORDER BY 1, 2
