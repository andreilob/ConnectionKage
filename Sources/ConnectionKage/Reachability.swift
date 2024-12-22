import Observation

@Observable
public final class Reachability: @unchecked Sendable {
    /// A Boolean value that indicates whether the current network path is reachable.
    ///
    /// This property provides information about whether the device has an active network connection. A reachable
    /// path means that the device can connect to the internet, either via WiFi, cellular, or another available network
    /// interface. It helps in determining if network-dependent operations, such as data fetches or uploads, should proceed.
    ///
    /// ### When to Check `isReachable`:
    /// - **Network Availability:** To check if the device has access to the internet or can connect to a remote server.
    /// - **Network State Monitoring:** To determine whether the app should attempt network operations, such as making API calls,
    ///   or if it should handle offline scenarios gracefully.
    ///
    /// - Note: This property is updated whenever the network path changes. It reflects the device's ability to connect
    ///   to the internet, and its value will change as network conditions evolve (e.g., switching from WiFi to cellular).
    ///   It is important to monitor this property continuously for real-time updates.
    public private(set) var isReachable = false
    
    /// The type of the current network connection.
    ///
    /// This property provides information about the type of network connection the device is currently using.
    /// It can indicate whether the device is connected via WiFi, cellular, wired Ethernet, loopback interface, or
    /// if the connection is unknown. This is useful for adjusting network-related behavior based on the type of connection.
    ///
    /// - Note: This property is updated whenever the network path changes and provides the current network
    ///   type based on the available interface types.
    public private(set) var connectionType: ConnectionType = .unknown
    
    /// A Boolean value that indicates whether the current network path is constrained by system-imposed limits.
    ///
    /// This property is useful for determining if the network connection is subject to restrictions such as data
    /// usage limits, low data mode, or network throttling. When `isConstrained` is `true`, the system may limit
    /// bandwidth or apply other constraints to the connection, typically in order to reduce data consumption or
    /// ensure better performance on constrained networks (e.g., cellular connections).
    ///
    /// ### When to Check `isConstrained`
    /// - **Low Data Mode:** When the device is in low data mode, this value will be `true`.
    /// - **Data Usage Limits:** If the user has exceeded their data usage or is on a network with limited bandwidth,
    ///   this property may return `true`.
    /// - **Cellular Networks:** Some cellular networks may apply constraints based on the user's plan or network conditions.
    public private(set) var isConstrained = false
    
    /// A Boolean value that indicates whether the current network path is considered expensive.
    ///
    /// This property is useful for determining if the network connection is likely to incur high costs, such as
    /// when the device is connected to a cellular network that charges for data usage or when the connection is
    /// slow or unreliable. The system marks such connections as "expensive" to help applications manage data usage
    /// and optimize performance.
    ///
    /// ### When to Check `isExpensive`:
    /// - **Cellular Networks:** Many cellular networks are considered expensive because data usage may incur charges.
    /// - **Slow or Unreliable Networks:** In some cases, even if the network is not cellular, the system may mark a slow
    ///   or unreliable connection as expensive to alert apps to be mindful of data usage and performance.
    ///
    /// - Note: The value of `isExpensive` may change during the lifetime of a network connection,
    ///   so it is recommended to monitor it continuously for the most accurate state.
    public private(set) var isExpensive = false
    
    /// Represents the reason for a network disconnection or unsatisfied network path.
    ///
    /// This enum is used to provide a more specific explanation when a network path is considered unsatisfied.
    /// It corresponds to various conditions under which the device's network connection may be unavailable,
    /// such as the user disabling certain network services or a required VPN being inactive.
    public private(set) var disconnectionReason: DisconnectionReason?

    private var monitor: PathMonitor
    
    public init() {
        self.monitor = ConnectionMonitor()
        setMonitorHandler()
    }

    init(monitor: PathMonitor = ConnectionMonitor()) {
        self.monitor = monitor
        setMonitorHandler()
    }
    
    public func startMonitoring() {
        monitor.start()
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func setMonitorHandler() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            isReachable = path.status == .satisfied
            connectionType = path.status == .satisfied ? path.connectionType : .unknown
            isConstrained = path.isConstrained
            isExpensive = path.isExpensive
            disconnectionReason = path.status == .unsatisfied ? path.unsatisfiedReason : nil
        }
    }
}
