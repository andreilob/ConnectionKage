import Testing
@testable import ConnectionKage

@Suite struct ReachabilityRunningMethodsTests {
    @Test("testReachabilityStartAndCancel")
    func testReachabilityStartAndCancel() {
        let pathMock = PathMock(
            status: .satisfied,
            isConstrained: false,
            isExpensive: false,
            connectionType: .wifi,
            unsatisfiedReason: nil
        )
        
        let monitorMock = ConnectionMonitorMock(path: pathMock)
        let sut = Reachability(monitor: monitorMock)
        
        #expect(!monitorMock.isStarted)
        sut.startMonitoring()
        
        #expect(monitorMock.isStarted)
        sut.stopMonitoring()
        #expect(!monitorMock.isStarted)
    }
}

@Suite struct ReachabilityConnectionTests {
    @Test("testReachabilitySatisfiedConnection")
    func testReachabilitySatisfiedConnection(){
        let pathMock = PathMock(
            status: .satisfied,
            isConstrained: false,
            isExpensive: false,
            connectionType: .wifi,
            unsatisfiedReason: .wifiDenied
        )
        
        let monitorMock = ConnectionMonitorMock(path: pathMock)
        let sut = Reachability(monitor: monitorMock)
        sut.startMonitoring()
        
        #expect(sut.isReachable)
        #expect(sut.connectionType == .wifi)
        #expect(sut.disconnectionReason == nil)
    }
    
    @Test("testReachabilityUnsatisfiedConnection")
    func testReachabilityUnsatisfiedConnection(){
        let pathMock = PathMock(
            status: .unsatisfied,
            isConstrained: false,
            isExpensive: false,
            connectionType: .wifi,
            unsatisfiedReason: .wifiDenied
        )
        
        let monitorMock = ConnectionMonitorMock(path: pathMock)
        let sut = Reachability(monitor: monitorMock)
        sut.startMonitoring()
        
        #expect(!sut.isReachable)
        #expect(sut.connectionType == .unknown)
        #expect(sut.disconnectionReason == .wifiDenied)
    }
}
