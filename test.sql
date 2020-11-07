 use session;
 show tables;
 SET SQL_SAFE_UPDATES = 0;
 
 

 
 create algorithm=merge 
 view  professor_count_discipline 
 as 
 select p.fname ,p.lname , count(p.id_professor) count_discipline 
 from education_discipline ed
 inner join professor p on p.id_professor=ed.id_professor
 group by p.id_professor;
 

