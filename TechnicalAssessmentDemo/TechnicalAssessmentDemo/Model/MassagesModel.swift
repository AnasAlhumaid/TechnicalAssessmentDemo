//
//  MassageModel.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import Foundation
struct MassagesModel: Identifiable {
    var id = UUID()
    var messageContent : String
    var sendBy: String
    var sendTo : String
}
