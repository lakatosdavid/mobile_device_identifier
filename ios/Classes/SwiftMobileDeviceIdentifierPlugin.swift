import Flutter
import UIKit
import Security

public class SwiftMobileDeviceIdentifierPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mobile_device_identifier", binaryMessenger: registrar.messenger())
        let instance = SwiftMobileDeviceIdentifierPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getDeviceId":
            let key = "com.alfanthariq.mobile_device_identifier/device_id"
            result(self.getDeviceIdentifierFromKeychain(key: key))
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func getDeviceIdentifierFromKeychain(key: String) -> String {
        var deviceUDID = keychainLoad(key: key)
        if deviceUDID == nil {
            deviceUDID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
            keychainSave(key: key, value: deviceUDID!)
        }
        return deviceUDID!
    }

    private func keychainSave(key: String, value: String) {
        let data = value.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private func keychainLoad(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess,
              let data = item as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        return value
    }
}