# ConnectionKage: Reachability SDK

**ConnectionKage SDK** is a lightweight and flexible library for monitoring network reachability and connection status on iOS. This SDK helps developers understand network conditions, connection types, and handle scenarios where the device lacks connectivity.

## Features
- Monitor real-time network reachability.
- Identify network connection types (WiFi, Cellular, Ethernet, Loopback, etc.).
- Detect constrained and expensive network conditions.
- Understand the reasons for an unsatisfied network path (e.g., VPN inactive, WiFi disabled).
- Easy integration with a customizable abstraction layer for testing.

---

## Installation

### Swift Package Manager
To integrate ConnectionKage into your project:
1. Open your project in Xcode.
2. Navigate to **File → Add Packages...**.
3. Enter the repository URL: `https://github.com/Swiftkage/ConnectionKage`.
4. Choose the appropriate version and click **Add Package**.

---

## Usage

### Getting Started
Start by creating an instance of the `Reachability` class:

```swift
import ConnectionKage

@State var reachability = Reachability()

reachability.startMonitoring()
```

### Monitor Network Changes
You can observe network status, connection type, and other properties:

```swift
print("Is Reachable: \(reachability.isReachable)")
print("Connection Type: \(reachability.connectionType)")
print("Is Constrained: \(reachability.isConstrained)")
print("Is Expensive: \(reachability.isExpensive)")

if let reason = reachability.disconnectionReason {
    print("Disconnection Reason: \(reason)")
}
```

### Stop Monitoring
When monitoring is no longer required, stop the `Reachability` monitor to free resources:

```swift
reachability.stopMonitoring()
```

