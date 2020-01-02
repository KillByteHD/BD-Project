db.appointment.find({}).sort({idAthlete : 1});

//p_consultasPassadas
db.appointment.find({finished: 1});
db.appointment.find({idAthlete : 12249709});
db.athlete.find({idAthlete : 12249709});

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
        idDoctor: 13712728,
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
        idAthlete: 10229165,
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


//p_alterarPesoAtleta
db.athlete.updateOne(
    {
        idAthlete:12249709,
    }, {
        $set:{weight:95.3}
    }
);

//p_addObservations
db.appointment.update(
    {
        idAthlete:12249709,
        idDoctor:13712728,
        dateAppointment: ISODate("2015-02-09T19:00:00.000Z")
    }, {
        $set:{observations: "Nada a declarar."}
    }
);

db.appointment.find({dateAppointment: ISODate("2019-11-18T16:30:00.000Z")});

//p_adicionarConsulta
db.appointment.insert(
    {idDoctor:13712728, idAthlete:12249709,observations: "Nada", price: 0.0, dateAppointment:ISODate("2019-11-18T16:30:00.000Z"),finished:0}
);

//p_eliminarConsulta
db.appointment.findOneAndDelete(
    {idDoctor:13712728, idAthlete:12249709, dateAppointment:ISODate("2019-11-18T16:30:00.000Z")}
);

//p_finalizarConsulta
db.appointment.update(
    {
        idAthlete:12249709,
        idDoctor:13712728,
        dateAppointment: ISODate("2015-02-09T19:00:00.000Z")
    }, {
        $set:{finished: 1}
    }
);

db.appointment.find({dateAppointment: ISODate("2015-02-09T19:00:00.000Z")});

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
                    "expertise᎐idExpertise" : "$expertise.idExpertise"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "expertise.idExpertise" : "$_id.expertise᎐idExpertise", 
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
            "$group" : {
                "_id" : {
                    "category᎐idCategory" : "$category.idCategory"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "category.idCategory" : "$_id.category᎐idCategory", 
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
            "$group" : {
                "_id" : {
                    "modality᎐idModality" : "$modality.idModality"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "modality.idModality" : "$_id.modality᎐idModality", 
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
            "$group" : {
                "_id" : {
                    "club᎐idClub" : "$club.idClub"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "club.idClub" : "$_id.club᎐idClub", 
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
            "$group" : {
                "_id" : {
                    "athlete᎐idAthlete" : "$athlete.idAthlete"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "athlete.idAthlete" : "$_id.athlete᎐idAthlete", 
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
            "$group" : {
                "_id" : {
                    "doctor᎐idDoctor" : "$doctor.idDoctor"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "doctor.idDoctor" : "$_id.doctor᎐idDoctor", 
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
            "$group" : {
                "_id" : {
                    "doctor᎐idDoctor" : "$doctor.idDoctor"
                }, 
                "COUNT(*)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "doctor.idDoctor" : "$_id.doctor᎐idDoctor", 
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
db.getCollection("expertise").aggregate(
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
                    "expertise᎐idExpertise" : "$expertise.idExpertise"
                }, 
                "COUNT(expertise᎐idExpertise)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "expertise.idExpertise" : "$_id.expertise᎐idExpertise", 
                "COUNT(expertise.idExpertise)" : "$COUNT(expertise᎐idExpertise)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(expertise.idExpertise)" : NumberInt(-1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "expertise.idExpertise" : "$expertise.idExpertise"
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
                    "club᎐idClub" : "$club.idClub"
                }, 
                "COUNT(club᎐nameClub)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "club.idClub" : "$_id.club᎐idClub", 
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
                "club.idClub" : "$club.idClub"
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
                    "athlete᎐idAthlete" : "$athlete.idAthlete"
                }, 
                "COUNT(athlete᎐nameAthlete)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "athlete.idAthlete" : "$_id.athlete᎐idAthlete", 
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
                "athlete.idAthlete" : "$athlete.idAthlete"
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
                    "doctor᎐idDoctor" : "$doctor.idDoctor"
                }, 
                "COUNT(doctor᎐nameDoctor)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "doctor.idDoctor" : "$_id.doctor᎐idDoctor", 
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
                "doctor.idDoctor" : "$doctor.idDoctor"
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
                    "category᎐idCategory" : "$category.idCategory"
                }, 
                "COUNT(category᎐nameCategory)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "category.idCategory" : "$_id.category᎐idCategory", 
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
                "category.idCategory" : "$category.idCategory"
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
                    "modality᎐idModality" : "$modality.idModality"
                }, 
                "COUNT(modality᎐nameModality)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "modality.idModality" : "$_id.modality᎐idModality", 
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
                "modality.idModality" : "$modality.idModality"
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
