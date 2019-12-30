DROP TRIGGER IF EXISTS t_adicionarConsulta;
DELIMITER $$
    CREATE TRIGGER t_adicionarConsulta BEFORE INSERT ON appointment
    FOR EACH ROW BEGIN
	Declare min1 INT(15);
    Declare min2 INT(15);
    Select TIME_TO_SEC(timediff(NEW.date,date)) / 60 into min1;
     Select TIME_TO_SEC( timediff(date,NEW.date)) / 60 into min2;
      IF (
      (NEW.idAthlete = idAthlete and min1<=30 or min2<=30) 
      or (NEW.idDoctor = idDoctor and min1<=30 or min2<=30)
      )
      THEN SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = "Warning: birthdate can not be greater than current date!";
      END IF;
    END$$
DELIMITER ;

drop procedure p_adicionarConsulta;
DELIMITER //
CREATE PROCEDURE p_adicionarConsulta (IN idDoctor INT(11), idAthlete INT(11), obs TEXT, p DECIMAL(7,2), date Datetime, f TINYINT(4))
BEGIN
INSERT INTO appointment (idDoctor, idAthlete, observations, price, date, finished)
VALUES (idDoctor, idAthlete, obs, p, date, f);
END //
DELIMITER ;


drop procedure p_alterarHorarioConsulta;
DELIMITER //
CREATE PROCEDURE p_alterarHorarioConsulta (IN date Datetime, original Datetime, idD INT(11), idA INT(11))
BEGIN
DECLARE obs TEXT;
DECLARE p decimal(7,2);
DECLARE f TINYINT(4);
select observations INTO obs from appointment where idDoctor = idD and idAthlete = idA and date = original;
select price INTO p from appointment where idDoctor = idD and idAthlete = idA and date = original;
select finished INTO f from appointment where idDoctor = idD and idAthlete = idA and date = original;
INSERT INTO appointment (idDoctor, idAthlete, observations, price, date, finished)
VALUES (idDoctor, idAthlete, obs, p, date, f);
call p_eliminarConsulta(idD, idA, original);
END //
DELIMITER ;








drop procedure p_listarConsultasEntreDatas;
DELIMITER //
CREATE PROCEDURE p_listarConsultasEntreDatas (IN date1 Datetime, date2 Datetime)
BEGIN
Select atl.name as Athlete, d.name as Doctor, a.date, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.date>=date1
and a.date <= date2;
END //
DELIMITER ;

drop procedure p_listarRealizadasEntreDatas;
DELIMITER //
CREATE PROCEDURE p_listarRealizadasEntreDatas (IN date1 Datetime)
BEGIN
Select atl.name as Athlete, d.name as Doctor, a.date, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.date<=date1
and a.finished = 1;
END //
DELIMITER ;


drop procedure p_listarConsultasAtleta;
DELIMITER //
CREATE PROCEDURE p_listarConsultasAtleta (IN idA INT(11))
BEGIN
Select atl.name as Athlete, d.name as Doctor, a.date, a.observations, a.price, a.finished
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor;
END //
DELIMITER ;


drop procedure p_listarMarcadasEntreDatas;
DELIMITER //
CREATE PROCEDURE p_listarMarcadasEntreDatas (IN date1 Datetime)
BEGIN
Select atl.name as Athlete, d.name as Doctor, a.date, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where a.date>=date1
and a.finished = 0;
END //
DELIMITER ;

drop procedure p_eliminarConsulta;
DELIMITER //
CREATE PROCEDURE p_eliminarConsulta (IN idD INT(11), idA INT(11), d Datetime)
BEGIN
DELETE from appointment a 
where a.idDoctor=idD
and a.idAthlete=idA
and a.date = d;
END //
DELIMITER ;


drop procedure p_alterarPesoAtleta;
DELIMITER //
CREATE PROCEDURE p_alterarPesoAtleta (IN peso decimal(4,1), id INT(11))
BEGIN
UPDATE athlete 
SET weight = peso
where idAthlete = id;
END //
DELIMITER ;



drop procedure p_finalizarConsulta;
DELIMITER //
CREATE PROCEDURE p_finalizarConsulta (IN d Datetime, idD INT(11), idA INT(11))
BEGIN
UPDATE appointment
SET finished = 1
where idAthlete = idA
and idDoctor = idD
and date = d;
END //
DELIMITER ;

drop procedure p_addObservations;
DELIMITER //
CREATE PROCEDURE p_addObservations (IN d Datetime, idD INT(11), idA INT(11), obs TEXT)
BEGIN
UPDATE appointment
SET observations = obs
where idAthlete = idA
and idDoctor = idD
and date = d;
END //
DELIMITER ;