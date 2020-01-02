USE umclinic;

#drop procedure p_adicionarConsulta;
#drop procedure p_alterarHorarioConsulta;
#drop procedure p_listarConsultasEntreDatas;
#drop procedure p_listarRealizadasEntreDatas;
#drop procedure p_listarConsultasAtleta;
#drop procedure p_listarMarcadasEntreDatas;
#drop procedure p_eliminarConsulta;
#drop procedure p_alterarPesoAtleta;
#drop procedure p_finalizarConsulta;
#drop procedure p_addObservations;

DELIMITER //
CREATE PROCEDURE p_completedAppointments()
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 1;
END //
DELIMITER ;
																    
#drop procedure p_scheduledAppointmentsBetweenDates;
DELIMITER //
CREATE PROCEDURE p_scheduledAppointmentsBetweenDates (IN date1 Datetime, date2 Datetime)
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.dateAppointment>=date1
and a.dateAppointment <= date2
and finished = 0;
END //
DELIMITER ;

#drop procedure p_alterDateAppointment;
DELIMITER //
CREATE PROCEDURE p_alterDateAppointment (IN newDate Datetime, original Datetime, idD INT(11), idA INT(11))
BEGIN
if (f_diasAteConsulta(original)>0 
	and f_diasAteConsulta(newDate)>0 
    and (select finished from appointment) =0) THEN
		update appointment a set a.dateAppointment = newDate where a.dateAppointment = original and a.idDoctor = idD and idAthlete=idA;
END IF;
END //
DELIMITER ;

#drop procedure p_alterStateAppointment;
DELIMITER //
CREATE PROCEDURE p_alterStateAppointment (IN d Datetime, idD INT(11), idA INT(11))
BEGIN
UPDATE appointment
SET finished = 1
where idAthlete = idA
and idDoctor = idD
and dateAppointment = d;
END //
DELIMITER ;
									      


#drop procedure p_completedAppointmentsFromDate;
DELIMITER //
CREATE PROCEDURE p_completedAppointmentsFromDate (IN date1 Datetime)
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.dateAppointment<=date1
and a.finished = 1;
END //
DELIMITER ;
									      



DELIMITER //
CREATE PROCEDURE p_scheduleAppointmentsAthlete (IN idA INT(11))
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0
and a.idAthlete = idA;
END //
DELIMITER ;

							   
DELIMITER //
CREATE PROCEDURE p_appointmentsCompletedAthlete (IN idA INT(11))
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 1
and a.idAthlete = idA;
END //
DELIMITER ;
							    
DELIMITER //
CREATE PROCEDURE p_appointmentsCompletedDoctor (IN idD INT(11))
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 1
and a.idDoctor = idD;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_scheduleAppointmentsDoctor (IN idD INT(11))
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0
and a.idDoctor = idD;
END //
DELIMITER ;							    


#drop procedure p_scheduledAppointmentsAfterDate;
DELIMITER //
CREATE PROCEDURE p_scheduledAppointmentsAfterDate (IN date1 Datetime)
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.dateAppointment>=date1
and a.finished = 0;
END //
DELIMITER ;




#drop procedure p_alterWeightAthlete;
DELIMITER //
CREATE PROCEDURE p_alterWeightAthlete (IN peso decimal(4,1), id INT(11))
BEGIN
UPDATE athlete 
SET weight = peso
where idAthlete = id;
END //
DELIMITER ;



#drop procedure p_alterStateAppointment;
DELIMITER //
CREATE PROCEDURE p_alterStateAppointment (IN d Datetime, idD INT(11), idA INT(11))
BEGIN
UPDATE appointment
SET finished = 1
where idAthlete = idA
and idDoctor = idD
and dateAppointment = d;
END //
DELIMITER ;

#drop procedure p_addObservations;
DELIMITER //
CREATE PROCEDURE p_addObservations (IN d Datetime, idD INT(11), idA INT(11), obs TEXT)
BEGIN
UPDATE appointment
SET observations = obs
where idAthlete = idA
and idDoctor = idD
and dateAppointment = d;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE p_doctorsNotAthleteCity (IN cityAthlete varchar(30))
BEGIN
Select distinct d.nameDoctor as Name
from appointment a  
inner JOIN doctor d on d.idDoctor = a.idDoctor
inner join athlete atl on atl.idAthlete = a.idAthlete
inner join zipcode z on z.zipcode = atl.idZipcode
where z.city not in (cityAthlete);
END //
DELIMITER ;

