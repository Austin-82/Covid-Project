#shows percentage of population who got covid

select location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
From covid_new
where lower(location) like '%states%' and continent is not null
order by 1, 2

#looking at countries with Highest Infection Rate compared to population
select location, population, max(total_cases) as "HighestInfectionCount", max((total_cases/population))*100 as PercentPopulationInfected
from covid_new
where continent is not null
group by location, population
order by 4 desc

#Showing Countries with Highest Death Count Per Population
select location, max(total_deaths) as "TotalDeaths"
from covid_new
where continent is null
group by location
order by 2 desc

#by continent
select continent, max(total_deaths) as "TotalDeaths"
From covid_new
where continent is not null
group by continent
order by 2 desc

select date as "Date", SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentage
from covid_new
where continent is not null
group by date
order by 1, 2

select continent, location, date, population, new_vaccinations
from covid_new
where continent is not null
order by 1, 2, 3

select continent, location, date, population, new_vaccinations, sum(new_vaccinations) 
over (partition by location order by location, date) RollingPeopleVaccinated
from covid_new
where continent is not null
order by 2,3

#cte
with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select continent, location, date, population, new_vaccinations, sum(new_vaccinations) 
over (partition by location order by location, date) RollingPeopleVaccinated
from covid_new
where continent is not null
)

select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac

#temp table

DROP TEMPORARY TABLE IF EXISTS PercentPopulationVaccinated
CREATE TEMPORARY TABLE PercentPopulationVaccinated
(
continent varchar(255),
location varchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)
INSERT INTO PercentPopulationVaccinated
(
select continent, location, date, population, new_vaccinations, sum(new_vaccinations) 
over (partition by location order by location, date) RollingPeopleVaccinated
from covid_new
where continent is not null
)


select *, (RollingPeopleVaccinated/population)*100 
from PercentPopulationVaccinated

CREATE VIEW PercentPopulationVaccinated as 
select continent, location, date, population, new_vaccinations, sum(new_vaccinations)
over (partition by location order by location, date) RollingPeopleVaccinated
from covid_new
where continent is not null