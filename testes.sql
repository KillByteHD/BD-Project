DELETE from appointment;
delete from doctor;
delete from athlete;
delete from category;
delete from expertise;
delete from club;
delete from modality;
delete from zipcode;

create view v_especialidade as
Select d.nameDoctor, e.designation
from doctor d, expertise e 
where d.idExpertise = e.idExpertise;

select * from v_especialidade;

select f_lucroEntreDatas("2004-03-27 22:15:39", "2004-03-27 22:15:39");
select f_especialidadeEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_clubeEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_atletaEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_doctorEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_categoryEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_modalityEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_lucroDoctorEntreDatas(1, "1600-03-27 22:15:39", "2800-03-27 22:15:39");

call p_listarConsultasEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
call p_listarRealizadasEntreDatas("2019-03-27 22:15:39");
call p_listarMarcadasEntreDatas("2020-03-27 22:15:39");

call p_adicionarConsulta(18, 347, 'Nada a declarar.', 104.91, '2019-11-08 14:17:19', 1);
Select * from appointment;

call p_eliminarConsulta(18, 347, '2019-11-08 14:17:19');
call p_alterarPesoAtleta(56, 1);
select * from athlete;
call p_alterarPesoAtleta(55.8, 1);

/*(13, 335, 'Nada a declarar.', 782.33, '2015-02-09 19:17:11', 0),*/
call p_alterarHorarioConsulta('2015-02-09 19:17:11','2019-02-09 19:17:11', 13, 335);

select price from appointment where idDoctor = 13 and idAthlete = 335 and dateAppointment = '2015-02-09 19:17:11';

select * from appointment a
where a.idAthlete = 335 and a.idDoctor = 13;

INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (11, 110, 'Nada a declarar.', 403.1, '1992-04-28 11:30:04', 0);

INSERT INTO umclinic.appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (13, 335, 'Nada a declarar.', 782.33, '2015-02-09 19:00:00', 0);

INSERT INTO umclinic.appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (1, 335, 'Nada a declarar.', 782.33, '2015-02-09 19:00:00', 0);
