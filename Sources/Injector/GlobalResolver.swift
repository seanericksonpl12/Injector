//
//  GlobalResolver.swift
//
//
//  Created by Sean Erickson on 9/25/24.
//

public class GlobalResolver {
    private init() {}
    
    static let shared = GlobalResolver()
    
    private var values = EnvironmentValues()
    private var resolvers: [AnyKeyPath: InstanceResolver] = [:]
    
    public static func inject<Value>(
        _ keyPath: KeyPath<EnvironmentValues, Value>,
        _ value: @autoclosure @escaping () -> Value
    ) {
        shared.resolvers[keyPath] = SingletonInstanceResolver(resolver: value)
    }
    
    public func resolve<Value>(_ keyPath: KeyPath<EnvironmentValues, Value>) -> Value {
        resolvers[keyPath]?.resolve(for: Value.self) ?? values[keyPath: keyPath]
    }
}
