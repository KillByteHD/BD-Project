drop trigger confirmationAppointment;
DELIMITER //
CREATE TRIGGER confirmationAppointment
BEFORE INSERT ON appointment
FOR EACH ROW
BEGIN
        IF ((NEW.idDoctor, NEW.dateAppointment) IN (SELECT a.idDoctor,a.DateAppointment FROM appointment a WHERE idDoctor = NEW.idDoctor AND dateAppointment = NEW.dateAppointment)	
			OR (NEW.idAthlete, NEW.dateAppointment) IN (SELECT a.idAthlete,a.DateAppointment FROM appointment a WHERE idAthlete = NEW.idAthlete AND dateAppointment = NEW.dateAppointment)
            OR (NOT(MINUTE(NEW.dateAppointment)=30 or MINUTE(NEW.dateAppointment)=0)) ) THEN 
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You can not insert an appointment in that date!';
        END IF;
END //