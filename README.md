# HSEAuth

Утилита, позволяющая авторизоваться с использованием openID

В проекте следует добавить в Info.plist

<sub>XML</sub>
```
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>None</string>
        <key>CFBundleURLName</key>
        <string>auth0</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>ru.hse.pf</string>
        </array>
    </dict>
</array>
<key>CFBundleVersion</key>
```

Для использования необходимо получить client id и передать его при создании модели

<sub>Swift</sub>
```
var model: Model = Model(with: <CLIENT_ID>)
if let context = UIApplication.shared.keyWindow {
    model.authManager = AuthManager(with: context)
}
model.auth {
    switch $0 {
    case .success(let code):
        //handle token
    case .failure(let error):
        handle error
    }
}
```
