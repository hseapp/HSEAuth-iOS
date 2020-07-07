//
//  File.swift
//  
//
//  Created by Alexander Tooszovski on 07.07.2020.
//

import Foundation

public enum HSEResult<Object> {
    case success(Object)
    case failure(Error)
}
