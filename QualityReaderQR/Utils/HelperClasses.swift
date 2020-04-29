//
//  HelperClasses.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/21/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import Foundation
import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    init(limit: Int) {
        characterLimit = limit
    }
    var characterLimit : Int
}


class Exporting {
    
    static private func getDocutmensDirectory() -> URL{
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print("All paths:\n \(path)")
        return path[0]
    }
    
    static func toCSV(clients: [Client], filename: String) -> URL{
        var csvText = "Nombre y Apellidos,CI,Veces Denegado\n"
        
        for c in clients{
            let newLine = "\(c.name),\(c.ci),\(c.denegateCount)\n"
            csvText.append(newLine)
        }
        
        let url = self.getDocutmensDirectory().appendingPathComponent("\(filename).csv")
        
        do{
            try csvText.write(to: url, atomically: true, encoding: .utf8)
//            let input = try String(contentsOf: url)
//            print("The document wirted:\n \(input)")
        }catch{
            print(error.localizedDescription)
        }
        
        return url
    }
}
