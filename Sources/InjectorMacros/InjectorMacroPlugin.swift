//
//  File.swift
//  
//
//  Created by Sean Erickson on 9/25/24.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct InjectorMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DependencyMacro.self
    ]
}
