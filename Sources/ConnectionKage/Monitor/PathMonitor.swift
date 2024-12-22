import Foundation

protocol PathMonitor {
    var pathUpdateHandler: ((ConnectionPath) -> Void)? { get set }
    var isStarted: Bool { get }
    
    func start()
    func cancel()
}
