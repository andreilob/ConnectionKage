import Testing
@testable import ConnectionKage

final class PathMock: ConnectionPath  {
    var status: PathStatus
    var isConstrained: Bool
    var isExpensive: Bool
    var connectionType: ConnectionType
    var unsatisfiedReason: DisconnectionReason?
    
    init (
        status: PathStatus,
        isConstrained: Bool,
        isExpensive: Bool,
        connectionType: ConnectionType,
        unsatisfiedReason: DisconnectionReason?
    ) {
        self.status = status
        self.isConstrained = isConstrained
        self.isExpensive = isExpensive
        self.connectionType = connectionType
        self.unsatisfiedReason = unsatisfiedReason
    }
}
