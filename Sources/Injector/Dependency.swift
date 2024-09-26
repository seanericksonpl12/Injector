//
//  Dependency.swift
//
//
//  Created by Sean Erickson on 9/25/24.
//

public protocol Dependency {
    associatedtype Key: EnvironmentKey
    static var defaultValue: Self { get }
}

public extension Dependency {
    static var defaultValue: Self {
        fatalError("Dependecy \"\(self)\" not resolved!\n\nTo fix this, either:\n     1.) Implement a default value in your \(self) class via `static let defaultValue = \(self)(...)`\n     2.) Use `resolve(withDependency: \(self)(...))` in your EnvironmentValues extension")
    }
}

