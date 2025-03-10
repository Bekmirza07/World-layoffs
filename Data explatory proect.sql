-- Finding max and min amounts, and ordering
select * from layoff2;
select max( total_laid_off) , max(percentage_laid_off) as max_laid_off from layoff2;
select * from layoff2
where percentage_laid_off = 1
order by funds_raised_millions desc;
select * from layoff2
where percentage_laid_off = 1
order by total_laid_off desc;

-- Sum of total laid off by different categories
select company, sum(total_laid_off) laid_off from layoff2
group by company
order by 2 desc;
select industry, sum(total_laid_off) laid_off from layoff2
group by industry
order by 2 desc;
select country, sum(total_laid_off) laid_off from layoff2
group by country
order by 2 desc;
select stage, sum(total_laid_off) laid_off from layoff2
group by stage
order by 2 desc;
select industry, sum(total_laid_off) laid_off from layoff2
group by industry
order by 2 desc;

-- Sum of total laid off by time
select min(`date`) , max(`date`) from layoff2;
select year(`date`) as years, sum(total_laid_off) from layoff2
where year(`date`) is not null
group by years
order by years desc;
select substring(`date`,1,7) as months, sum(total_laid_off) as laid_off from layoff2
where substring(`date`,1,7) is not null
group by months
order by 1 asc;
with rolling_example as
(select substring(`date`,1,7) as months, sum(total_laid_off) as laid_off from layoff2
where substring(`date`,1,7) is not null
group by months
order by 1 asc)
select  months , laid_off,
 sum(laid_off) over(order by months asc) as rolling_laid_off 
 from rolling_example;
 select company ,substring(`date`,1,4) as years, sum(total_laid_off) from layoff2
 where substring(`date`,1,4) is not null
 group by company , years
 order by 3 desc;
 
 -- Rankings of companies by total laid off
 with dense_ranking as
 (select company ,substring(`date`,1,4) as years, sum(total_laid_off) as laid_off from layoff2
 where substring(`date`,1,4) is not null
 group by company , years
 order by 3 desc)
 select company, years, laid_off, 
 dense_rank() over(partition by years order by laid_off desc) ranking
 from dense_ranking;
 with lower_ranks as (with dense_ranking as
 (select company ,substring(`date`,1,4) as years, sum(total_laid_off) as laid_off from layoff2
 where substring(`date`,1,4) is not null
 group by company , years
 order by 3 desc)
 select company, years, laid_off, 
 dense_rank() over(partition by years order by laid_off desc) ranking
 from dense_ranking)
 select * from lower_ranks
 where ranking <=5;
 