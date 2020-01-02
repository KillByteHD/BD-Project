/*p_especialidadeComMaisConsultas*/
Select expertise.idExpertise, count(*)
	from appointment
		INNER JOIN doctor 
			 on  doctor.idDoctor = appointment.idDoctor
		INNER JOIN expertise
			 on doctor.idExpertise = expertise.idExpertise
	group by (expertise.idExpertise) 
	order by (count(*)) desc limit 5;

/*p_categoriasComMaisConsultas*/
select category.idCategory, count(*)
	from appointment
		INNER JOIN athlete 
			ON appointment.idAthlete = athlete.idAthlete
		INNER JOIN category 
			ON category.idCategory = athlete.idCategory
	group by (category.idCategory) 
	order by (count(*)) desc;
	
/*p_modalidadesComMaisConsultas*/
Select modality.idModality, count(*)
	from appointment 
		INNER JOIN athlete
			ON appointment.idAthlete = athlete.idAthlete
		INNER JOIN modality 
			ON modality.idModality = athlete.idModality
	group by (modality.idModality) 
	order by (count(*)) desc limit 5;

/*p_clubesComMaisConsultas*/
Select club.idClub, count(*)
	from appointment 
	INNER JOIN athlete
		ON appointment.idAthlete = athlete.idAthlete
	INNER JOIN club
		ON club.idClub = athlete.idClub
group by (club.idClub) 
order by (count(*)) desc limit 5;

/*p_atletasComMaisConsultas*/
Select athlete.idAthlete, count(*)
from appointment 
inner join athlete
on athlete.idAthlete= appointment.idAthlete
group by (athlete.idAthlete) 
order by (count(*)) desc limit 5;

/*p_medicoComMaisConsultas*/
Select doctor.idDoctor, count(*)
from appointment
inner join doctor 
on doctor.idDoctor = appointment.idDoctor
group by (doctor.idDoctor) 
order by (count(*)) desc limit 1;

/*p_consultasPorMedico*/
select doctor.idDoctor, count(*)
from appointment 
inner join doctor 
on doctor.idDoctor = appointment.idDoctor
group by (doctor.idDoctor) 
order by (count(*)) desc;

/*f_especialidadeEntreDatas*/
select expertise.idExpertise
from expertise
inner join doctor 
on expertise.idExpertise = doctor.idExpertise
inner join appointment
on appointment.idDoctor = doctor.idDoctor
where appointment.dateAppointment>= ""
and appointment.dateAppointment <= ""
group by expertise.idExpertise
order by count(expertise.idExpertise) DESC limit 1;

/*f_clubeEntreDatas*/
select club.idClub
from appointment 
inner join athlete 
on appointment.idAthlete = athlete.idAthlete
inner join club
on club.idClub = athlete.idClub
where appointment.dateAppointment>=""
and appointment.dateAppointment <= ""
group by club.idClub
order by count(club.nameClub) DESC limit 1;

/*f_atletaEntreDatas*/
select athlete.idAthlete
from appointment
inner join athlete
on appointment.idAthlete = athlete.idAthlete
where appointment.dateAppointment>= ""
and appointment.dateAppointment <= ""
group by athlete.idAthlete
order by count(athlete.nameAthlete) DESC limit 1;

/*f_doctorEntreDatas*/
select doctor.idDoctor
from appointment
inner join doctor 
on appointment.idDoctor = doctor.idDoctor
where appointment.dateAppointment>=""
and appointment.dateAppointment <= ""
group by doctor.idDoctor
order by count(doctor.nameDoctor) DESC limit 1;

/*f_categoryEntreDatas*/
select category.idCategory
from appointment
inner join athlete
on appointment.idAthlete = athlete.idAthlete
inner join category
on category.idCategory = athlete.idCategory
where appointment.dateAppointment>= ""
and appointment.dateAppointment <= ""
group by category.idCategory
order by count(category.nameCategory) DESC limit 1;

/*f_modalityEntreDatas*/
select modality.idModality
from appointment
inner join athlete 
on appointment.idAthlete = athlete.idAthlete
inner join modality
on modality.idModality = athlete.idModality
where appointment.dateAppointment>=""
and appointment.dateAppointment <= ""
group by modality.idModality
order by count(modality.nameModality) DESC limit 1;

