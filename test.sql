use bank;
SET SQL_SAFE_UPDATES = 0;
 
create view	only_man_person
as
select  p.fname, p.lname from person p 
where p.gender='M';

UPDATE only_man_person SET fname='Andrei'
where fname='Andrey';

INSERT INTO  only_man_person(fname,lname) VALUES ('petr','gaf');


