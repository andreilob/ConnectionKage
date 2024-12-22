import Network

enum PathStatus {
    /// The path has a usable route upon which to send and receive data
    case satisfied
    
    /// The path does not have a usable route. This may be due to a network interface being down, or due to system policy.
    case unsatisfied
    
    /// The path does not currently have a usable route, but a connection attempt will trigger network attachment.
    case requiresConnection
    
    init(path: NWPath) {
        switch path.status {
        case .satisfied: self = .satisfied
        case .requiresConnection: self = .requiresConnection
        case .unsatisfied: self = .unsatisfied
        default: self = .unsatisfied
        }
    }
}
