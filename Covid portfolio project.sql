---- -------Imported the data from excel, and testing to see if the data was imported correctly
SELECT * 
FROM dbo.CovidDeaths
order by 3, 4

SELECT * 
FROM dbo.CovidVacx
ORDER BY 3, 4

----Filtering the data from coviddeaths.
SELECT location, date,total_cases,new_cases, total_deaths, population
FROM dbo.CovidDeaths
ORDER BY 1, 2

----Show total deaths per population
SELECT location, date,total_cases,new_cases, total_deaths, population, total_deaths / population as population_fatality
FROM dbo.CovidDeaths
ORDER BY 1, 2


----- Looking at Total cases per total deaths
SELECT location, date,total_cases, total_deaths, population,
convert(decimal(9, 2), total_deaths) / convert(decimal(11, 2), total_cases) as total_death_per_total_cases 
FROM dbo.CovidDeaths
ORDER BY Location, Date

-----Percentage of total death of total cases. To successfully run this query, the data type in Total_deaths and Total_cases has to be converted
-----into decmial

SELECT location, date,total_cases, total_deaths, population,
convert(decimal(9, 2), total_deaths) / convert(decimal(11, 2), total_cases) * 100 as deathpercentage
ORDER BY Location, Date
FROM dbo.CovidDeaths

----Narrowing down to certain locations
SELECT location, date,total_cases, total_deaths, population,
convert(decimal(9, 2), total_deaths) / convert(decimal(11, 2), total_cases) * 100 as deathpercentage
FROM dbo.CovidDeaths
WHERE location = 'Nigeria'
ORDER BY Location, Date


SELECT location, date,total_cases, total_deaths, population,
convert(decimal(9, 2), total_deaths) / convert(decimal(11, 2), total_cases) * 100 as deathpercentage
FROM dbo.CovidDeaths
WHERE location Like 'United States%'
ORDER BY 1, 2

SELECT location, date,total_cases, total_deaths, population,
convert(decimal(9, 2), total_deaths) / convert(decimal(11, 2), total_cases) * 100 as deathpercentage
FROM dbo.CovidDeaths
WHERE location Like 'United Kingdom%'
ORDER BY 1, 2

----Looking at total cases vs population. It shows the percentage of people with covid worldwide
SELECT location, date, population, total_cases, total_deaths, 
convert(decimal(11, 2), total_cases) / convert(decimal(13, 2), population) * 100 as infectedpopulation
FROM dbo.CovidDeaths
ORDER BY 1, 2

-----In Nigeria
SELECT location, date, population, total_cases, total_deaths, 
convert(decimal(11, 2), total_cases) / convert(decimal(13, 2), population) * 100 as infectedpopulation
FROM dbo.CovidDeaths
WHERE location like '%States%'
ORDER BY 1, 2

SELECT location, date, population, total_cases, total_deaths, 
convert(decimal(11, 2), total_cases) / convert(decimal(13, 2), population) * 100 as infectedpopulation
FROM dbo.CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1, 2

SELECT location, date, population, total_cases, total_deaths, 
convert(decimal(11, 2), total_cases) / convert(decimal(13, 2), population) * 100 as infectedpopulation
FROM dbo.CovidDeaths
WHERE location like '%United Kingdom%'
ORDER BY 1, 2
 
 -----Looking at countries with highest infection rate


 SELECT location, population, Max(total_cases) as highestinfectioncount, 
 max(convert(decimal(11, 2), total_cases) / convert(decimal(13, 2), population)) * 100 as highest_infectedpopulation
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY location, population
ORDER BY highest_infectedpopulation DESC


-----Showing countries with the highest death count per population
 SELECT location, population, Max(Cast(total_deaths as int)) highestdeaths
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY location, population
ORDER BY highestdeaths DESC

----showing countries with the least deaths and cases

 SELECT location, population, Min(Cast(total_deaths as int)) lowestdeaths, Min(Cast(total_cases as int)) lowestcases
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY location, population
ORDER BY lowestdeaths, lowestcases DESC

----- Based on average infection and death
 SELECT location, population, AVG(convert(decimal(9, 2), total_deaths)) AVGdeaths, AVG(Convert(Decimal(11, 2), (total_cases))) AVGCases
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY location, population
ORDER BY AVGdeaths DESC

----Let break things down by continent
 SELECT continent, Max(Cast(total_deaths as int)) highestdeaths, Max(Cast(total_cases as int)) as Highestinfection
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY continent
ORDER BY highestdeaths DESC

----Average by continent
SELECT continent, AVG(convert(decimal(9, 2), total_deaths)) Avgdeaths, AVG(Convert(decimal(11, 2), total_cases)) as AVGinfection
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY continent
ORDER BY Avgdeaths DESC

