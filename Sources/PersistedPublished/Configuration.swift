import Foundation

/// Configuration for making Published to persist its value
public struct Configuration<Value: Codable> {
    /// Create configuration to customise PersistedPublished
    /// - Parameters:
    ///   - key: Key used for setting and getting in UserDefaults
    ///   - userDefaults: UserDefaults used for setting and getting value for given key
    ///   - onGetError: Fallback, when encountering error on getting/decoding value for given key
    ///   - onSetError: Fallback, when encountering error on setting/encoding value for given key
    ///   - decoder: Decoder, used for decoding Data into Value
    ///   - encoder: Decoder, used for encoding Value into Data
    public init(key: String, userDefaults: UserDefaults, onGetError: @escaping (Error) -> Value, onSetError: @escaping (Error) -> Void, decoder: JSONDecoder, encoder: JSONEncoder) {
        self.key = key
        self.userDefaults = userDefaults
        self.onGetError = onGetError
        self.onSetError = onSetError
        self.decoder = decoder
        self.encoder = encoder
    }
    
    let key: String, userDefaults: UserDefaults,
        onGetError: (Error) -> Value, onSetError: (Error) -> Void,
        decoder: JSONDecoder, encoder: JSONEncoder

    func value() -> Value {
        do {
            guard let data = userDefaults.data(forKey: key) else { throw DecodingError.noValue }
            return try decoder.decode(Value.self, from: data)
        } catch {
            return onGetError(error)
        }
    }

    func setValue(_ value: Value?) {
        do {
            let data = try value.map { try encoder.encode($0) }
            userDefaults.setValue(data, forKey: key)
        } catch {
            onSetError(error)
        }
    }

    /// Default configuration, whern Published is initialised with just key and initial value. This configuration uses UserDefaults.standard. Decoding and encoding errors are printed to console
    /// - Parameters:
    ///   - key: Key used for setting and getting in UserDefaults
    ///   - value: Initial value that is used if there is no such value for such key or if encountered decoding error
    /// - Returns: Configuration that's passed into Published(configuration:)
    public static func `default`<Value>(forKey key: String, initialValue value: Value) -> Configuration<Value> {
        Configuration<Value>(
            key: key, userDefaults: .standard,
            onGetError: { e in
                if case DecodingError.noValue = e { } else {
                    print("Error while decoding value for key \(key):\n\(e)")
                }
                return value
            },
            onSetError: { e in print("Error while encoding for key \(key):\n\(e)") },
            decoder: .init(), encoder: .init()
        )
    }
}
