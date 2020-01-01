#drop function f_lucroEntreDatas;
#drop function f_especialidadeEntreDatas;
#drop function f_clubeEntreDatas;
#drop function f_atletaEntreDatas;
#drop function f_doctorEntreDatas;
#drop function f_categoryEntreDatas;
#drop function f_modalityEntreDatas;
#drop function f_lucroDoctorEntreDatas;
#drop function f_lucroAtleta;

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
where a.dateAppointment>=date1
and a.dateAppointment <= date2
and a.finished = 1;
RETURN total;
END $$


#drop function f_especialidadeEntreDatas;

DELIMITER $$
CREATE FUNCTION f_especialidadeEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(45)
deterministic 
BEGIN
Declare esp VARCHAR(45);
select e.designation into esp
from expertise e 
inner join doctor d on e.idExpertise = d.idExpertise
inner join appointment a on a.idDoctor = d.idDoctor
where a.dateAppointment>=date1
and a.dateAppointment <= date2
group by e.idExpertise
order by count(e.idExpertise) DESC limit 1;
RETURN esp;
END $$

#drop function f_clubeEntreDatas;
DELIMITER $$
CREATE FUNCTION f_clubeEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select b.nameClub into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
inner join club b on b.idClub = atl.idClub
where a.dateAppointment>=date1
and a.dateAppointment <= date2
group by b.idClub
order by count(b.nameClub) DESC limit 1;
RETURN res;
END $$

#drop function f_atletaEntreDatas;
DELIMITER $$
CREATE FUNCTION f_atletaEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select atl.nameAthlete into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
where a.dateAppointment>=date1
and a.dateAppointment <= date2
group by atl.idAthlete
order by count(atl.nameAthlete) DESC limit 1;
RETURN res;
END $$


#drop function f_doctorEntreDatas;
DELIMITER $$
CREATE FUNCTION f_doctorEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select d.nameDoctor into res
from appointment a
inner join doctor d on a.idDoctor = d.idDoctor
where a.dateAppointment>=date1
and a.dateAppointment <= date2
group by d.idDoctor
order by count(d.nameDoctor) DESC limit 1;
RETURN res;
END $$


#drop function f_categoryEntreDatas;
DELIMITER $$
CREATE FUNCTION f_categoryEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select c.nameCategory into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
inner join category c on c.idCategory = atl.idCategory
where a.dateAppointment>=date1
and a.dateAppointment <= date2
group by c.idCategory
order by count(c.nameCategory) DESC limit 1;
RETURN res;
END $$

#drop function f_modalityEntreDatas;
DELIMITER $$
CREATE FUNCTION f_modalityEntreDatas(
    date1 Datetime,
    date2 Datetime
) RETURNS VARCHAR(100)
deterministic 
BEGIN
Declare res VARCHAR(100);
select m.nameModality into res
from appointment a
inner join athlete atl on a.idAthlete = atl.idAthlete
inner join modality m on m.idModality = atl.idModality
where a.dateAppointment>=date1
and a.dateAppointment <= date2
group by m.idModality
order by count(m.nameModality) DESC limit 1;
RETURN res;
END $$


#drop function f_lucroDoctorEntreDatas;
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
and a.dateAppointment>=date1
and a.dateAppointment <= date2;
RETURN res;
END $$

#drop function f_lucroAtleta;
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










