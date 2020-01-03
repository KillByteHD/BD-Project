select * from v_scheduledAppointments;

Create view v_scheduledAppointments as 
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment as date, f_daysTillAppointment(a.dateAppointment) as "days to appointment"
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0;

drop view v_scheduledAppointmentsWeek;

select * from v_scheduledAppointmentsWeek;

create view v_scheduledAppointmentsWeek as
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment as date, f_daysTillAppointment(a.dateAppointment) as "days to appointment"
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0
and f_daysTillAppointment(a.dateAppointment)>=0
and f_daysTillAppointment(a.dateAppointment)<=7;

