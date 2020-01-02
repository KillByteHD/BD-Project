-- Athlete Privileges
CREATE USER Athlete identified by '?';
GRANT SELECT ON umclinic.appointment TO Athlete;

-- Receptionist Privileges
CREATE USER Receptionist identified by '?';
GRANT SELECT,INSERT,UPDATE,DELETE ON umclinic.appointment TO Receptionist;
  
-- Doctor Privileges  
CREATE USER Doctor identified by '?';
GRANT SELECT ON umclinic.appointment TO Doctor;
  
  
flush privileges;  
  
  