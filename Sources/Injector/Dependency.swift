//
//  Dependency.swift
//
//
//  Created by Sean Erickson on 9/25/24.
//

public protocol Dependency {
    associatedtype Key: EnvironmentKey, Resolvable
    static var defaultValue: (any Dependency) { get }
}

public extension Dependency {
    static var defaultValue: (any Dependency) { Key._resolve() }
}

public protocol Resolvable {
    static var _resolve: (() -> any Dependency) { get set }
}
