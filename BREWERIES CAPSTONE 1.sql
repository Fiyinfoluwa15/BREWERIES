SELECT *
FROM International_Breweries$ 

-- PROJECT ANALYSIS
-- 1. within the space of the last three years, what was the profit worth of the breweries
-- inclusive of francophone and anglophone territories?

select YEARS, SUM(PROFIT) as total_profit
FROM International_Breweries$
group by YEARS

-- 2. compare the total profit between these two territories in order for the territory manager, 
-- Mr. Stone to make a strategic decision that will aid profit maximization in 2020. 
select sum(profit) as total_profit, countries, 
		case when countries = 'nigeria' then 'anglophone'
		when countries = 'ghana' then 'anglophone'
		else 'francophone' end as LINGUA
from International_Breweries$
group by COUNTRIES

-- TRIAL : ADDING LINGUA TO THE TABLE 
ALTER TABLE international_breweries$
ADD LINGUA varchar(255)

UPDATE International_Breweries$
SET LINGUA = 'Anglophone'
where countries = 'Ghana' or countries ='Nigeria' 
UPDATE International_Breweries$
SET LINGUA = 'francophone'
where countries = 'Benin' or countries ='Senegal' or countries ='Togo'

select *
from International_Breweries$

-- ABOVE TRIAL WORKED ! REDOING Q2 -compare the total profit between these two territories 
select sum(profit) as total_profit, LINGUA 
from International_Breweries$
group by LINGUA

-- 3. what country generated the highest profit in 2019?
select countries, sum(profit) as country_profit
from International_Breweries$
where YEARS =2019
group by COUNTRIES 
order by sum(profit) desc

-- 4. help him find the year with the highest profit?
select years, sum (profit) as yearly_profit
from International_Breweries$
group by YEARS
order by sum(profit) desc

-- 5.Which month in the three years was the least profit generated? 
select months, sum(profit) as monthly_profit
from International_Breweries$
group by months 
order by sum(profit)

--6. what was the minimum profit in the month of December 2018?
select *
from International_Breweries$
where months = 'december'
 and years = '2018'
 order by PROFIT 

--7. Compare the profit for each of the months in 2019.
select months, sum(profit) as profit2019 
from International_Breweries$
where years=2019
group by months 

--8. which particular brand generated the highest profit in Senegal?
select BRANDS, sum(profit) as profit_bybrand
from International_Breweries$
where countries = 'senegal'
group by BRANDS
order by sum(profit) desc

-- BRAND ANALYSIS
--1. within the last two years, the brand manager wants to know the top three brands consumed in francophone countries?
select BRANDS, sum(QUANTITY) as qty_bybrand
from International_Breweries$
where lingua = 'francophone'
and (years = 2019 or years = 2018) 
group by BRANDS
order by sum(QUANTITY) desc
-- LIMIT by 3 

--2. find out the top two choice of consumer brands in Ghana.
select brands, sum(QUANTITY) as qty_ghana
from International_Breweries$
where COUNTRIES= 'ghana'
group by BRANDS
order by qty_ghana desc

--3. find out the details of beers consumed in past three years in the most oil reached country in West Africa?
select *
from International_Breweries$
where countries = 'nigeria'

--4. favorites malt brand in Anglophone region between 2018 and 2019
select BRANDS, years, sum(quantity) as malt_qty
from International_Breweries$
where lingua = 'anglophone'
and brands like '%malt%'
and YEARS != 2017
group by brands, years 
order by sum(quantity) desc


--5. which brands sold the highest in 2019 in Nigeria?
select BRANDS,sum(quantity) as brand_qty
from International_Breweries$
where YEARS = 2019
and COUNTRIES= 'nigeria'
group by (brands)
order by sum(quantity) desc

--6. favorites brand in south_south region in Nigeria 
select BRANDS,sum(quantity) as brand_qty
from International_Breweries$
where REGION = 'south_south'
and COUNTRIES= 'nigeria'
group by (brands)
order by sum(quantity) desc

--7. Beer consumption in NIgeria
select brands, sum(quantity) as region_qtytotal
from International_Breweries$
where countries = 'nigeria'
group by brands
order by sum(quantity) desc


--8. level of consumption of Budweiser in the regions in Nigeria 
select region, sum(quantity) as region_qtytotal
from International_Breweries$
where countries = 'nigeria'
and BRANDS='budweiser'
group by REGION
order by sum(quantity) desc

--9. level of consumption of Budweiser in the regions in Nigeria in 2019. 
select region, sum(quantity) as region_qtytotal
from International_Breweries$
where countries = 'nigeria'
and BRANDS='budweiser'
and years=2019
group by REGION
order by sum(quantity) desc

-- COUNTRIES ANALYSIS 
-- 1. country with the highest consumption of beer 
select countries, sum(quantity) as brand_totalqty
from International_Breweries$
group by countries 
order by sum(quantity) desc

--2. highest sales personnel of budweiser in Senegal 
select SALES_REP, sum (quantity)
from International_Breweries$
where countries='senegal'
and BRANDS='budweiser'
group by SALES_REP
order by sum(quantity)
-- not sure about this

--3. country with the highest profit of the fourth quarter in 2019
-- this would also need grouping 
ALTER TABLE international_breweries$
ADD QUARTERS varchar(255)

UPDATE International_Breweries$
SET QUARTERS = 'Q4'
where months ='october' or months ='november' or months ='december' 

select * 
from International_Breweries$

select COUNTRIES, max(profit) as highest_profit 
from  International_Breweries$
where quarters = 'Q4'
and years = 2019
group by countries
order by max(profit) desc
