 use session;
 show tables;
 
 
 create view first_year
 as
 select *
 from education_discipline ed
 where ed.number_semestr='1' or ed.number_semestr='2';
 

