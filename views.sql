select * from v_consultasAgendadas;

Create view v_consultasAgendadas as 
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment as date, f_diasAteConsulta(a.dateAppointment) as "days to appointment"
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0;

drop view v_consultasAgendadasSemana;

select * from v_consultasAgendadasSemana;

create view v_consultasAgendadasSemana as
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment as date, f_diasAteConsulta(a.dateAppointment) as "days to appointment"
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0
and f_diasAteConsulta(a.dateAppointment)>=0
and f_diasAteConsulta(a.dateAppointment)<=7;