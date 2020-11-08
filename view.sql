#Представления

#1
#Создать два не обновляемых представления, возвращающих пользователю результат из нескольких таблиц,
# с разными алгоритмами обработки представления.
 
 use session;
 SET SQL_SAFE_UPDATES = 0;
 
#1.1
create algorithm=temptable
view after_1999_studet
as 
select s.fname,s.lname,ed.title ,m.value_mark from mark m 
inner join student s on s.st_book_id=m.st_book_id
inner join education_discipline ed on ed.id_education_discipline=m.id_education_discipline
where m.st_book_id in  
(select s.st_book_id  from student s
where year(s.birth_date)>1999);
 
#1.2
create algorithm=merge 
view  professor_count_discipline 
as 
select p.fname ,p.lname , count(p.id_professor) count_discipline 
from education_discipline ed
inner join professor p on p.id_professor=ed.id_professor
group by p.id_professor;





#3. Создать обновляемое представление, позволяющее выполнить команду INSERT.
create view first_year
as
select ed.title ,ed.number_semestr,ed.id_professor
from education_discipline ed
where ed.number_semestr='1' or ed.number_semestr='2';

update first_year
set title='TerVer and MatStat'
where title='MatStat';

INSERT INTO first_year(title,number_semestr,id_professor)
VALUES ('Assembler','5','5');






#2. Создать обновляемое представление, не позволяющее выполнить команду INSERT.
use bank;
 
create view	only_man_person
as
select  p.fname, p.lname from person p 
where p.gender='M';

UPDATE only_man_person SET fname='Andrei'
where fname='Andrey';

INSERT INTO  only_man_person(fname,lname) VALUES ('petr','gaf');





#4
#Создать вложенное обновляемое представление с проверкой ограничений (WITH CHECK OPTION).

create view	only_woman_person
as
select * from person p 
where p.gender='F';


create view only_woman_from_russia
as
select * 
from only_woman_person woman
where woman.country='Russia'
WITH CHECK OPTION; #по умолчанию WITH CASCADED CHECK OPTION;


UPDATE only_woman_from_russia SET country='CHICAGO'
where person_id=4; #ошибка 


UPDATE only_woman_from_russia SET country='German'
where country='Russia' ; #ошибка 


INSERT INTO  only_woman_from_russia(person_id,fname,lname,gender,country)
VALUES (6,'anna','petrova','F','Russia'); #все ок 

INSERT INTO  only_woman_from_russia(person_id,fname,lname,gender,country)
VALUES (7,'anna','petrova','F','USA'); #выдаст ошибку 






