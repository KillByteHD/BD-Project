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

//p_medicosNaoConsultaAtletasCidade
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idDoctor", 
                "from" : "doctor", 
                "foreignField" : "idDoctor", 
                "as" : "doctor"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$doctor", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "athlete.idZipcode", 
                "from" : "zipcode", 
                "foreignField" : "zipcode", 
                "as" : "zipcode"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$zipcode", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$match" : {
                "zipcode.city" : {
                    "$not" : {
                        "$in" : [
                            "Lisboa"
                        ]
                    }
                }
            }
        }, 
        { 
            "$project" : {
                "doctor.nameDoctor" : "$doctor.nameDoctor", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$group" : {
                "_id" : null, 
                "distinct" : {
                    "$addToSet" : "$$ROOT"
                }
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$distinct", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$replaceRoot" : {
                "newRoot" : "$distinct"
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//p_especialidadeComMaisConsultas
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idDoctor", 
                "from" : "doctor", 
                "foreignField" : "idDoctor", 
                "as" : "doctor"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$doctor", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "doctor.idExpertise", 
                "from" : "expertise", 
                "foreignField" : "idExpertise", 
                "as" : "expertise"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$expertise", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "expertise᎐designation" : "$expertise.designation"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "expertise.designation" : "$_id.expertise᎐designation", 
                "COUNT(*)" : "$COUNT(*)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(*)" : NumberInt(-1)
            }
        }, 
        { 
            "$limit" : NumberInt(5)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);


//p_categoriasComMaisConsultas
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "athlete.idCategory", 
                "from" : "category", 
                "foreignField" : "idCategory", 
                "as" : "category"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$category", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "category᎐nameCategory" : "$category.nameCategory"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "category.nameCategory" : "$_id.category᎐nameCategory", 
                "COUNT(*)" : "$COUNT(*)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(*)" : NumberInt(-1)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//p_modalidadesComMaisConsultas
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "athlete.idModality", 
                "from" : "modality", 
                "foreignField" : "idModality", 
                "as" : "modality"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$modality", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "modality᎐nameModality" : "$modality.nameModality"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "modality.nameModality" : "$_id.modality᎐nameModality", 
                "COUNT(*)" : "$COUNT(*)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(*)" : NumberInt(-1)
            }
        }, 
        { 
            "$limit" : NumberInt(5)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//p_clubesComMaisConsultas
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "athlete.idClub", 
                "from" : "club", 
                "foreignField" : "idClub", 
                "as" : "club"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$club", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "club᎐nameClub" : "$club.nameClub"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "club.nameClub" : "$_id.club᎐nameClub", 
                "COUNT(*)" : "$COUNT(*)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(*)" : NumberInt(-1)
            }
        }, 
        { 
            "$limit" : NumberInt(5)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//p_atletasComMaisConsultas
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "athlete᎐nameAthlete" : "$athlete.nameAthlete"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "athlete.nameAthlete" : "$_id.athlete᎐nameAthlete", 
                "COUNT(*)" : "$COUNT(*)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(*)" : NumberInt(-1)
            }
        }, 
        { 
            "$limit" : NumberInt(5)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//p_medicoComMaisConsultas
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idDoctor", 
                "from" : "doctor", 
                "foreignField" : "idDoctor", 
                "as" : "doctor"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$doctor", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "doctor᎐nameDoctor" : "$doctor.nameDoctor"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "doctor.nameDoctor" : "$_id.doctor᎐nameDoctor", 
                "COUNT(*)" : "$COUNT(*)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(*)" : NumberInt(-1)
            }
        }, 
        { 
            "$limit" : NumberInt(1)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//p_consultasPorMedico
db.appointment.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idDoctor", 
                "from" : "doctor", 
                "foreignField" : "idDoctor", 
                "as" : "doctor"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$doctor", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "doctor᎐nameDoctor" : "$doctor.nameDoctor"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "doctor.nameDoctor" : "$_id.doctor᎐nameDoctor", 
                "COUNT(*)" : "$COUNT(*)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(*)" : NumberInt(-1)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//f_especialidadeEntreDatas
db.expertise.aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "expertise" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "expertise.idExpertise", 
                "from" : "doctor", 
                "foreignField" : "idExpertise", 
                "as" : "doctor"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$doctor", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "doctor.idDoctor", 
                "from" : "appointment", 
                "foreignField" : "idDoctor", 
                "as" : "appointment"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$appointment", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$match" : {
                "$and" : [
                    {
                        "appointment.dateAppointment" : {
                            "$gte" : ISODate("1600-03-27T22:15:39.000Z")
                        }
                    }, 
                    {
                        "appointment.dateAppointment" : {
                            "$lte" : ISODate("2800-03-27T22:15:39.000Z")
                        }
                    }
                ]
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "expertise᎐designation" : "$expertise.designation"
                }, 
                "COUNT(expertise᎐nameExpertise)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "expertise.designation" : "$_id.expertise᎐designation", 
                "COUNT(expertise.nameExpertise)" : "$COUNT(expertise᎐nameExpertise)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(expertise.nameExpertise)" : NumberInt(-1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "expertise.designation" : "$expertise.designation"
            }
        }, 
        { 
            "$limit" : NumberInt(1)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//f_clubeEntreDatas
db.getCollection("appointment").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "athlete.idClub", 
                "from" : "club", 
                "foreignField" : "idClub", 
                "as" : "club"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$club", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$match" : {
                "$and" : [
                    {
                        "appointment.dateAppointment" : {
                            "$gte" : ISODate("1600-03-27T22:15:39.000Z")
                        }
                    }, 
                    {
                        "appointment.dateAppointment" : {
                            "$lte" : ISODate("2800-03-27T22:15:39.000Z")
                        }
                    }
                ]
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "club᎐nameClub" : "$club.nameClub"
                }, 
                "COUNT(club᎐nameClub)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "club.nameClub" : "$_id.club᎐nameClub", 
                "COUNT(club.nameClub)" : "$COUNT(club᎐nameClub)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(club.nameClub)" : NumberInt(-1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "club.nameClub" : "$club.nameClub"
            }
        }, 
        { 
            "$limit" : NumberInt(1)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//f_atletaEntreDatas
db.getCollection("appointment").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$match" : {
                "$and" : [
                    {
                        "appointment.dateAppointment" : {
                            "$gte" : ISODate("1600-03-27T22:15:39.000Z")
                        }
                    }, 
                    {
                        "appointment.dateAppointment" : {
                            "$lte" : ISODate("2800-03-27T22:15:39.000Z")
                        }
                    }
                ]
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "athlete᎐nameAthlete" : "$athlete.nameAthlete"
                }, 
                "COUNT(athlete᎐nameAthlete)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "athlete.nameAthlete" : "$_id.athlete᎐nameAthlete", 
                "COUNT(athlete.nameAthlete)" : "$COUNT(athlete᎐nameAthlete)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(athlete.nameAthlete)" : NumberInt(-1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "athlete.nameAthlete" : "$athlete.nameAthlete"
            }
        }, 
        { 
            "$limit" : NumberInt(1)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);


