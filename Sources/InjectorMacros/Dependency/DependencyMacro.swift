//
//  File.swift
//  
//
//  Created by Sean Erickson on 9/25/24.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct DependencyMacro {}

extension DependencyMacro: ExtensionMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        let dependencyConformance = try ExtensionDeclSyntax("extension \(type.trimmed): Dependency {}")
        return [dependencyConformance]
    }
}

extension DependencyMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        if let nameDecl = declaration as? NamedDeclSyntax {
            let keyName = nameDecl.name.text + "Key"
            return ["""
            struct \(raw: keyName): EnvironmentKey, Resolvable {
                static let defaultValue = \(nameDecl.name.trimmed).defaultValue
                static var _resolve: (() -> any Dependency) = { fatalError() }
            }
        typealias Key = \(raw: keyName)
        """]
        } else {
            return []
        }
    }
}