drop procedure p_alterZipcodeAthlete;
DELIMITER //
CREATE PROCEDURE p_alterZipcodeAthlete (IN codigoPostal VARCHAR(10), id INT(11))
BEGIN
UPDATE athlete 
SET idZipcode = codigoPostal
where idAthlete = id;
END //
DELIMITER ;
									    

DELIMITER //
CREATE PROCEDURE p_athletesOneExpertise ()
BEGIN
Select atl.nameAthlete as Name, e.designation as Expertise
from appointment a 
INNER JOIN athlete atl on atl.idAthlete= a.idAthlete
INNER JOIN doctor d on  d.idDoctor = a.idDoctor
INNER JOIN expertise e on d.idExpertise = e.idExpertise
group by a.idAthlete
having count(*) = 1;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_expertiseMoreAppointments ()
BEGIN
Select e.designation as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN doctor d on  d.idDoctor = a.idDoctor
INNER JOIN expertise e on d.idExpertise = e.idExpertise
group by (e.idExpertise) 
order by (count(*)) desc limit 5;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE p_categoryMoreAppointments ()
BEGIN
Select c.nameCategory as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN category c ON c.idCategory = atl.idCategory
group by (c.idCategory) 
order by (count(*)) desc;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_modalityMoreAppointments ()
BEGIN
Select m.nameModality as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN modality m ON m.idModality = atl.idModality
group by (m.idModality) 
order by (count(*)) desc limit 5;
END //
DELIMITER ;

#ainda falta testar esta
DELIMITER //
CREATE PROCEDURE p_clubMoreAppointments()
BEGIN
Select c.nameClub as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN club c ON c.idClub = atl.idClub
group by (c.idClub) 
order by (count(*)) desc limit 5;
END //
DELIMITER ;

#ainda falta testar esta
DELIMITER //
CREATE PROCEDURE p_athleteMoreAppointments ()
BEGIN
Select atl.nameAthlete as Name, count(*) as NumberOfAppointments
from appointment a, athlete atl
where atl.idAthlete= a.idAthlete
group by (a.idAthlete) 
order by (count(*)) desc limit 5;
END //
DELIMITER ;

#ainda falta testar esta
DELIMITER //
CREATE PROCEDURE p_moreAppointmentsDoctor()
BEGIN
Select d.nameDoctor as Name, count(*) as NumberOfAppointments
from appointment a, doctor d
where d.idDoctor = a.idDoctor
group by (a.idDoctor) 
order by (count(*)) desc limit 1;
END //
DELIMITER ;


#ainda falta testar esta
DELIMITER //
CREATE PROCEDURE p_appointmentsByDoctor()
BEGIN
Select d.nameDoctor as Name, count(*) as NumberOfAppointments
from appointment a, doctor d
where d.idDoctor = a.idDoctor
group by (a.idDoctor) 
order by (count(*)) desc;
END //
DELIMITER ;

#ainda falta testar esta
DELIMITER //
CREATE PROCEDURE p_AverageWeight()
BEGIN
Select avg(a.weight) as "Peso médio" 
from athlete a;
END //
DELIMITER ;


#ainda falta testar esta
DELIMITER //
CREATE PROCEDURE p_doctorsByExpertise ()
BEGIN
Select e.designation as Expertise, count(*) as NumberOfDoctors
from doctor d, expertise e
where d.idExpertise = e.idExpertise
group by (e.idExpertise) 
order by (count(*)) desc;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE p_totalProfit ()
BEGIN
Select sum(a.price) as montante
from appointment a
where finished = 1;
END //
DELIMITER ;
		
DELIMITER //
CREATE PROCEDURE p_athletesOneExpertise ()
BEGIN
Select atl.nameAthlete as Name, e.designation as Expertise
from appointment a 
INNER JOIN athlete atl on atl.idAthlete= a.idAthlete
INNER JOIN doctor d on  d.idDoctor = a.idDoctor
INNER JOIN expertise e on d.idExpertise = e.idExpertise
group by a.idAthlete
having count(*) = 1;
END //
DELIMITER ;

