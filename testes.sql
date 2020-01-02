DELETE from appointment;
delete from doctor;
delete from athlete;
delete from category;
delete from expertise;
delete from club;
delete from modality;
delete from zipcode;

select * from appointment where idAthlete=12249709;
create view v_especialidade as
Select d.nameDoctor, e.designation
from doctor d, expertise e 
where d.idExpertise = e.idExpertise;

select * from v_especialidade;

select f_lucroEntreDatas("2004-03-27 22:15:39", "2010-03-27 22:15:39");
select f_especialidadeEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_clubeEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_atletaEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_doctorEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_categoryEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_modalityEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_lucroDoctorEntreDatas(13712728, "1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_lucroAtleta(10229165);
select f_diasAteConsulta("1800-03-26 22:15:39");

call p_listarConsultasEntreDatas("1600-03-27 22:15:39", "2800-03-27 22:15:39");
call p_listarRealizadasEntreDatas("2019-03-27 22:15:39");
call p_listarMarcadasEntreDatas("2000-01-01 12:00:00");
call p_medicosNaoConsultaAtletasCidade ("Lisboa");
call p_atletasSoConsultadosUmaEspecialidade();
call p_especialidadeComMaisConsultas();
call p_categoriasComMaisConsultas ();
call p_modalidadesComMaisConsultas ();
call p_consultasPassadas();
call p_totalFaturado ();
call p_mediaPeso();
call p_medicosNaoConsultaAtletasCidade ("Lisboa");
call p_especialidadeComMaisConsultas ();
call p_categoriasComMaisConsultas();
call p_modalidadesComMaisConsultas();
call p_clubesComMaisConsultas();
call p_atletasComMaisConsultas();
call p_medicoComMaisConsultas();
call p_consultasPorMedico();

call p_adicionarConsulta(13712728, 12249709, 'Nada a declarar.', 104.91, '2015-02-09 19:00:00', 1);
Select * from appointment;

call p_eliminarConsulta(13712728, 12249709, '2015-02-09 19:00:00');
select * from athlete where idAthlete =12249709;

call p_alterarPesoAtleta(95.3, 12249709);

call p_alterarHorarioConsulta('2019-02-09 19:00:00','2015-02-09 19:00:00',13712728,12249709);

select * from appointment a
where a.idAthlete = 12249709 and a.idDoctor = 13712728;

select * from athlete where idAthlete = 12249709;

#14585939
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (13712728, 14585939, 'Nada a declarar.', 403.1, '2001-05-10 16:00:00', 0);

delete from appointment where idDoctor = 13712728 and idAthlete=14585939 and dateAppointment= '2001-04-28 11:30:04';
#23738706
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (23738706, 12249709, 'Nada a declarar.', 403.1, '2001-05-10 16:00:00', 0);

#ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';