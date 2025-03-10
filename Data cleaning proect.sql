select * from layoffs;

  -- Data Cleaning

-- 1. Removing dublicats
-- 2. Standartaising information
-- 3. Nulls and Blankets
-- 4. Daleting any unnecessary columns

create table layoff1
like layoffs;

insert into layoff1
select * from layoffs;
select * from layoff1;

-- 1. Removing dublicats
select distinct company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, country, funds_raised_millions
 from layoff1;
 create table layoff2
 like layoff1;
 insert into layoff2
 select distinct company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, country, funds_raised_millions
 from layoff1;
 select * from layoff2;
 
 -- 2. Data standartaising
 
select industry from layoff2
group by industry
order by industry;
update layoff2
set country = 'United States'
where country = 'United States.';
update layoff2
set industry = 'Other'
where industry is null or industry = '';
update layoff2
set industry = 'Crypto'
where industry = 'Crypto Currency' or industry='CryptoCurrency';
update layoff2
set company = trim(company), location = trim(location), industry = trim(industry), total_laid_off = trim(total_laid_off), percentage_laid_off = trim(percentage_laid_off)
, `date` = trim(`date`), stage = trim(stage), country = trim(country), funds_raised_millions = trim(funds_raised_million);
update layoff2
set `date`=str_to_date(`date`,'%m/%d/%Y');
alter table layoff2
modify `date` date;
update layoff2
set industry='Travel'
where company = 'Airbnb';
update layoff2
set industry='Transportation'
where company = 'Carvana';
update layoff2
set industry='Consumer';

-- 3. Nulls and Blankets
delete  from layoff2
where total_laid_off is null
 and percentage_laid_off is null;




















