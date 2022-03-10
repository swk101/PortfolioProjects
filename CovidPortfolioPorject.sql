--SELECT *
--  FROM [demo].[dbo].[CovidDeaths]

  --SELECT *
  --FROM [demo].[dbo].[CovidVaccinations]
  --ORDER BY 3,4

  --Select data we are going to be using
  Select Location, date, total_cases, new_cases, total_deaths, population
From demo..CovidDeaths
Where continent is not null 
order by 1,2

-- Total Cases vs Total Deaths
-- Likelihood of dying if you contract covid in Canada

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From demo..CovidDeaths
Where location = 'Canada'
and continent is not null 
order by 1,2

-- Total Cases vs Population
-- What percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From demo..CovidDeaths
order by 1,2


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From demo..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From demo..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From demo..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From demo..CovidDeaths
where continent is not null 
--Group By date
order by 1,2
