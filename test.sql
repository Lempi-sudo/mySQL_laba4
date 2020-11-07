 use session;
 show tables;
 SET SQL_SAFE_UPDATES = 0;
 
create algorithm=temptable
view after_1999_studet
as 
select s.fname,s.lname,ed.title ,m.value_mark from mark m 
inner join student s on s.st_book_id=m.st_book_id
inner join education_discipline ed on ed.id_education_discipline=m.id_education_discipline
where m.st_book_id in  
(select s.st_book_id  from student s
where year(s.birth_date)>1999);
 

