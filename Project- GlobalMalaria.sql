--This project seeks to look at the corrolation between Global Malaria incidents vs Global Malaria deaths.


--First, looking at the dataset to ensure it imported correctly. 
Select*
From PortfolioProject..GlobalMalariaDeaths
order by 1,2

-- Now selecting all the dataset as it is to ensure once more that it was correctly imported
Select* 
From PortfolioProject..GlobalMalariaIncidents

--Proceeding to select the datasets that will be explored

Select Entity,Year, malaria_deaths
From PortfolioProject..GlobalMalariaDeaths

--Looking at the total cases by continent in 2015 vs 2020

Select Entity,Year, malaria_deaths
From PortfolioProject..GlobalMalariaDeaths
Where Year like '%2015%'

Select Entity,Year, malaria_deaths
From PortfolioProject..GlobalMalariaDeaths
Where Year like '%2020%'

--It seems there were less cases in 2020 on every continent execpt Africa and Eastern Mediterranean region.

Select Entity, Year, malaria_deaths, MAX(malaria_deaths) as HighestDeathCount
From PortfolioProject..GlobalMalariaDeaths
Where Year like '%2015%'

--Joining the Malaria Death dataset with the Malaria incident dataset

Select MDeaths.Entity,MDeaths.Year, MDeaths.malaria_deaths, MIncidents.malaria_incidents
From PortfolioProject..GlobalMalariaDeaths as MDeaths
Left Join PortfolioProject..GlobalMalariaIncidents as MIncidents
	On MDeaths.Entity = MIncidents.Entity
	and MDeaths.Year = MIncidents.Year

--Creating a table to have the final view of the datasets
DROP Table if exists #MalariaCasesGlobally
Create Table #MalariaCasesGlobally
( Entity nvarchar (250),
 Year nvarchar (250),
malaria_incidents nvarchar (250),
malaria_deaths nvarchar (250),
)
Insert into #MalariaCasesGlobally
Select MDeaths.Entity,MDeaths.Year, MDeaths.malaria_deaths, MIncidents.malaria_incidents
From PortfolioProject..GlobalMalariaDeaths as MDeaths
Left Join PortfolioProject..GlobalMalariaIncidents as MIncidents
	On MDeaths.Entity = MIncidents.Entity
	and MDeaths.Year = MIncidents.Year
Order by 1,2

--Creating a permanent table
Create View MalariaCasesGlobally as
Select MDeaths.Entity,MDeaths.Year, MDeaths.malaria_deaths, MIncidents.malaria_incidents
From PortfolioProject..GlobalMalariaDeaths as MDeaths
Left Join PortfolioProject..GlobalMalariaIncidents as MIncidents
	On MDeaths.Entity = MIncidents.Entity
	and MDeaths.Year = MIncidents.Year
