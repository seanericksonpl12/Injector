//
//  InstanceResolver.swift
//
//
//  Created by Sean Erickson on 9/25/24.
//

@usableFromInline
protocol InstanceResolver {
    func resolve<Value>(for type: Value.Type) -> Value?
}

@usableFromInline
final class SingletonInstanceResolver<Value>: InstanceResolver {
    
    private(set) var instance: Value?
    private var resolveAction: (() -> Value)?
    
    @usableFromInline
    init(resolver: @escaping () -> Value) {
        self.resolveAction = resolver
    }
    
    @usableFromInline
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