SELECT location, AVG(convert(decimal(9, 2), total_deaths)) Avgdeaths, AVG(Convert(decimal(11, 2), total_cases)) as AVGinfection
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is null 
GROUP BY continent, location
ORDER BY Avgdeaths DESC

 SELECT location, Max(Cast(total_deaths as int)) highestdeaths, Max(Cast(total_cases as int)) as Highestinfection
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY location
ORDER BY highestdeaths DESC



 SELECT continent, Max(Cast(total_deaths as int)) highestdeaths, Max(Cast(total_cases as int)) as Highestinfection
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is not null 
GROUP BY continent
ORDER BY highestdeaths DESC


-----Correct numbers for continent
SELECT location, Max(Cast(total_deaths as int)) highestdeaths, Max(Cast(total_cases as int)) as Highestinfection
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is null 
GROUP BY location
ORDER BY highestdeaths DESC

---Continents with the highest count

SELECT location, Max(Cast(total_deaths as int)) highestdeaths, Max(Cast(total_cases as int)) as Highestinfection
FROM dbo.CovidDeaths
----WHERE location = 'Nigeria'
WHERE Continent is null 
GROUP BY location
ORDER BY highestdeaths DESC

-------Global Numbers

SELECT date, Sum(Convert(decimal(10, 0), total_cases)), sum(convert(decimal(10, 0), total_deaths))
--sum(convert(decimal(10, 2), total_cases) / convert(decimal(13, 2), population)) * 100 as infectedpopulation
FROM dbo.CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1, 2

----Sum of new deaths and new cases
SELECT sum(new_cases), sum(new_deaths)
--sum(convert(decimal(10, 2), total_cases) / convert(decimal(13, 2), population)) * 100 as infectedpopulation
FROM dbo.CovidDeaths
WHERE continent is not null
ORDER BY 1, 2

SELECT date, sum(new_cases) as total_cases, sum(new_deaths) as total_death,
NULLIF(sum(new_deaths), 0) / NULLIF(sum(new_cases), 0) * 100 as 'percentage_death'
FROM dbo.CovidDeaths
WHERE continent is not null
group by date
ORDER BY 1, 2
----Total world cases
SELECT sum(new_cases) as total_cases, sum(new_deaths) as total_death,
NULLIF(sum(new_deaths), 0) / NULLIF(sum(new_cases), 0) * 100 as 'percentage_death'
FROM dbo.CovidDeaths
WHERE continent is not null
--group by date
ORDER BY 1, 2

-----It is time to join covid vaccination table to covid death table
SELECT *
FROM dbo.CovidDeaths as CD
JOIN dbo.CovidVacx as CV
On CD.location = CV.location
  and CD.date = CV.date

  -----Covid vaccination vs population
SELECT  CD.location, CD.date, CD.population, CV.new_vaccinations
FROM dbo.CovidDeaths as CD
JOIN dbo.CovidVacx as CV
On CD.location = CV.location
  and CD.date = CV.date
  WHERE Cd.continent is not null
  ORDER BY 1, 2


  ---Let do a rolling count of new vaccinations
 SELECT  CD.location, CD.date, CD.population, CV.new_vaccinations,
 --Sum(Cast(CV.new_vaccinations as int)) Over (partition by CD.location)
  Sum(Convert(decimal(10, 0), CV.new_vaccinations)) Over (partition by CD.location ORDER BY cd.location, cd.date) as increasing_vaccination_count
FROM dbo.CovidDeaths as CD
JOIN dbo.CovidVacx as CV
On CD.location = CV.location
  and CD.date = CV.date
  WHERE Cd.continent is not null
  ORDER BY 1, 2

  -----Let create CTE

With PopvsVax (Continent, Location, Date, Population, new_vaccinations, increasing_vaccination_count)
as
( 
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
--Sum(Cast(CV.new_vaccinations as int)) Over (partition by CD.location)
Sum(Convert(decimal(10, 0), CV.new_vaccinations)) Over (partition by CD.location ORDER BY cd.location, cd.date) as increasing_vaccination_count
FROM dbo.CovidDeaths as CD
JOIN dbo.CovidVacx as CV
On CD.location = CV.location
  and CD.date = CV.date
WHERE Cd.continent is not null
----ORDER BY 1, 2
)

SELECT *, (increasing_vaccination_count / population) * 100
FROM PopvsVax


----Temp Tables
DROP TABLE If EXISTS #percentPopulationvac
Create Table #percentPopulationvac
(Continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
increasing_vaccination_count numeric
)

INSERT INTO #percentPopulationvac
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
--Sum(Cast(CV.new_vaccinations as int)) Over (partition by CD.location)
Sum(Convert(decimal(10, 0), CV.new_vaccinations)) Over (partition by CD.location ORDER BY cd.location, cd.date) as increasing_vaccination_count
FROM dbo.CovidDeaths as CD
JOIN dbo.CovidVacx as CV
On CD.location = CV.location
  and CD.date = CV.date
WHERE Cd.continent is not null
----ORDER BY 1, 2


SELECT *, (increasing_vaccination_count / population) * 100
FROM #percentPopulationvac


----Creating views for visualization which will be used for tableau
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

SELECT * 
FROM percentPopulationvac
