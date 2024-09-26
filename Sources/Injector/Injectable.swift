//
//  File.swift
//  
//
//  Created by Sean Erickson on 9/26/24.
//

import Foundation

open class Injectable {
    public init() {}
    
    public final var environment: EnvironmentValues = EnvironmentValues()
    
    @usableFromInline
    final var resolvers: [AnyKeyPath: InstanceResolver] = [:]
    
    @inlinable
    public final func inject<Value>(
        _ keyPath: KeyPath<EnvironmentValues, Value>,
        _ value: @autoclosure @escaping () -> Value
    ) where Value : Dependency {
        resolvers[keyPath] = SingletonInstanceResolver(resolver: value)
    }
}
