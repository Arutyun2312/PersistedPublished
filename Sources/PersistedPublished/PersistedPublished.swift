import Combine
import Foundation

private var cancellable: Set<AnyCancellable> = []

public extension Published where Value: Codable {
    /// Create Published that is able to persist its value in UserDefaults
    /// - Parameter configuration: Full control over how PersistedPublished works
    init(configuration: Configuration<Value>)  {
        self.init(wrappedValue: configuration.value())
        projectedValue
            .sink { configuration.setValue($0) }
            .store(in: &cancellable)
    }
    /// Create Published that is able to persist its value in UserDefaults, using Configuration.default
    /// - Parameters:
    ///   - key: Key used for setting and getting in UserDefaults
    ///   - value: Initial value that is used if there is no such value for such key or if encountered decoding error
    ///
    /// Here is an example code:
    /// ```
    /// import Foundation
    ///
    /// final class ViewModel: ObservableObject {
    ///     @Published(forKey: "acceptedRules") var acceptedRules = false
    /// }
    /// ```
    init(forKey key: String, initialValue value: Value) {
        self.init(configuration: .default(forKey: key, initialValue: value))
    }
}