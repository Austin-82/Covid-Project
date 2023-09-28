--Create MySQL table to prepare for CSV loading
USE covid_p

CREATE TABLE covid_new
(iso_code VARCHAR(255),
continent VARCHAR(255),
location VARCHAR(255),
date VARCHAR(255),
total_cases	double,
new_cases double,
new_cases_smoothed double,
total_deaths double,
new_deaths double,
new_deaths_smoothed double,
total_cases_per_million double,
new_cases_per_million double,
new_cases_smoothed_per_million double,
total_deaths_per_million double,
new_deaths_per_million double,
new_deaths_smoothed_per_million double,
reproduction_rate double,
icu_patients double,
icu_patients_per_million double,
hosp_patients double,
hosp_patients_per_million double,
weekly_icu_admissions double,
weekly_icu_admissions_per_million double,
weekly_hosp_admissions double,
weekly_hosp_admissions_per_million double,
new_tests double,
total_tests double,
total_tests_per_thousand double,
new_tests_per_thousand double,
new_tests_smoothed double,
new_tests_smoothed_per_thousand double,
positive_rate double,
tests_per_case double,
tests_units VARCHAR(255),
total_vaccinations double,
people_vaccinated double,
people_fully_vaccinated double,
new_vaccinations double,
new_vaccinations_smoothed double,
total_vaccinations_per_hundred double, 
people_vaccinated_per_hundred double, 
people_fully_vaccinated_per_hundred double,
new_vaccinations_smoothed_per_million double,
stringency_index double,
population double,
population_density double, 
median_age double,
aged_65_older double,
aged_70_older double,
gdp_per_capita double,
extreme_poverty double,
cardiovasc_death_rate double, 
diabetes_prevalence double,
female_smokers double,
male_smokers double,
handwashing_facilities double,
hospital_beds_per_thousand double,
life_expectancy double,
human_development_index double
);

--load csv file into MySql. if cell is empty, input null
LOAD DATA LOCAL INFILE '/Users/austinshirk/Documents/cs/Projects/Covid_Project/CovidDeaths.csv'
INTO TABLE covid_new
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @col2, @col3, @col4, @col5, @col6, @col7, @col8, @col9, 
@col10, @col11, @col12, @col13, @col14, @col15, @col16, @col17, 
@col18, @col19, @col20, @col21, @col22, @col23, @col24, @col25, 
@col26, @col27, @col28, @col29, @col30, @col31, @col32, @col33, 
@col34, @col35, @col36, @col37, @col38, @col39, @col40, @col41,
@col42, @col43, @col44, @col45, @col46, @col47, @col48, @col49,
@col50, @col51, @col52, @col53, @col54, @col55, @col56, @col57,
@col58, @col59)
SET
    iso_code = IF(@col1 = '', NULL, @col1),
	continent = IF(@col2 = '', NULL, @col2),
	location = IF(@col3 = '', NULL, @col3),
    date = IF(@col4 = '', NULL, @col4),
    total_cases = IF(@col5 = '', NULL, @col5),
    new_cases = IF(@col6 = '', NULL, @col6),
    new_cases_smoothed = IF(@col7 = '', NULL, @col7),
    total_deaths = IF(@col8 = '', NULL, @col8),
    new_deaths = IF(@col9 = '', NULL, @col9),
    new_deaths_smoothed = IF(@col10 = '', NULL, @col10),
    total_cases_per_million = IF(@col11 = '', NULL, @col11),
    new_cases_per_million = IF(@col12 = '', NULL, @col12),
    new_cases_smoothed_per_million = IF(@col13 = '', NULL, @col13),
    total_deaths_per_million = IF(@col14 = '', NULL, @col14),
    new_deaths_per_million = IF(@col15 = '', NULL, @col15),
    new_deaths_smoothed_per_million = IF(@col16 = '', NULL, @col16),
    reproduction_rate = IF(@col17 = '', NULL, @col17),
    icu_patients = IF(@col18 = '', NULL, @col18),
    icu_patients_per_million = IF(@col19 = '', NULL, @col19),
    hosp_patients = IF(@col20 = '', NULL, @col20),
    hosp_patients_per_million = IF(@col21 = '', NULL, @col21),
    weekly_icu_admissions = IF(@col22 = '', NULL, @col22),
    weekly_icu_admissions_per_million = IF(@col23 = '', NULL, @col23),
    weekly_hosp_admissions = IF(@col24 = '', NULL, @col24),
    weekly_hosp_admissions_per_million = IF(@col25 = '', NULL, @col25),
    new_tests = IF(@col26 = '', NULL, @col26),
    total_tests = IF(@col27 = '', NULL, @col27),
    total_tests_per_thousand = IF(@col28 = '', NULL, @col28),
    new_tests_per_thousand = IF(@col29 = '', NULL, @col29),
    new_tests_smoothed = IF(@col30 = '', NULL, @col30),
    new_tests_smoothed_per_thousand = IF(@col31 = '', NULL, @col31),
    positive_rate = IF(@col32 = '', NULL, @col32),
    tests_per_case = IF(@col33 = '', NULL, @col33),
    tests_units = IF(@col34 = '', NULL, @col34),
    total_vaccinations = IF(@col35 = '', NULL, @col35),
	people_vaccinated = IF(@col36 = '', NULL, @col36),
	people_fully_vaccinated = IF(@col37 = '', NULL, @col37),
	new_vaccinations = IF(@col38 = '', NULL, @col38),
	new_vaccinations_smoothed = IF(@col39 = '', NULL, @col39),
	total_vaccinations_per_hundred = IF(@col40 = '', NULL, @col40),
	people_vaccinated_per_hundred = IF(@col41 = '', NULL, @col41),
	people_fully_vaccinated_per_hundred = IF(@col42 = '', NULL, @col42),
	new_vaccinations_smoothed_per_million = IF(@col43 = '', NULL, @col43),
	stringency_index = IF(@col44 = '', NULL, @col44),
	population = IF(@col45 = '', NULL, @col45),
	population_density = IF(@col46 = '', NULL, @col46),
	median_age = IF(@col47 = '', NULL, @col47),
	aged_65_older = IF(@col48 = '', NULL, @col48),
	aged_70_older = IF(@col49 = '', NULL, @col49),
	gdp_per_capita = IF(@col50 = '', NULL, @col50),
	extreme_poverty = IF(@col51 = '', NULL, @col51),
	cardiovasc_death_rate = IF(@col52 = '', NULL, @col52),
	diabetes_prevalence = IF(@col53 = '', NULL, @col53),
	female_smokers = IF(@col54 = '', NULL, @col54),
	male_smokers = IF(@col55 = '', NULL, @col55),
	handwashing_facilities = IF(@col56 = '', NULL, @col56),
	hospital_beds_per_thousand = IF(@col57 = '', NULL, @col57),
	life_expectancy = IF(@col58 = '', NULL, @col58),
	human_development_index = IF(@col59 = '', NULL, @col59);



--change 'date' column datatype from string to date by first adding a 'new_date' column
ALTER TABLE covid_new
add column new_date DATE;

-- Update the 'new_date' column by converting 'date' values to the date format.
UPDATE covid_new
SET new_date = str_to_date(date, '%m/%d/%y');

-- Rename the original 'date' column to 'old_date'
ALTER TABLE covid_new
RENAME COLUMN date TO old_date;

-- Rename the 'new_date' column to 'date'
ALTER TABLE covid_new
RENAME COLUMN new_date TO date;

    

