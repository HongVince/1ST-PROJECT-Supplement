--COVID VACCINATIONS


--Total Population vs. Vaccination
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccination.new_vaccinations,
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL
ORDER BY 2,3


--CTE
WITH PopulationVsVaccination (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS 
(SELECT Death.continent, Death.location, Death.date, Death.population, Vaccination.new_vaccinations,
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopulationVsVaccination


-- TEMP TABLE
CREATE TABLE #PercentPopulationVaccinated
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
DATE DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
RollingPeopleVaccinated NUMERIC)

INSERT INTO #PercentPopulationVaccinated
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccination.new_vaccinations,
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated

--------------------------------------------------------------------

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
DATE DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
RollingPeopleVaccinated NUMERIC)

INSERT INTO #PercentPopulationVaccinated
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccination.new_vaccinations,
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
--WHERE Death.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated
