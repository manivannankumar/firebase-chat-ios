//
//  module_details_Peoplz.swift
//  Peoplz
//
//  Created by Netaxis on 27/12/22.
//

import Foundation

struct Peoplz_Details {
    
    var pep_id : String
    var name : String
    var company : String
    var desigination : String
    var dateofbirth :  String
    var mobilenumber : String
    var livedin : String
    var Proileimage : String
    var status : String
 
    init(pep_id: String, name: String, company: String, desigination: String, dateofbirth: String, mobilenumber: String, livedin: String, Proileimage : String, status : String) {
        self.pep_id = pep_id
        self.name = name
        self.company = company
        self.desigination = desigination    
        self.dateofbirth = dateofbirth
        self.mobilenumber = mobilenumber
        self.livedin = livedin
        self.Proileimage = Proileimage
        self.status = status
    }
}

struct All_message {
    
    var from : String
    var to : String
    var message_id : String
    var message : String
    
    init(from: String, to: String, message_id: String, message: String) {
        self.from = from
        self.to = to
        self.message_id = message_id
        self.message = message
    }
    
    
}




