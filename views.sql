select * from v_consultasAgendadas;
Create view v_consultasAgendadas as 
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0;

drop view v_consultasAgendadasDias;
select * from v_consultasAgendadasDias;
create view v_consultasAgendadasDias as
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0
and f_diasAteConsulta(a.dateAppointment)>=0
and f_diasAteConsulta(a.dateAppointment)<=7;