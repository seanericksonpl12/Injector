//
//  GlobalInjected.swift
//
//
//  Created by Sean Erickson on 9/25/24.
//

@propertyWrapper
public class GlobalInjected<Value: Dependency> {
    
    private let resolver = GlobalResolver.shared
    private let keyPath: KeyPath<EnvironmentValues, Value>
    
    private lazy var _wrappedValue: Value = resolver.resolve(keyPath)

    public var wrappedValue: Value {
        get { _wrappedValue }
        set { _wrappedValue = newValue }
    }
    
    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}
