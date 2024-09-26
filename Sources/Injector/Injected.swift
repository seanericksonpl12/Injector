//
//  Injected.swift
//
//
//  Created by Sean Erickson on 9/26/24.
//

import Foundation

@propertyWrapper
public class Injected<Value: Dependency> {
    
    @usableFromInline
    let keyPath: KeyPath<EnvironmentValues, Value>

    @available(*, unavailable)
    public var wrappedValue: Value {
        get { fatalError("This wrapper only works on instance properties of classes") }
        set { fatalError("This wrapper only works on instance properties of classes") }
    }
    
    @inlinable
    public static subscript<M: Injectable>(
        _enclosingInstance instance: M,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<M, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<M, Injected>
    ) -> Value {
        get {
            let dependency = instance[keyPath: storageKeyPath]
            if let value = instance.resolvers[dependency.keyPath]?.resolve(for: Value.self) ?? instance.environment[Value.Key.self] as? Value {
                return value
            } else if let value = instance.environment[keyPath: dependency.keyPath] as? Value.Key.Value {
                instance.environment[Value.Key.self] = value
            }
            
            return instance.environment[Value.Key.self] as! Value
        }
        set {
            print("*** WARNING! ***\nYou are setting an Injected Value manually. This will be overridden by an Injection!")
            let dependency = instance[keyPath: storageKeyPath]
            if let value = instance.environment[keyPath: dependency.keyPath] as? Value.Key.Value {
                instance.environment[Value.Key.self] = value
            }
        }
    }
    
    @inlinable
    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}
