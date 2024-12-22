import Foundation

protocol ConnectionPath {
    var status: PathStatus { get }
    var isConstrained: Bool { get }
    var isExpensive: Bool { get }
    var connectionType: ConnectionType { get }
    var unsatisfiedReason: DisconnectionReason? { get }
}
