--to query all my data  
select * from CovidProject..CovidVaccines;

--we are going be to using a special parts from my big data - specific some columns-
select location , date ,new_cases, total_cases, total_deaths , population   
from CovidProject..CovidVaccines 
order by 1,2;


--we are going be to using a special parts from my big data - specific some columns-
--to show total death for all containant 
select location , date ,  total_deaths , continent  
from CovidProject..CovidVaccines 
where continent is not null 
order by 1,2;

--we are going be to using a special parts from my big data - specific some columns-
-- to query about tatal deaths percentage for total Cases when totaldeaths is a real numbers 
select location , date, total_cases, total_deaths ,(( total_deaths / total_cases) * 100 ) as tataldeathspercentage 
from CovidProject..CovidVaccines 
where total_deaths is not null 
order by 1,2;


--we are going be to using a special parts from my big data - specific some columns-
-- to query about tatal Cases percentage for Population when 
select location , date, total_cases, population ,(( total_cases /population ) * 100 ) as TatalCasespercentage 
from CovidProject..CovidVaccines 
where total_cases is not null 
order by 1,2;

--we are going be to using a special parts from my big data - specific some columns-
-- to query about Hieghest Infection Countries (Max Total Cases )
select location , population ,Max(total_cases /population ) * 100  as TatalCasespercentage,
Max(total_cases) as Hieghest_Infection from CovidProject..CovidVaccines 
group by location , Population   
order by Hieghest_Infection Desc;

--we are going be to using a special parts from my big data - specific some columns-
-- to query about total case and total deaths for states in USA 
select location ,  population , total_cases , total_deaths 
from CovidProject..CovidVaccines 
where  location like '%states%' 
order by total_deaths Desc;


--we are going be to using a special parts from my big data - specific some columns-
-- to query about new_ Cases , total case and total deaths for My Country Egypt
select location ,population, date ,  total_cases , total_deaths
from CovidProject..CovidVaccines 
where date between '2022-01-01' and '2022-07-15' and location = 'Egypt'
order by total_cases Desc ;


--we are going be to using a special parts from my big data - specific some columns-
-- to query about Highest Infection Rate compared to Population in Counteries 
Select Location, Population, MAX(total_cases) as HighestInfectionCases,  Max((total_cases/population))*100 as PercentagePopulationInfected
From CovidProject..CovidVaccines
Group by Location, Population
order by PercentagePopulationInfected Desc;



--we are going be to using a special parts from my big data - specific some columns-
-- to query about Highest Infection Rate compared to Population in Counteries 
Select Location, Population, MAX(total_cases) as HighestInfectionCases,  Max((total_cases/population))*100 as PercentagePopulationInfected
From CovidProject..CovidVaccines
Group by Location, Population
order by PercentagePopulationInfected Desc;


--we are going be to using a special parts from my big data - specific some columns-
-- to query about total deaths in all Continents 
select continent , Max(total_deaths) as HighestTotalDeaths from CovidProject..CovidVaccines
where continent is not null 
group by continent
order by HighestTotalDeaths Desc;


--we are going be to using a special parts from my big data - specific some columns-
-- to query about Highest total deaths in all Continents 
-- CAST is a function used to use an expression from one data type to another data type.
select continent , Max(cast(total_deaths as int )) as HighestTotalDeaths from CovidProject..CovidVaccines
where continent is not null 
group by continent
order by HighestTotalDeaths Desc;


--we are going be to using a special parts from my big data - specific some columns-
-- to query about total deaths in all Continents and highest containents deaths per population 
select continent ,population ,total_deaths,  ((total_deaths/population)*100) as percentagedeathsincontainents 
from CovidProject..CovidVaccines
where continent is not null 
order by percentagedeathsincontainents Desc;


--we are going be to using a special parts from my big data - specific some columns-
--To know the rate of new deaths in relation to new cases daily 
select date , sum(new_cases) as tot_cases_daily , sum(cast(new_deaths as int )) as tot_deaths_daily ,
(sum(cast(new_deaths as int )) / sum(new_cases) * 100 ) as percent_of_new_deaths_per_new_cases 
from CovidProject..CovidVaccines
where continent is not null 
group by date 
order by percent_of_new_deaths_per_new_cases Desc ;


--we are going be to using a special parts from my big data - specific some columns-
--To know sum of new deaths , sum of new Cases and the sum of new deaths  ain relation to new cases daily  from start this pandemic
select  sum(new_cases) as tot_cases_daily , sum(cast(new_deaths as int )) as tot_deaths_daily ,
(sum(cast(new_deaths as int )) / sum(new_cases) * 100 ) as percent_of_new_deaths_per_new_cases 
from CovidProject..CovidVaccines


--To link the two tables together CovidVacines & CovidDeaths 
-- first query about new table CovidDeaths 
select * from CovidProject..CovidDeaths;

--To link the two tables together CovidVacines & CovidDeaths 
--Here we see some common columns between the two tables and we use to join them together (Join Function)such as location , date , continent ....
-- let's goo
select * 
from  CovidProject..CovidVaccines CDV
join CovidProject..CovidDeaths CDD 
on 
CDV.location = CDD.location 
and CDV.date = CDD.date;

--we are going be to using a special parts from my big data - specific some columns-
--We'll join both tables by some common columns, but let's keep in mind new vaccinations column 
select CDD.continent, CDD.location ,CDD.date,CDD.population , CDV.new_vaccinations  
from  CovidProject..CovidVaccines CDV
join CovidProject..CovidDeaths CDD 
on 
CDV.location = CDD.location 
and CDV.date = CDD.date
where CDD.continent is not null 
order by 1,2,3 ;



--we are going be to using a special parts from my big data - specific some columns-
--We'll join both tables by some common columns, but let's keep in mind new vaccinations column 
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select CDD.continent, CDD.location, CDD.date, CDD.population, CDV.new_vaccinations
, SUM(CONVERT(int,CDV.new_vaccinations)) OVER (Partition by CDD.Location Order by CDD.location, CDD.date) as Peoplevaccination
, (CDV.new_vaccinations/CDV.population)*100 as percentageofPeoplevaccination
From CovidProject..CovidDeaths CDD
Join CovidProject..CovidVaccines CDV
	On CDD.location = CDV.location
	and CDD.date = CDV.date
where CDD.continent is not null 
order by percentageofPeoplevaccination Desc;















