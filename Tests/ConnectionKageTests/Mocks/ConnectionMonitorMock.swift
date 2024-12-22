import Testing
@testable import ConnectionKage

final class ConnectionMonitorMock: PathMonitor {
    var pathUpdateHandler: ((any ConnectionPath) -> Void)?
    var isStarted: Bool = false
    
    private var path: ConnectionPath
    
    init(path: ConnectionPath) {
        self.path = path
    }
    
    func start() {
        isStarted = true
        pathUpdateHandler?(path)
    }
    
    func cancel() {
        isStarted = false
    }
}
