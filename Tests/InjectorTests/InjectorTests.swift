import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(InjectorMacros)
import InjectorMacros

let testMacros: [String: Macro.Type] = [
    "Dependency": DependencyMacro.self,
]
#endif

final class InjectorTests: XCTestCase {
    func testMacro() throws {
        #if canImport(InjectorMacros)
        assertMacroExpansion(
            """
            @Dependency
            class MyDependency {
                var someValue: Bool = false
            }
            """,
            expandedSource: """
            class MyDependency {
                var someValue: Bool = false
            
                struct MyDependencyKey : EnvironmentKey {
                    static let defaultValue = MyDependency.defaultValue
                }
                    typealias Key = MyDependencyKey
            }
            
            extension MyDependency : Dependency {
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

//    func testMacroWithStringLiteral() throws {
//        #if canImport(InjectorMacros)
//        assertMacroExpansion(
//            #"""
//            #stringify("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
}
