create database ds_skills_db;
use ds_skills_db;

create table skills (
	skill_id int primary key,
    job_skills text not null
);

create table company (
	company_id int primary key,
    company text not null
);

create table location (
	location_id int primary key,
    job_location text not null
);

create table jobs (
	job_posting_id int primary key,
    job_title text,
    company_id int,
    company text,
    location_id int,
    job_location text,
    job_level varchar(255),
    job_type varchar(255),
    foreign key (company_id) references company(company_id),
    foreign key (location_id) references location(location_id)
);

create table job_skills (
	job_posting_id int,
    skill_id int,
    primary key (job_posting_id, skill_id),
    foreign key (job_posting_id) references jobs(job_posting_id),
    foreign key (skill_id) references skills(skill_id)
);

alter table jobs
drop foreign key jobs_ibfk_1;
alter table jobs
drop foreign key jobs_ibfk_2;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/skills.csv"
into table skills 
fields terminated by ',' enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/company.csv"
into table company
fields terminated by ',' enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/location.csv"
into table location
fields terminated by ',' enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/jobs.csv"
into table jobs 
fields terminated by ',' enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(job_posting_id, job_title, company_id, company, location_id, job_location, job_level, job_type);

set foreign_key_checks = 0;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_skills.csv"
into table job_skills 
fields terminated by ',' enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

set foreign_key_checks = 1;

delete from jobs where job_posting_id is null;
delete from skills where skill_id is null;
delete from company where company_id is null;
delete from location where location_id is null;
delete from job_skills where job_posting_id is null or skill_id is null;

