import FirebaseRemoteConfig

class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let jsonDecoder = JSONDecoder()
    private var defaultValue: [String: NSObject] = [:]
    var titleString: String = ""
    private let titleKey = "title_name"
    var cardRemoteConfig: CardRemomteConfigEntity?
    private let cardKey = "card_key"
    
    
    private func updateVariables() {
        titleString = remoteConfig[titleKey].stringValue ?? ""
       cardRemoteConfig = (try? jsonDecoder.decode(CardRemomteConfigEntity.self, from: remoteConfig[cardKey].dataValue))
    }
    
    private init() {
        remoteConfig.configSettings = RemoteConfigSettings()
        updateVariables()
        //開発環境の場合は0、本番環境(App Storeに配布する場合)では、は3600(１時間)以上に設定してください。
        let expirationDuration = 0
        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) {
            [weak self] (status, _) in
            switch status {
            case .success:
                self?.remoteConfig.activate(completionHandler: { error in
                    if let error = error {
                        print("error:\(error)")
                    }
                    self?.updateVariables()
                })
            case .failure:
                print("error: remote config fetch failure")
            default: break
            }
        }
    }
}
