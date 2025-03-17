-- data cleaning

SELECT *
FROM layoffs;


-- 1. Remove duplicates 
-- 2. Standardize the data issues with spelling
-- 3. NULL values or blank values 
-- 4. Remove any columns and rows that are not necessary - few ways


-- Create another table so that you dont change or mess up from OG table
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


-- Remove duplicates 
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`)AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num > 1;


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

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- standardizing data 
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
order by 1;

-- Update to Crypto
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT distinct country, trim(trailing '.' from country)
FROM layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country LIKE 'United States%';


-- change date to SQL date format
SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

-- chamge date from text to date
alter table layoffs_staging2
modify column `date` date; 

select *
from layoffs_staging2;


-- remove NULL and blank values 
select *
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

select *
from layoffs_staging2
where industry is NULL 
or industry = '';

select *
from layoffs_staging2
where company LIKE 'Bally%s Interactive';

-- fill the other empty colum 'industry' with travel
select t1.industry, t2.industry
from layoffs_staging2 t1
	Join layoffs_staging2 t2
    on t1.company = t2.company
where (t1.industry IS NULL or t1.industry = '')
and t2.industry is NOT NULL;

update layoffs_staging2 t1
Join layoffs_staging2 t2
    on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry IS NULL
and t2.industry is NOT NULL;

update layoffs_staging2
set industry = NULL
where industry = '';

select *
from layoffs_staging2;

-- delete columns we dont need 
delete
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

select *
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

select *
from layoffs_staging2;

-- drop row_num 
alter table layoffs_staging2
drop column row_num;