//f_doctorEntreDatas
db.getCollection("appointment").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idDoctor", 
                "from" : "doctor", 
                "foreignField" : "idDoctor", 
                "as" : "doctor"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$doctor", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$match" : {
                "$and" : [
                    {
                        "appointment.dateAppointment" : {
                            "$gte" : ISODate("1600-03-27T22:15:39.000Z")
                        }
                    }, 
                    {
                        "appointment.dateAppointment" : {
                            "$lte" : ISODate("2800-03-27T22:15:39.000Z")
                        }
                    }
                ]
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "doctor᎐nameDoctor" : "$doctor.nameDoctor"
                }, 
                "COUNT(doctor᎐nameDoctor)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "doctor.nameDoctor" : "$_id.doctor᎐nameDoctor", 
                "COUNT(doctor.nameDoctor)" : "$COUNT(doctor᎐nameDoctor)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(doctor.nameDoctor)" : NumberInt(-1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "doctor.nameDoctor" : "$doctor.nameDoctor"
            }
        }, 
        { 
            "$limit" : NumberInt(1)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//f_categoryEntreDatas
db.getCollection("appointment").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "athlete.idCategory", 
                "from" : "category", 
                "foreignField" : "idCategory", 
                "as" : "category"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$category", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$match" : {
                "$and" : [
                    {
                        "appointment.dateAppointment" : {
                            "$gte" : ISODate("1600-03-27T22:15:39.000Z")
                        }
                    }, 
                    {
                        "appointment.dateAppointment" : {
                            "$lte" : ISODate("2800-03-27T22:15:39.000Z")
                        }
                    }
                ]
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "category᎐nameCategory" : "$category.nameCategory"
                }, 
                "COUNT(category᎐nameCategory)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "category.nameCategory" : "$_id.category᎐nameCategory", 
                "COUNT(category.nameCategory)" : "$COUNT(category᎐nameCategory)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(category.nameCategory)" : NumberInt(-1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "category.nameCategory" : "$category.nameCategory"
            }
        }, 
        { 
            "$limit" : NumberInt(1)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//f_modalityEntreDatas
db.getCollection("appointment").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "appointment" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "appointment.idAthlete", 
                "from" : "athlete", 
                "foreignField" : "idAthlete", 
                "as" : "athlete"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$athlete", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "athlete.idModality", 
                "from" : "modality", 
                "foreignField" : "idModality", 
                "as" : "modality"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$modality", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$match" : {
                "$and" : [
                    {
                        "appointment.dateAppointment" : {
                            "$gte" : ISODate("1600-03-27T22:15:39.000Z")
                        }
                    }, 
                    {
                        "appointment.dateAppointment" : {
                            "$lte" : ISODate("2800-03-27T22:15:39.000Z")
                        }
                    }
                ]
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "modality᎐nameModality" : "$modality.nameModality"
                }, 
                "COUNT(modality᎐nameModality)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "modality.nameModality" : "$_id.modality᎐nameModality", 
                "COUNT(modality.nameModality)" : "$COUNT(modality᎐nameModality)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(modality.nameModality)" : NumberInt(-1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "modality.nameModality" : "$modality.nameModality"
            }
        }, 
        { 
            "$limit" : NumberInt(1)
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);
