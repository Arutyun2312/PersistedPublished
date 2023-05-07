# PersistedPublished

`PersistedPublished` is a Swift package that extends the Published property wrapper. It adds the ability to persist the value in user defaults. 

## Basic Usage

Whenever value in `accepted` changes, it's saved in user defaults by key `acceptedRules`. The value can of the field can be anything that conforms to Codable.
```swift
import Foundation
import PersistedPublished

final class ViewModel: ObservableObject {
     @Published(forKey: "acceptedRules") var accepted = false
}
```
When encountering encoding/decoding errors, these errors are printed in console and then ignored. You can customise this behaviour. See section below.

## Advanced Usage

If you wish to handle encoding/decoding errors, provide custom encoders/decoders and/or provide custom UserDefaults, you can pass `Configuration` instead. Here is configuration that gives same behaviour as above code.
```swift    
import Foundation
import PersistedPublished

let configuration = Configuration(
    key: "acceptedRules", userDefaults: .standard,
    onGetError: { e in
        if case DecodingError.noValue = e { } else {
            print("Error while decoding value for key acceptedRules:\n\(e)")
        }
        return false
    },
    onSetError: { e in print("Error while encoding for key acceptedRules:\n\(e)") },
    decoder: .init(), encoder: .init()
)

final class ViewModel: ObservableObject {
    @Published(configuration: configuration) var accepted: Bool
}
```

## Installation (Swift Package Manager)

>📱 iOS 13.0+, 🖥️ macOS 10.15+

When using Xcode 11 or later, you can install `PersistedPublished` by going to your Project settings > `Swift Packages` and add the repository by providing the GitHub URL `https://github.com/Arutyun2312/PersistedPublished`. Alternatively, you can go to `File` > `Swift Packages` > `Add Package Dependencies...`

When using a package, you can install `PersistedPublished` using [Swift Package Manager](https://swift.org/package-manager/), add
`.package(name: "PersistedPublished", url: "https://github.com/Arutyun2312/PersistedPublished", from: "1.0.0"),"` to your Package.swift, then follow the integration tutorial [here](https://swift.org/package-manager#importing-dependencies).

MIT License
-----------
    Copyright (c) 2015-2019 Charles Scalesse.

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
