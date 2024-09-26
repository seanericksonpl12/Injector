//
//  GlobalResolver.swift
//
//
//  Created by Sean Erickson on 9/25/24.
//

public class GlobalResolver {
    private init() {}
    
    @usableFromInline
    static let shared = GlobalResolver()
    
    @usableFromInline
    internal var values = EnvironmentValues()
    
    @usableFromInline
    internal var resolvers: [AnyKeyPath: InstanceResolver] = [:]
    
    @inlinable
    public static func inject<Value: Dependency>(
        _ keyPath: KeyPath<EnvironmentValues, Value>,
        _ value: @autoclosure @escaping () -> Value
    ) {
        shared.resolvers[keyPath] = SingletonInstanceResolver(resolver: value)
    }
    
    @inlinable
    public func resolve<Value>(_ keyPath: KeyPath<EnvironmentValues, Value>) -> Value {
        resolvers[keyPath]?.resolve(for: Value.self) ?? values[keyPath: keyPath]
    }
}
