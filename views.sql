select * from v_scheduledAppointments;

Create view v_scheduledAppointments as 
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment as date, f_diasAteConsulta(a.dateAppointment) as "days to appointment"
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0;

drop view v_scheduledAppointmentsWeek;

select * from v_scheduledAppointmentsWeek;

create view v_scheduledAppointmentsWeek as
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment as date, f_diasAteConsulta(a.dateAppointment) as "days to appointment"
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0
and f_diasAteConsulta(a.dateAppointment)>=0
and f_diasAteConsulta(a.dateAppointment)<=7;

select * from v_completedAppointments;
Create view v_completedAppointments as 
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 1;
