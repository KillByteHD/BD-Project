USE umclinic;
/*
drop function f_profitBetweenDates;
drop function f_moreAppointmentsExpertiseBetweenDates;
drop function f_moreAppointmentsClubBetweenDates;
drop function f_moreAppointmentsAthleteBetweenDates;
drop function f_moreAppointmentsDoctorBetweenDates;
drop function f_moreAppointmentsCategoryBetweenDates;
drop function f_moreAppointmentsModalityBetweenDates;
drop function f_profitFromDoctorBetweenDates;
drop function f_profitFromAthlete;
drop function f_daysTillAppointment;

*/
DELIMITER $$
CREATE FUNCTION f_profitBetweenDates(
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


#drop function f_moreAppointmentsExpertiseBetweenDates;

DELIMITER $$
CREATE FUNCTION f_moreAppointmentsExpertiseBetweenDates(
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

#drop function f_moreAppointmentsClubBetweenDates;
DELIMITER $$
CREATE FUNCTION f_moreAppointmentsClubBetweenDates(
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

#drop function f_moreAppointmentsAthleteBetweenDates;
DELIMITER $$
CREATE FUNCTION f_moreAppointmentsAthleteBetweenDates(
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


#drop function f_moreAppointmentsDoctorBetweenDates;
DELIMITER $$
CREATE FUNCTION f_moreAppointmentsDoctorBetweenDates(
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


#drop function f_moreAppointmentsCategoryBetweenDates;
DELIMITER $$
CREATE FUNCTION f_moreAppointmentsCategoryBetweenDates(
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

#drop function f_moreAppointmentsModalityBetweenDates;
DELIMITER $$
CREATE FUNCTION f_moreAppointmentsModalityBetweenDates(
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


#drop function f_profitFromDoctorBetweenDates;
DELIMITER $$
CREATE FUNCTION f_profitFromDoctorBetweenDates(
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

#drop function f_profitFromAthlete;
DELIMITER $$
CREATE FUNCTION f_profitFromAthlete(
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

DELIMITER $$
CREATE FUNCTION f_daysTillAppointment(
    dateAppoint Datetime
) RETURNS int(11)
deterministic 
BEGIN
Declare res int(11);
DECLARE dateNow datetime;
select current_timestamp INTO dateNow;
if(DATEDIFF(dateAppoint,dateNow)<0)
then return -1;
else return DATEDIFF(dateAppoint,dateNow);
END IF;
END $$









