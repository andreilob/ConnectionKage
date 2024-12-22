import Foundation

struct Path: ConnectionPath {
    var status: PathStatus
    var isConstrained: Bool
    var isExpensive: Bool
    var connectionType: ConnectionType
    var unsatisfiedReason: DisconnectionReason?
}
