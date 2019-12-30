drop function f_lucroEntreDatas;
DELIMITER $$
CREATE FUNCTION f_lucroEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS Decimal(9,3)
deterministic 
BEGIN
Declare total Decimal(9,3);
Select sum(a.price)
into total
from Appointment a
where a.date>=date1
and a.date <= date2;
RETURN total;
END $$


drop function f_especialidadeEntreDatas;
DELIMITER $$
CREATE FUNCTION f_especialidadeEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(20)
deterministic 
BEGIN
Declare esp VARCHAR(20);
select e.designation into esp
from expertise e 
inner join doctor d on e.idExpertise = d.idExpertise
inner join appointment a on a.idDoctor = d.idDoctor
where a.date>=date1
and a.date <= date2
group by e.designation
order by count(e.idExpertise) DESC limit 1;
RETURN esp;
END $$

drop function f_clubeEntreDatas;
DELIMITER $$
CREATE FUNCTION f_clubeEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select b.name into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
inner join club b on b.idClub = atl.idClub
where a.date>=date1
and a.date <= date2
group by b.name
order by count(b.name) DESC limit 1;
RETURN res;
END $$

drop function f_atletaEntreDatas;
DELIMITER $$
CREATE FUNCTION f_atletaEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select atl.name into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
where a.date>=date1
and a.date <= date2
group by atl.name
order by count(atl.name) DESC limit 1;
RETURN res;
END $$


drop function f_doctorEntreDatas;
DELIMITER $$
CREATE FUNCTION f_doctorEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select d.name into res
from appointment a
inner join doctor d on a.idDoctor = d.idDoctor
where a.date>=date1
and a.date <= date2
group by d.name
order by count(d.name) DESC limit 1;
RETURN res;
END $$


drop function f_categoryEntreDatas;
DELIMITER $$
CREATE FUNCTION f_categoryEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select c.name into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
inner join category c on c.idCategory = atl.idCategory
where a.date>=date1
and a.date <= date2
group by c.name
order by count(c.name) DESC limit 1;
RETURN res;
END $$

drop function f_modalityEntreDatas;
DELIMITER $$
CREATE FUNCTION f_modalityEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select m.name into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
inner join modality m on m.idModality = atl.idModality
where a.date>=date1
and a.date <= date2
group by m.name
order by count(m.name) DESC limit 1;
RETURN res;
END $$


drop function f_lucroDoctorEntreDatas;
DELIMITER $$
CREATE FUNCTION f_lucroDoctorEntreDatas(
    id INT(11),
    date1 Datetime,
    date2 Datetime
) RETURNS decimal(8,2)
deterministic 
BEGIN
Declare res decimal(8,2);
Select sum(a.price) into res
from appointment a inner join doctor d on d.idDoctor = a.idDoctor
where a.idDoctor = id
and a.finished = 1
and a.date>=date1
and a.date <= date2;
RETURN res;
END $$

drop function f_lucroAtleta;
DELIMITER $$
CREATE FUNCTION f_lucroAtleta(
    id INT(11)
) RETURNS decimal(8,2)
deterministic 
BEGIN
Declare res decimal(8,2);
Select sum(a.price) into res
from appointment a inner join athlete atl on atl.idAthlete = a.idAthlete
where a.idAthlete = id
and a.finished = 1;
RETURN res;
END $$










