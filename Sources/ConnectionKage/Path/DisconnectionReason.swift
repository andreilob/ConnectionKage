import Network

public enum DisconnectionReason {
    /// No specific reason is given for the network disconnection. This is a default case when the reason is unknown.
    case notAvailable
    
    ///  The user has disabled cellular data access on the device, preventing the use of cellular networks.
    case cellularDenied
    
    /// The user has disabled Wi-Fi on the device, making it impossible to connect to Wi-Fi networks.
    case wifiDenied
    
    /// The user has disabled local network access, which may impact features that require local communication between devices.
    case localNetworkDenied
    
    /// A required VPN connection is inactive or unavailable, preventing access to the network as intended.
    case vpnInactive
    
    init(path: NWPath) {
        switch path.unsatisfiedReason {
        case .notAvailable: self = .notAvailable
        case .cellularDenied: self = .cellularDenied
        case .wifiDenied: self = .wifiDenied
        case .localNetworkDenied: self = .localNetworkDenied
        case .vpnInactive: self = .vpnInactive
        default: self = .notAvailable
        }
    }
}
