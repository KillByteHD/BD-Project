USE umclinic;

select f_profitBetweenDates("2017-03-27 22:15:39", "2019-03-27 22:15:39");
select f_moreAppointmentsExpertiseBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsClubBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsAthleteBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsDoctorBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsCategoryBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsModalityBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_profitFromDoctorBetweenDates(18586488, "1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_profitFromAthlete(10394391);
select f_daysTillAppointment("1800-03-26 22:15:39");

call p_scheduledAppointmentsBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
call p_completedAppointmentsFromDate("2019-03-27 22:15:39");
call p_doctorsNotAthleteCity("Lisboa");
call p_athletesOneExpertise();
call p_expertiseMoreAppointments();
call p_categoryMoreAppointments ();
call p_modalityMoreAppointments ();
call p_completedAppointments();
call p_totalProfit();
call p_AverageWeight();
call p_clubMoreAppointments();
call p_athleteMoreAppointments();
call p_moreAppointmentsDoctor();
call p_alterWeightAthlete(95.3, 12249709);
#Exemplo de querer alterar uma data terminada para o futuro
call p_alterDateAppointment('2021-12-04 10:00:00',"2018-06-21 15:00:00",18828978,12328604);
#Exemplo de querer alterar uma data por realizar para o passado
call p_alterDateAppointment('1800-12-04 10:00:00',"2021-12-14 10:00:00",18828978,10394391);
call p_alterStateAppointment("2021-12-04 10:00:00", 18586488, 10394391);
call p_scheduleAppointmentsAthlete(10394391);
call p_appointmentsCompletedAthlete(10394391);
call p_appointmentsCompletedDoctor(18586488);
call p_scheduleAppointmentsDoctor(18586488);
call p_scheduledAppointmentsAfterDate("2000-03-02");
call p_addObservations("2021-12-04 10:00:00", 18586488, 10394391,"Nada a declarar");
call p_alterZipcodeAthlete("1302-893",10394391); 
call p_alterZipcodeDoctor("1302-893",18586488);
call p_alterExpertiseDoctor(3,18586488);
call p_alterarCellphoneDoctor(911111111,18586488);
call p_appointmentsByDoctor();
call p_doctorsByExpertise();

select * from expertise;
select * from doctor where idDoctor=18586488;
select * from appointment where idDoctor= 18586488 and idAthlete = 10394391 and dateAppointment = "2021-12-04 10:00:00";
select * from appointment where idDoctor =18828978;
select * from athlete where idAthlete = 10394391;

#Exemplo de querer adicionar uma consulta quando um atleta já tem consulta a essa hora
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (18828978, 10394391, 'Nada a declarar.', 403.1, '2021-12-04 10:00:00', 0);

#Exemplo de querer adicionar uma consulta quando um medico já tem consulta a essa hora
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (18828978, 10394391, 'Nada a declarar.', 403.1, '2022-01-02 19:00:00', 0);

#Exemplo de querer adicionar uma consulta quando a hora é errada aos segundos
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (18828978, 10394391, 'Nada a declarar.', 403.1, '2022-01-02 19:00:20', 0);

#Exemplo de querer adicionar uma consulta quando a hora é errada aos minutos
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (18828978, 10394391, 'Nada a declarar.', 403.1, '2022-01-02 19:12:00', 0);

#Exemplo de querer adicionar uma consulta que ira acontecer no futuro já terminada
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (18828978, 10394391, 'Nada a declarar.', 403.1, '2030-01-02 19:00:00', 1);

#Exemplo de querer adicionar uma consulta que ira acontecer no passado sem estar terminada
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (18828978, 10394391, 'Nada a declarar.', 403.1, '1800-01-02 19:00:00', 0);

#ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';