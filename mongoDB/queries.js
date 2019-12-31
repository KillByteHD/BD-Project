db.appointment.find({}).sort({idAthlete : 1});

//p_consultasPassadas
db.appointment.find({finished: 1});

db.appointment.find({idAthlete : 8});

db.appointment.find({idAthlete : 8, });

//p_listarMarcadasEntreDatas
db.appointment.find({ 
     finished: 0,
     dateAppointment: {$gte: ISODate("1994-10-10T21:30:00.000Z")}
});

//p_listarMarcadasEntreDatas
db.appointment.find({ 
     finished: 1,
     dateAppointment: {$lte: ISODate("1994-10-10T21:30:00.000Z")}
});

//p_listarConsultasEntreDatas
db.appointment.find({
    dateAppointment: {$gte: ISODate("1994-10-10T21:30:00.000Z"), $lte: ISODate("2000-10-10T21:30:00.000Z") }});

db.doctor.find();

