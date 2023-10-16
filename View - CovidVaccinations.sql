--Creating a View that Stores Data for Visualization Purposes
CREATE VIEW PercentPopulationVaccinated AS
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccination.new_vaccinations,
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL
--ORDER BY 2,3


SELECT *
FROM PercentPopulationVaccinated