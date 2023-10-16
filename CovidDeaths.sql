SELECT *
FROM PortfolioProject..CovidDeaths
WHERE Continent IS NOT NULL
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

-- Selecting Data That We Will Be Using
USE PortfolioProject
SELECT Location, date, Total_cases, New_cases, Total_deaths, population
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
ORDER BY 1,2


-- Viewing Total Cases Against Total Deaths
-- Illustrates the Likelihood of Dying, by Country
USE PortfolioProject
SELECT Location, date, Total_cases, Total_deaths, (CONVERT(FLOAT, total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0))*100 as DeathPercentage
FROM [CovidDeaths]
WHERE location LIKE '%STATES%' AND continent IS NOT NULL
ORDER BY 1,2


-- Viewing Total Cases Against Population
-- Illustrates the Percentage of Population that contract Covid
USE PortfolioProject
SELECT Location, Population, Date, Total_cases, (CONVERT(FLOAT, total_cases) / NULLIF(CONVERT(FLOAT, population), 0))*100 as PopulationContractionPercentage
FROM [CovidDeaths]
WHERE location LIKE '%STATES%' AND continent IS NOT NULL
ORDER BY 1,2


-- Countries with the Highest Infection Rates Against Population
USE PortfolioProject
SELECT Location, Population, MAX(total_cases) AS HighestContractionCount, MAX((CONVERT(FLOAT, total_cases) / NULLIF(CONVERT(FLOAT, population), 0)))*100 as PopulationContractionPercentage
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Location, population
ORDER BY PopulationContractionPercentage DESC


-- Countries with the Highest Death Count per Population
USE PortfolioProject
SELECT Location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
--WHERE location LIKE '%STATES%'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC


-- BREAKING THINGS DOWN BY CONTINENT
--USE PortfolioProject
--SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
--WHERE location LIKE '%STATES%'
--FROM [CovidDeaths]
--WHERE continent IS NULL
--GROUP BY location
--ORDER BY TotalDeathCount DESC
--USE PortfolioProject


-- Illustrating the Continents with Highest Death Count per Population
SELECT Continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
--WHERE location LIKE '%STATES%'
FROM [dbo].[CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Continent
ORDER BY TotalDeathCount DESC


-- Global statistics
SELECT date, SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, 
(CONVERT(float, SUM(new_deaths)) / NULLIF(CONVERT(float, SUM(new_cases)), 0)) * 100 AS DeathPercentage
FROM [CovidDeaths]
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

SELECT SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, 
(CONVERT(float, SUM(new_deaths)) / NULLIF(CONVERT(float, SUM(new_cases)), 0)) * 100 AS DeathPercentage
FROM [CovidDeaths]
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2