DELETE from appointment;
delete from doctor;
delete from athlete;
delete from category;
delete from expertise;
delete from club;
delete from modality;
delete from zipcode;

select * from v_especialidade;

select f_profitBetweenDates("2004-03-27 22:15:39", "2010-03-27 22:15:39");
select f_moreAppointmentsExpertiseBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsClubBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsAthleteBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsDoctorBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsCategoryBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_moreAppointmentsModalityBetweenDates("1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_profitFromDoctorBetweenDates(13712728, "1600-03-27 22:15:39", "2800-03-27 22:15:39");
select f_profitFromAthlete(10229165);
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
call p_alterDateAppointment('2021-12-04 10:00:00',"2021-12-04 10:30:00",18586488,10394391);
call p_alterStateAppointment("2021-12-04 10:30:00", 18586488, 10394391);
#^^não está a dar bem
call p_scheduleAppointmentsAthlete(10394391);
call p_appointmentsCompletedAthlete(10394391);
call p_appointmentsCompletedDoctor(18586488);
call p_scheduleAppointmentsDoctor(18586488);
call p_scheduledAppointmentsAfterDate("2000-03-02");
call p_addObservations("2021-12-04 10:30:00", 18586488, 10394391,"Nada a declarar");
#^^não está a dar bem
call p_alterZipcodeAthlete("1302-893",10394391); 
call p_alterZipcodeDoctor("1302-893",18586488);
call p_alterExpertiseDoctor(3,18586488);
call p_alterarCellphoneDoctor(911111111,18586488);
call p_appointmentsByDoctor();
call p_doctorsByExpertise();

select * from zipcode;
select * from athlete;
select * from doctor where idDoctor= 18586488; #and a.idDoctor = 13712728;

select * from athlete where idAthlete = 12249709;

#14585939
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (13712728, 14585939, 'Nada a declarar.', 403.1, '2001-05-10 16:00:00', 0);

delete from appointment where idDoctor = 13712728 and idAthlete=14585939 and dateAppointment= '2001-04-28 11:30:04';
#23738706
INSERT INTO appointment (idDoctor, idAthlete, observations, price, dateAppointment, finished)
VALUES (23738706, 12249709, 'Nada a declarar.', 403.1, '2001-05-10 16:00:00', 0);

#ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';