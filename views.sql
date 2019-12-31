Create view v_consultasAgendadas as 
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0;

Create view v_consultasPassadas as 
Select atl.nameAthlete as Athlete, d.nameDoctor as Doctor, a.dateAppointment, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 1;

select * from totalFaturado;
Create view totalFaturado as 
Select sum(a.price) as montante
from appointment a
where finished = 1;

select * from v_medicosPorEspecialidade;
Create view v_medicosPorEspecialidade as 
Select e.designation as Expertise, count(*) as NumberOfDoctors
from doctor d, expertise e
where d.idExpertise = e.idExpertise
group by (e.idExpertise) 
order by (count(*)) desc;

Create view v_mediaPeso as 
Select avg(a.weight) as "Peso médio" 
from athlete a;

select * from v_ConsultasPorMedico;
Create view v_consultasPorMedico as 
Select d.nameDoctor as Name, count(*) as NumberOfAppointments
from appointment a, doctor d
where d.idDoctor = a.idDoctor
group by (a.idDoctor) 
order by (count(*)) desc;

Create view v_medicoComMaisConsultas as 
Select d.nameDoctor as Name, count(*) as NumberOfAppointments
from appointment a, doctor d
where d.idDoctor = a.idDoctor
group by (a.idDoctor) 
order by (count(*)) desc limit 1;

Create view v_atletasComMaisConsultas as 
Select atl.nameAthlete as Name, count(*) as NumberOfAppointments
from appointment a, athlete atl
where atl.idAthlete= a.idAthlete
group by (a.idAthlete) 
order by (count(*)) desc limit 5;

Create view v_clubesComMaisConsultas as 
Select c.nameClub as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN club c ON c.idClub = atl.idClub
group by (c.idClub) 
order by (count(*)) desc limit 5;

select * from v_modalidadesComMaisConsultas;

Create view v_modalidadesComMaisConsultas as 
Select m.nameModality as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN modality m ON m.idModality = atl.idModality
group by (m.idModality) 
order by (count(*)) desc limit 5;

select * from v_categoriasComMaisConsultas;
Create view v_categoriasComMaisConsultas as 
Select c.nameCategory as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN category c ON c.idCategory = atl.idCategory
group by (c.idCategory) 
order by (count(*)) desc;

select * from v_especialidadeComMaisConsultas;
Create view v_especialidadeComMaisConsultas as 
Select e.designation as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN doctor d on  d.idDoctor = a.idDoctor
INNER JOIN expertise e on d.idExpertise = e.idExpertise
group by (e.idExpertise) 
order by (count(*)) desc limit 5;

select * from v_atletasSoConsultadosUmaEspecialidade;
Create view v_atletasSoConsultadosUmaEspecialidade as 
Select atl.nameAthlete as Name, e.designation as Expertise
from appointment a 
INNER JOIN athlete atl on atl.idAthlete= a.idAthlete
INNER JOIN doctor d on  d.idDoctor = a.idDoctor
INNER JOIN expertise e on d.idExpertise = e.idExpertise
group by a.idAthlete
having count(*) = 1;

select * from v_medicosNaoConsultaAtletasLisboa;
Create view v_medicosNaoConsultaAtletasLisboa as 
Select distinct d.nameDoctor as Name
from appointment a 	
inner JOIN doctor d on d.idDoctor = a.idDoctor
inner join athlete atl on atl.idAthlete = a.idAthlete
inner join zipcode z on z.zipcode = atl.idZipcode
where z.city not in ("Lisboa");