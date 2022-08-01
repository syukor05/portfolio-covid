SELECT * FROM PortfolioProject..CovidDeaths
ORDER BY 3,4

--SELECT * FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

SELECT LOCATION, DATE, total_cases,new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2 


-- total cases vs total deaths
SELECT LOCATION, DATE, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage 
From PortfolioProject..CovidDeaths
where location like '%malaysia%'
order by 1,2 


---total cases vs populations
-- percentage people got covid

SELECT LOCATION, DATE, population,total_cases, (total_cases/population)*100 as DeathsPercentage 
From PortfolioProject..CovidDeaths
-- where location like '%malaysia%'
order by 1,2 


--countries with highest infected rate compare to populations

SELECT LOCATION, population,MAX (total_cases) as HighestInfectedRate , MAX ((total_cases/population))*100 as PercentPopulationsInfected
From PortfolioProject..CovidDeaths
-- where location like '%malaysia%'
group by location, population
order by PercentPopulationsInfected desc

-- countries with highest count of Death per populations

SELECT LOCATION, MAX (cast (total_deaths as integer )) as TotalDeaths
From PortfolioProject..CovidDeaths
-- where location like '%malaysia%'
where continent is null
group by location
order by TotalDeaths desc

--covid by Continent 

SELECT continent, MAX (cast (total_deaths as integer )) as TotalDeathsCount
From PortfolioProject..CovidDeaths
-- where location like '%malaysia%'
where continent is not null
group by continent
order by TotalDeathsCount desc

--- New Table

-- total popultaions vs total vaccinations

select * 
from PortfolioProject..CovidDeaths dea
 join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date


-- new vaccine 

Select * dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,sum(convert (int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location,
dea.date)as 
from PortfolioProject..CovidDeaths dea
 join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3













