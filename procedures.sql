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

#drop procedure p_adicionarConsulta;
DELIMITER //
CREATE PROCEDURE p_adicionarConsulta (IN idDoctor INT(11), idAthlete INT(11), obs TEXT, p DECIMAL(7,2), dateAppointment Datetime, f TINYINT(4))
BEGIN
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (idDoctor, idAthlete, obs, p, dateAppointment, f);
END //
DELIMITER ;


drop procedure p_alterarHorarioConsulta;
DELIMITER //
CREATE PROCEDURE p_alterarHorarioConsulta (IN newDate Datetime, original Datetime, idD INT(11), idA INT(11))
BEGIN
update appointment a set a.dateAppointment = newDate where a.dateAppointment = original and a.idDoctor = idD and idAthlete=idA;
END //
DELIMITER ;


#drop procedure p_listarConsultasEntreDatas;
DELIMITER //
CREATE PROCEDURE p_listarConsultasEntreDatas (IN date1 Datetime, date2 Datetime)
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.dateAppointment>=date1
and a.dateAppointment <= date2;
END //
DELIMITER ;

#drop procedure p_listarRealizadasEntreDatas;
DELIMITER //
CREATE PROCEDURE p_listarRealizadasEntreDatas (IN date1 Datetime)
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.dateAppointment<=date1
and a.finished = 1;
END //
DELIMITER ;


#drop procedure p_listarConsultasAtleta;
DELIMITER //
CREATE PROCEDURE p_listarConsultasAtleta (IN idA INT(11))
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor;
END //
DELIMITER ;


#drop procedure p_listarMarcadasEntreDatas;
DELIMITER //
CREATE PROCEDURE p_listarMarcadasEntreDatas (IN date1 Datetime)
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.dateAppointment>=date1
and a.finished = 0;
END //
DELIMITER ;

#drop procedure p_eliminarConsulta;
DELIMITER //
CREATE PROCEDURE p_eliminarConsulta (IN idD INT(11), idA INT(11), d Datetime)
BEGIN
DELETE from appointment a 
where a.idDoctor=idD
and a.idAthlete=idA
and a.dateAppointment = d;
END //
DELIMITER ;


#drop procedure p_alterarPesoAtleta;
DELIMITER //
CREATE PROCEDURE p_alterarPesoAtleta (IN peso decimal(4,1), id INT(11))
BEGIN
UPDATE athlete 
SET weight = peso
where idAthlete = id;
END //
DELIMITER ;



#drop procedure p_finalizarConsulta;
DELIMITER //
CREATE PROCEDURE p_finalizarConsulta (IN d Datetime, idD INT(11), idA INT(11))
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
CREATE PROCEDURE p_medicosNaoConsultaAtletasCidade (IN cityAthlete varchar(30))
BEGIN
Select distinct d.nameDoctor as Name
from appointment a  
inner JOIN doctor d on d.idDoctor = a.idDoctor
inner join athlete atl on atl.idAthlete = a.idAthlete
inner join zipcode z on z.zipcode = atl.idZipcode
where z.city not in (cityAthlete);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_atletasSoConsultadosUmaEspecialidade ()
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
CREATE PROCEDURE p_especialidadeComMaisConsultas ()
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
CREATE PROCEDURE p_categoriasComMaisConsultas ()
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
CREATE PROCEDURE p_modalidadesComMaisConsultas ()
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
CREATE PROCEDURE p_clubesComMaisConsultas()
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
CREATE PROCEDURE p_atletasComMaisConsultas ()
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
CREATE PROCEDURE p_medicoComMaisConsultas()
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
CREATE PROCEDURE p_consultasPorMedico()
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
CREATE PROCEDURE p_mediaPeso()
BEGIN
Select avg(a.weight) as "Peso médio" 
from athlete a;
END //
DELIMITER ;


#ainda falta testar esta
DELIMITER //
CREATE PROCEDURE p_medicosPorEspecialidade ()
BEGIN
Select e.designation as Expertise, count(*) as NumberOfDoctors
from doctor d, expertise e
where d.idExpertise = e.idExpertise
group by (e.idExpertise) 
order by (count(*)) desc;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE p_totalFaturado ()
BEGIN
Select sum(a.price) as montante
from appointment a
where finished = 1;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE p_consultasPassadas ()
BEGIN
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 1;
END //
DELIMITER ;
