
--Üherealine kommentaar (algab kahe sidekriipusuga ja lõpeb rea lõpuga)

--Mitu klienti meil andmebaasis on?

select count(*) from customers;

--Veeru rea muutmine kliendite arvuks 3150
select count(*) as klientide_arv from customers;

select * from customers;

select * from customers limit 5;

--Kui ma tahan kindlaid veerge tabelisse
select first_name, last_name, email, city
from customers
limit 10;

--muutsin nende veergude hüüdnime
select 
  first_name AS eesnimi, 
  last_name as perenimi, 
  email as epost, 
  city as linn
from customers
limit 10;

--Anna mulle kõik Haapsalu kliendid
select * from customers
where city = 'Haapsalu';

select count(*) from customers
where city = 'Haapsalu';
--82

select count(*) from customers
where lower(city) = 'haapsalu';
--89

--Mis linnad meil üldse on esindatud klientide poolest?
select distinct city from customers;

--tähestikujärjekorras
select distinct city 
from customers
order by city asc; --asc:kasvavalt (vaikimisi) desc:kahanevalt


select *
from customers
where email is NULL; --kui nulliga võrdleme siis kasutame is

select count(*)
from customers
where email is NULL; --380

select count(*)
from customers
where email is not NULL; -- 2770

select count(*) from customers;
select count(email) from customers; --2770
select count(distinct email) from customers; --2640

--Mitu dubleeritud meiliaadressi?
select count(email) - count(distinct email) as duplikaadid from customers; --130

--Anna kõige suurema summaga tehing müügitabelis
select * from sales limit 10;

select * from sales
order by total_price desc
limit 1; -- 2170.40

select max(total_price)
from sales;

select * from sales
order by sale_date desc
limit 10; 

select channel, count(*) as tellimusi
from sales
group by channel;

select max(channel), count(*) from sales where channel ='pood'
union
select max(channel), count(*) from sales where channel ='online'
--union on kahe päringu ühendamine



