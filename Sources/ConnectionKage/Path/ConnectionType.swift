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
        if path.usesInterfaceType(.wifi) {
            self = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            self = .ethernet
        } else if path.usesInterfaceType(.loopback) {
            self = .loopback
        } else {
            self = .unknown
        }
    }
}
