import Foundation

/// Decoding errors when getting value from UserDefaults
public enum DecodingError: Error {
    /// When value for a key is nil in UserDefaults
    case noValue
}
