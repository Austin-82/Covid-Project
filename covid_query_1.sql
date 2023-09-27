#shows percentage of population who got covid

select location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
From covid_new
where lower(location) like '%states%' and continent is not null
order by 1, 2

#looking at countries with Highest Infection Rate compared to population
#tableau visualization 3

select location, population, max(total_cases) as "HighestInfectionCount", max((total_cases/population))*100 as PercentPopulationInfected
from covid_new
group by location, population
order by 4 desc


#Calculate the total deaths by location
#tableau visualization 2

select location, sum(new_deaths) as "TotalDeaths"
from covid_new
where continent is null and location not in ('World', 'European Union', 'International')
group by location
order by 2 desc

#total deaths by continent
select continent, max(total_deaths) as "TotalDeaths"
From covid_new
where continent is not null
group by continent
order by 2 desc

#Calculate total COVID-19 cases, total COVID-19 deaths, and total new deaths by date
select date as "Date", SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentage
from covid_new
where continent is not null
group by date
order by 1, 2

#Calculate total COVID-19 cases, total COVID-19 deaths, and death percentage
#tableau 1 visualization
select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentage
from covid_new
where continent is not null
order by 1, 2


#Retrieve location-specific COVID-19 data, including population, date, highest infection count, and percentage of population infected.
#tableau visualization 4
SELECT location, population, date, MAX(total_cases) as HighestInfectedCount, MAX(total_cases/population)*100 as PercentPopulationInfected
FROM covid_new
GROUP BY location, population, date
order by PercentPopulationInfected desc 

#Retrieve continent, location, date, population, new vaccinations, and rolling total of people vaccinated.

select continent, location, date, population, new_vaccinations, sum(new_vaccinations) 
over (partition by location order by location, date) RollingPeopleVaccinated
from covid_new
where continent is not null
order by 2,3

#Calculate the rolling total of people vaccinated as a percentage of the population

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


#Created a temporary table to calculate the rolling total of people vaccinated

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

#Create a view to calculate and display the percentage of the population vaccinated

select *, (RollingPeopleVaccinated/population)*100 
from PercentPopulationVaccinated

CREATE VIEW PercentPopulationVaccinated as 
select continent, location, date, population, new_vaccinations, sum(new_vaccinations)
over (partition by location order by location, date) RollingPeopleVaccinated
from covid_new
where continent is not null