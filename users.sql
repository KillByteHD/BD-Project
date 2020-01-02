-- Athlete Privileges
CREATE USER Athlete WITH PASSWORD = '?';
GRANT SELECT ON umclinic.appointment TO Athlete;

-- Receptionist Privileges
CREATE USER Receptionist WITH PASSWORD = '?';
GRANT SELECT,INSERT,UPDATE,DELETE ON umclinic.appointment TO Receptionist;
  
-- Doctor Privileges  
CREATE USER Doctor  WITH PASSWORD = '?';
GRANT SELECT ON umclinic.appointment TO Doctor;
  
  
  
  
  