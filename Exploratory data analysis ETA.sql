-- Exploratory data analysis 
select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1 -- compnaies that went under and laid off 100% of employees
order by funds_raised_millions DESC;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

select min(`date`), max(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 DESC;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 DESC;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 DESC;

select stage, sum(total_laid_off) -- satge of the company Stage A: start up compnay almost
from layoffs_staging2
group by stage
order by 2 DESC;

select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

-- rolling total layoffs based on moths 
select substring(`date`, 1, 7) AS `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1, 7) is NOT NULL
group by `month`
order by 1 ASC;

with rolling_total as 
(
select substring(`date`, 1, 7) AS `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1, 7) is NOT NULL
group by `month`
order by 1 ASC
)
select `month`, total_off
, sum(total_off) over(order by `month`) as rolling_total
from Rolling_Total;



select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 DESC;

with Company_Year(company, years, total_laid_off) as 
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), Company_Year_Rank as
(select *, 
dense_rank() over (partition by years order by total_laid_off DESC) as Ranking
from Company_Year
where years is NOT NULL
)
select *
from Company_Year_Rank
where ranking <= 5
;





























