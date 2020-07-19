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
```

Для использования необходимо получить client id и передать его при создании модели

<sub>Swift</sub>
```
let model: AuthManagerProtocol = AuthModel(
       with: <CLIENT_ID>,
       redirectScheme: "ru.hse.pf://",
       host: "auth.hse.ru",
       reditectPath: "/adfs/oauth2/ios/ru.hse.pf/callback"
       )
if let context = UIApplication.shared.keyWindow {
    model.authManager = AuthManager(with: context)
}
DispatchQueue.global(qos: .utility).async {
 let result = self.model.auth()
 DispatchQueue.main.async {
     switch result {
       case let .success(data):
           print(data)
        case let .failure(error):
           print(error)
        }
    }
}
```
