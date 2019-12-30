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


#drop procedure p_alterarHorarioConsulta;
DELIMITER //
CREATE PROCEDURE p_alterarHorarioConsulta (IN dateAppointment Datetime, original Datetime, idD INT(11), idA INT(11))
BEGIN
DECLARE obs TEXT;
DECLARE p decimal(7,2);
DECLARE f TINYINT(4);
select observations INTO obs from appointment where idDoctor = idD and idAthlete = idA and dateAppointment = original;
select price INTO p from appointment where idDoctor = idD and idAthlete = idA and dateAppointment = original;
select finished INTO f from appointment where idDoctor = idD and idAthlete = idA and dateAppointment = original;
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (idDoctor, idAthlete, obs, p, dateAppointment, f);
call p_eliminarConsulta(idD, idA, original);
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