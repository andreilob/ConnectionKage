import Network

final class ConnectionMonitor: PathMonitor, @unchecked Sendable {
    var pathUpdateHandler: ((any ConnectionPath) -> Void)?
    var isStarted: Bool = false
    
    private let monitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "ConnectionKage.Reachability.MonitorQueue", qos: .background)
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            pathUpdateHandler?(
                Path(
                    status: PathStatus(path: path),
                    isConstrained: path.isConstrained,
                    isExpensive: path.isExpensive,
                    connectionType: ConnectionType(path: path),
                    unsatisfiedReason: DisconnectionReason(path: path)
                )
            )
        }
    }
    
    func start() {
        monitor.start(queue: monitorQueue)
        isStarted = true
    }
    
    func cancel() {
        monitor.cancel()
        isStarted = false
    }
}
