import Network

public enum ConnectionType {
    /// The device is connected to a WiFi network.
    case wifi
    
    /// The device is connected to a cellular network.
    case cellular
    
    /// The device is connected to a wired Ethernet network.
    case ethernet
    
    /// The device is using a loopback interface (typically used for local communication within the device itself).
    case loopback
    
    /// The connection type could not be determined, or no network connection is available.
    case unknown
    
    init(path: NWPath) {
        for interface in path.availableInterfaces {
            if path.usesInterfaceType(interface.type) {
                switch interface.type {
                case .other: self = .unknown
                case .wifi: self = .wifi
                case .cellular: self = .cellular
                case .wiredEthernet: self = .ethernet
                case .loopback: self = .loopback
                default: self = .unknown
                }
            }
        }
        self = .unknown
    }
}
