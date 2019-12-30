Create view v_consultasAgendadas as 
Select atl.name as Athlete, d.name as Doctor, a.date, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 0;

Create view v_consultasPassadas as 
Select atl.name as Athlete, d.name as Doctor, a.date, a.observations, a.price
from Appointment a inner join athlete atl on a.idAthlete = atl.idAthlete
inner join doctor d on d.idDoctor = a.idDoctor
where finished = 1;

Create view v_lucroTotal as 
Select sum(a.price)
from appointment a;

Create view v_medicosPorEspecialidade as 
Select e.designation as Expertise, count(*) as NumberOfDoctors
from doctor d, expertise e
where d.idExpertise = e.idExpertise
group by (e.idExpertise) 
order by (count(*)) desc;

Create view v_mediaPeso as 
Select avg(a.weight) 
from athlete a;

Create view v_consultasPorMedico as 
Select d.name as Name, count(*) as NumberOfAppointments
from appointment a, doctor d
where d.idDoctor = a.idDoctor
group by (a.idDoctor) 
order by (count(*)) desc;

Create view v_medicoComMaisConsultas as 
Select d.name as Name, count(*) as NumberOfAppointments
from appointment a, doctor d
where d.idDoctor = a.idDoctor
group by (a.idDoctor) 
order by (count(*)) desc limit 1;

Create view v_atletasComMaisConsultas as 
Select atl.name as Name, count(*) as NumberOfAppointments
from appointment a, athlete atl
where atl.idAthlete= a.idAthlete
group by (a.idAthlete) 
order by (count(*)) desc limit 5;

Create view v_clubesComMaisConsultas as 
Select c.name as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN club c ON c.idClub = atl.idClub
group by (c.idClub) 
order by (count(*)) desc limit 5;

Create view v_modalidadesComMaisConsultas as 
Select m.name as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN modality m ON m.idModality = atl.idModality
group by (m.idModality) 
order by (count(*)) desc limit 5;

Create view v_categoriasComMaisConsultas as 
Select c.name as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN athlete atl ON a.idAthlete = atl.idAthlete
INNER JOIN category c ON c.idCategory = atl.idCategory
group by (c.idCategory) 
order by (count(*)) desc;

Create view v_especialidadeComMaisConsultas as 
Select e.designation as Name, count(*) as NumberOfAppointments
from appointment a 
INNER JOIN doctor d on  d.idDoctor = a.idDoctor
INNER JOIN expertise e on d.idExpertise = e.idExpertise
group by (e.idExpertise) 
order by (count(*)) desc limit 5;

Create view v_atletasSoConsultadosUmaEspecialidade as 
Select atl.name as Name, e.designation as Expertise
from appointment a 
INNER JOIN athlete atl on atl.idAthlete= a.idAthlete
INNER JOIN doctor d on  d.idDoctor = a.idDoctor
INNER JOIN expertise e on d.idExpertise = e.idExpertise
group by a.idAthlete
having count(*) = 1;

Create view v_medicosNaoConsultaAtletasLisboa as 
Select distinct d.name as Name
from appointment a 
inner JOIN doctor d on d.idDoctor = a.idDoctor
inner join athlete atl on atl.idAthlete = a.idAthlete
inner join zipcode z on z.zipcode = atl.idZipcode
where z.city not in ("Lisboa");