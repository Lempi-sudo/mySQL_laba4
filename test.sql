 use session;
 show tables;
 SET SQL_SAFE_UPDATES = 0;
 

create view professor_on_first_year(title, professor_name,professor_lname)
as
select fy.title , p.fname, p.lname 
from first_year fy
inner join professor p on p.id_professor=fy.id_professor

 

