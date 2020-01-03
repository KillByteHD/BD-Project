//p_completedAppointments
db.appointment.find({finished: 1},{"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1});

//p_scheduledAppointmentsBetweenDates
db.appointment.find({
     finished: 0,
     dateAppointment: {$gte: "1600-03-27 22:15:39", $lte: "2800-03-27 22:15:39" }
     }, {"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1});

//p_alterDateAppointment
db.appointment.update(
    {
        "athlete.idAthlete":12328604,
        "doctor.idDoctor":18828978,
        dateAppointment: "2018-06-21 15:00:00"
    }, {
        $set:{dateAppointment: "2029-12-04 10:00:00"}
    }
);

//p_alterStateAppointment
db.appointment.update(
    {
        "athlete.idAthlete":10394391,
        "doctor.idDoctor":18586488,
        dateAppointment: "2015-02-09 19:00:00"
    }, {
        $set:{finished: 1}
    }
);

//p_completedAppointmentsFromDate
db.appointment.find({ 
     finished: 1,
     dateAppointment: {$lte: "2019-03-27 22:15:39"}
},{"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1});

//p_scheduleAppointmentsAthlete
db.appointment.find({
     finished: 0,
     "athlete.idAthlete": 10394391
},{"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1,finished:1});

//p_appointmentsCompletedAthlete
db.appointment.find({ 
     finished: 1,
     "athlete.idAthlete": 10394391
},{"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1,finished:1});

//p_appointmentsCompletedDoctor
db.appointment.find({ 
     finished: 1,
     "doctor.idDoctor": 18586488
},{"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1,finished:1});

//p_scheduleAppointmentsDoctor
db.appointment.find({ 
     finished: 0,
     "doctor.idDoctor":18586488
},{"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1,finished:1});

//p_scheduledAppointmentsAfterDate
db.appointment.find({ 
     finished: 0,
     dateAppointment: {$gte: "2000-03-02"}
},{"athlete.nameAthlete": 1, "doctor.nameDoctor" : 1,dateAppointment:1,observations:1,price:1});


//p_alterWeightAthlete
db.athlete.updateOne(
    {
        idAthlete:10394391
    }, {
        $set:{weight:119.9}
    }
);

//p_addObservations
db.appointment.update(
    {
        "athlete.idAthlete":10394391,
        "doctor.idDoctor":18586488,
        dateAppointment: "2021-12-04 10:30:00"
    }, {
        $set:{observations: "Nada a declarar."}
    }
);

//p_doctorsNotAthleteCity NAO DA
db.appointment.find({ 
     athlete: {zipcode: {city: "Lisboa"}}
},{"doctor.nameDoctor" : 1});

//p_alterZipcodeAthlete
db.athlete.updateOne(
    {
        idAthlete:10394391,
    }, {
        $set:{"zipcode.zipcode":"1302-893",
              "zipcode.city":"Coimbra"}
    }
);

//p_athletesOneExpertise
//p_expertiseMoreAppointments
//p_categoryMoreAppointments
//p_modalityMoreAppointments
//p_clubMoreAppointments
//p_athleteMoreAppointments
//p_moreAppointmentsDoctor
//p_appointmentsByDoctor

//p_AverageWeight
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
//p_doctorsByExpertise MAO DA
db.doctor.aggregate([
    {
     $match: { 
        
     }
    }, {
        $group: {
            _id: null,
            total: {
                $count: 
            }
        }
    }
]);

//p_totalProfit
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
//p_alterZipcodeDoctor
db.doctor.updateOne(
    {
        idDoctor:18586488,
    }, {
        $set:{"zipcode.zipcode":"1302-893",
              "zipcode.city":"Coimbra" }
    }
);

//p_alterExpertiseDoctor
db.doctor.updateOne(
    {
        idDoctor:18586488,
    }, {
        $set:{"expertise.idExpertise":3,
              "expertise.designation":"Cardiologia" }
    }
);
db.doctor.find({idDoctor:18586488});
//p_alterarCellphoneDoctor 
db.doctor.updateOne(
    {
        idDoctor:18586488,
    }, {
        $set:{cellphone:912571644}
    }
);

//f_profitBetweenDates
db.appointment.aggregate([
    {
     $match: {
        finished: 1,
        dateAppointment: {
            $gte: "2017-03-27 22:15:39", 
            $lte: "2019-03-27 22:15:39"
        }
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

//f_moreAppointmentsExpertiseBetweenDates
//f_moreAppointmentsClubBetweenDates
//f_moreAppointmentsAthleteBetweenDates
//f_moreAppointmentsDoctorBetweenDates
//f_moreAppointmentsCategoryBetweenDates
//f_moreAppointmentsModalityBetweenDates
//f_profitFromDoctorBetweenDates
db.appointment.aggregate([
    {
     $match: {
        finished: 1,
        "doctor.idDoctor": 18586488,
        dateAppointment: {
            $gte: "1600-03-27 22:15:39", 
            $lte: "2800-03-27 22:15:39"
        }
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

//f_profitFromAthlete
db.appointment.aggregate([
    {
     $match: {
        finished: 1,
        "athlete.idAthlete":10394391
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

