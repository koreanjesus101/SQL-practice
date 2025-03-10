-- Data cleaning 
Select *
from layoffs;


-- 1. Remove duplicates 
-- 2. Standardize the data 
-- 3. Fill in Null values or blank values 
-- 4. Remove unecessary columns or rows 

-- 1 Remove duplicates 
Create table layoffs_staging
like layoffs;

Select *
from layoffs_staging;

Insert layoffs_staging
select*
from layoffs;

select*,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

With duplicates_cte as
(
select*,
row_number() over(
partition by company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicates_cte
where row_num > 1;

Select *
from layoffs_staging
where company = 'Casper';

With duplicates_cte as
(
select*,
row_number() over(
partition by company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
delete 
from duplicates_cte
where row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


Select *
from layoffs_staging2
where row_num > 1;

Insert into layoffs_staging2
select*,
row_number() over(
partition by company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

Delete 
from layoffs_staging2
where row_num > 1;

Select *
from layoffs_staging2
order by location ASC;


-- 2. Standardize the data 

Select company, (Trim(company))
from layoffs_staging2;

update layoffs_staging2
set company = (Trim(company)); -- take out white spaces

Select distinct country
from layoffs_staging2
order by 1
;

Update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

Select distinct country, Trim(trailing '.' from country)
from layoffs_staging2
order by 1
;

Update layoffs_staging2
set country = Trim(trailing '.' from country)
where country like 'United States%';

Select `date`
from layoffs_staging2;

UPDATE layoffs_staging2
set `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = null
WHERE INDUSTRY = '';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
or industry = '';

SELECT *
FROM layoffs_staging2
WHERE company like 'Bally%';


SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company 
WHERE (t1.industry IS NULL OR t1.industry = '')
and t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
and t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;













