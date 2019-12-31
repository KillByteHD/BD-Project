#DA Privileges
CREATE USER 'DA' IDENTIFIED BY 'password';
GRANT ALL ON umclinic TO 'custom'@'localhost';

#Athlete Privileges
CREATE USER 'Athlete' IDENTIFIED BY 'password';
GRANT UPDATE ON umclinic.athlete TO 'custom'@'host47.example.com';

#Receptionist Privileges
CREATE USER 'Receptionist' IDENTIFIED BY 'password';
GRANT SELECT,INSERT,UPDATE,DELETE ON umclinic.appointment TO 'custom'@'%.example.com';
  
#Doctor Privileges  
CREATE USER 'Doctor'  IDENTIFIED BY 'password';
GRANT UPDATE ON umclinic.doctor TO 'custom'@'%.example.com';
  
  
  
  
  