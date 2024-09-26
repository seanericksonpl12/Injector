//
//  Extensions.swift
//  Injector
//
//  Created by Sean Erickson on 9/25/24.
//
import SwiftUI

extension EnvironmentValues {
    
    /// Resolves and returns the given dependency
    ///
    /// ```
    ///  extension Dependencies {
    ///     var myDependency: MyDependency { resolve() }
    ///  }
    /// ```
    ///
    /// > Warning: If a `defaultValue` is not specified in the
    /// > given dependency model, a `fatal error` will occur.
    ///
    /// - Returns: The resolved dependency or its defaultValue
    @inlinable 
    public func resolve<V: Dependency>() -> V {
        guard let value = self[V.Key.self] as? V else {
            fatalError("Failed to resolve \(V.self)")
        }
        return value
    }
    
    /// Resolves and returns the given dependency with a given
    /// default value
    ///
    /// ```
    ///  extension Dependencies {
    ///     var myDependency: MyDependency { resolve(withDefault: MyDependency( ... )) }
    ///  }
    /// ```
    ///
    /// - Returns: The resolved dependency or its defaultValue
    @inlinable
    public func resolve<V: Dependency>(
        withDefault value: @autoclosure @escaping (() -> V)
    ) -> V {
        V.Key._resolve = value
        guard let value = self[V.Key.self] as? V else {
            fatalError("Failed to resolve \(V.self)")
        }
        return value
    }
}
