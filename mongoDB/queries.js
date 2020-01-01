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

//p_totalFaturado
db.appointment.aggregate([
    {
     $match: {
        finished: 1
     }
    }, {
        $group: {
            _id: null,
            total: {
                $sum: "$price"
            }
        }
    }
]);

//f_lucroEntreDatas
db.appointment.aggregate([
    {
     $match: {
        finished: 1,
        dateAppointment: {$gte: ISODate("2004-03-27T22:15:39.000Z"), $lte: ISODate("2010-03-27T22:15:39.000Z")}
     }
    }, {
        $group: {
            _id: null,
            total: {
                $sum: "$price"
            }
        }
    }
]);

//f_lucroDoctorEntreDatas
db.appointment.aggregate([
    {
     $match: {
        idDoctor: 1,
        finished: 1,
        dateAppointment: {$gte: ISODate("1600-03-27T22:15:39.000Z"), $lte: ISODate("2800-03-27T22:15:39.000Z")}
     }
    }, {
        $group: {
            _id: null,
            total: {
                $sum: "$price"
            }
        }
    }
]);

//f_lucroAtleta
db.appointment.aggregate([
    {
     $match: {
        idAthlete: 2,
        finished: 1,
     }
    }, {
        $group: {
            _id: null,
            total: {
                $sum: "$price"
            }
        }
    }
]);

//p_mediaPeso
db.athlete.aggregate([
    {
     $match: {
     }
    }, {
        $group: {
            _id: null,
            peso_medio: {
                $avg: "$weight"
            }
        }
    }
]);


db.appointment.aggregate([
    {
     $match: {
     }
    }, {
        $group: {
            _id: "null",
            consultas: {
                $count: "$idDoctor"
            }
        }
    }
]);

//p_alterarPesoAtleta
db.athlete.updateOne(
    {
        idAthlete:1,
    }, {
        $set:{weight:108.8}
    }
);

//p_addObservations
db.appointment.update(
    {
        idAthlete:1,
        idDoctor:1,
        dateAppointment: ISODate("2018-11-18T16:30:00.000Z")
    }, {
        $set:{observations: "Nada a declarar."}
    }
);

db.appointment.find({        dateAppointment: ISODate("2018-11-18T16:30:00.000Z")});

//p_adicionarConsulta
db.appointment.insert(
    {idDoctor:20, idAthlete:732,observations: "Nada", price: 0.0, dateAppointment:ISODate("2018-11-18T16:30:00.000Z"),finished:0}
);

//p_eliminarConsulta
db.appointment.findOneAndDelete(
    {idDoctor:20, idAthlete:732, dateAppointment:ISODate("2018-11-18T16:30:00.000Z")}
);

//p_finalizarConsulta
db.appointment.update(
    {
        idAthlete:1,
        idDoctor:1,
        dateAppointment: ISODate("2018-11-18T16:30:00.000Z")
    }, {
        $set:{finished: 1}
    }
);

db.appointment.find({        dateAppointment: ISODate("2018-11-18T16:30:00.000Z")});


//p_alterarHorarioConsulta
db.appointment.update(
    {
        idAthlete:1,
        idDoctor:1,
        dateAppointment: ISODate("2018-11-18T16:30:00.000Z")
    }, {
        $set:{dateAppointment: ISODate("2019-11-18T16:30:00.000Z")}
    }
);

db.appointment.find({        dateAppointment: ISODate("2018-11-18T16:30:00.000Z")});
