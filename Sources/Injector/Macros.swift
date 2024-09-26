// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro defines a Dependency by conforming to the `Dependency`
/// protocol, and adding necessary Environment Key value
@attached(extension, conformances: Dependency)
@attached(member, names: arbitrary)
public macro Dependency() = #externalMacro(module: "InjectorMacros", type: "DependencyMacro")
