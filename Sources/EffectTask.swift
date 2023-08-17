import Foundation
import Combine

public enum EffectTask<Effect> {
    public typealias Operation = @Sendable () async -> Self
    public typealias Feedback = (Self) -> Void

    case none
    case publisher((@escaping Feedback) -> AnyCancellable)
    case effects([Effect])
    case run(AnyHashable, Operation)
    indirect case combine([Self])

    public static func effect(_ effects: Effect...) -> Self {
        .effects(effects)
    }

    public static func merge(_ tasks: Self...) -> Self {
        .combine(tasks)
    }

    public static func run(_ operation: @escaping Operation) -> Self {
        .run(UUID(), operation)
    }
}