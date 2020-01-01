Select expertise.designation, count(*)
	from appointment
		INNER JOIN doctor 
			 on  doctor.idDoctor = appointment.idDoctor
		INNER JOIN expertise
			 on doctor.idExpertise = expertise.idExpertise
	group by (expertise.designation) 
	order by (count(*)) desc limit 5;

select category.nameCategory, count(*)
	from appointment
		INNER JOIN athlete 
			ON appointment.idAthlete = athlete.idAthlete
		INNER JOIN category 
			ON category.idCategory = athlete.idCategory
	group by (category.nameCategory) 
	order by (count(*)) desc;
	
Select modality.nameModality, count(*)
	from appointment 
		INNER JOIN athlete
			ON appointment.idAthlete = athlete.idAthlete
		INNER JOIN modality 
			ON modality.idModality = athlete.idModality
	group by (modality.nameModality) 
	order by (count(*)) desc limit 5;

Select club.nameClub, count(*)
	from appointment 
	INNER JOIN athlete
		ON appointment.idAthlete = athlete.idAthlete
	INNER JOIN club
		ON club.idClub = athlete.idClub
group by (club.nameClub) 
order by (count(*)) desc limit 5;

Select athlete.nameAthlete, count(*)
from appointment 
inner join athlete
on athlete.idAthlete= appointment.idAthlete
group by (athlete.nameAthlete) 
order by (count(*)) desc limit 5;

Select doctor.nameDoctor, count(*)
from appointment
inner join doctor 
on doctor.idDoctor = appointment.idDoctor
group by (doctor.nameDoctor) 
order by (count(*)) desc limit 1;

select doctor.nameDoctor, count(*)
from appointment 
inner join doctor 
on doctor.idDoctor = appointment.idDoctor
group by (doctor.nameDoctor) 
order by (count(*)) desc;

select expertise.designation
from expertise
inner join doctor 
on expertise.idExpertise = doctor.idExpertise
inner join appointment
on appointment.idDoctor = doctor.idDoctor
where appointment.dateAppointment>= "1600-03-27 22:15:39"
and appointment.dateAppointment <= "2800-03-27 22:15:39"
group by expertise.designation
order by count(expertise.idExpertise) DESC limit 1;

select club.nameClub
from appointment 
inner join athlete 
on appointment.idAthlete = athlete.idAthlete
inner join club
on club.idClub = athlete.idClub
where appointment.dateAppointment>=""
and appointment.dateAppointment <= ""
group by club.nameClub
order by count(club.nameClub) DESC limit 1;

select athlete.nameAthlete
from appointment
inner join athlete
on appointment.idAthlete = athlete.idAthlete
where appointment.dateAppointment>= ""
and appointment.dateAppointment <= ""
group by athlete.nameAthlete
order by count(athlete.nameAthlete) DESC limit 1;


select doctor.nameDoctor
from appointment
inner join doctor 
on appointment.idDoctor = doctor.idDoctor
where appointment.dateAppointment>=""
and appointment.dateAppointment <= ""
group by doctor.nameDoctor
order by count(doctor.nameDoctor) DESC limit 1;


select category.nameCategory
from appointment
inner join athlete
on appointment.idAthlete = athlete.idAthlete
inner join category
on category.idCategory = athlete.idCategory
where appointment.dateAppointment>= ""
and appointment.dateAppointment <= ""
group by category.nameCategory
order by count(category.nameCategory) DESC limit 1;


select modality.nameModality
from appointment
inner join athlete 
on appointment.idAthlete = athlete.idAthlete
inner join modality
on modality.idModality = athlete.idModality
where appointment.dateAppointment>=""
and appointment.dateAppointment <= ""
group by modality.nameModality
order by count(modality.nameModality) DESC limit 1;
