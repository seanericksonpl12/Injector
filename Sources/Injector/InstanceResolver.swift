//
//  InstanceResolver.swift
//
//
//  Created by Sean Erickson on 9/25/24.
//

public protocol InstanceResolver {
    func resolve<Value>(for type: Value.Type) -> Value?
}

final class SingletonInstanceResolver<Value>: InstanceResolver {
    
    private(set) var instance: Value?
    private var resolveAction: (() -> Value)?
    
    @inlinable init(resolver: @escaping () -> Value) {
        self.resolveAction = resolver
    }
    
    func resolve<V>(for type: V.Type) -> V? {
        guard let instance else {
            let resolveAction = self.resolveAction!
            let newInstance = resolveAction()
            self.resolveAction = nil
            
            self.instance = newInstance
            return newInstance as? V
        }
        return instance as? V
    }
}
