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
    let environment = EnvironmentValues()
    lazy var _wrappedValue = GlobalResolver.shared.resolvers[keyPath]?.resolve(for: Value.self) ?? environment[keyPath: keyPath] ?? environment[Value.Key.self] as! Value
    
    public var wrappedValue: Value {
        get { _wrappedValue }
        set { _wrappedValue = newValue }
    }
    
    @inlinable
    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}
