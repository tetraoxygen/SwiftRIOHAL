import CRIOHAL
import Foundation

enum DriverStationMode {
    case disabled
    case teleop
    case test
    case auto
};

func getDriverStationMode() -> DriverStationMode {
    var word = HAL_ControlWord()
    HAL_GetControlWord(&word)

    guard word.enabled !=  0 else {
        HAL_ObserveUserProgramDisabled()
        return .disabled
    }

    if word.autonomous !=  0 {
        HAL_ObserveUserProgramAutonomous();
        return .auto
    } else if word.test !=  0 {
        HAL_ObserveUserProgramTest()
        return .test
    } else {
        HAL_ObserveUserProgramTeleop()
        return .teleop
    }
}

/// Prints the control word.
func printControlWord() {
    var word = HAL_ControlWord()
    HAL_GetControlWord(&word)

    print(word)
}

actor DriverStationManager {
    var mode: DriverStationMode = .disabled

    var managementTask: Task<Void, any Error>?

    func startManagement() {
        // Might want to revisit the priority on this
        let bgTask = Task(priority: .background) {
            while true {
                guard !Task.isCancelled else {
                    break
                }
                // babysit the RIO
                try await Task.sleep(for: .milliseconds(40))
            }
        }
    }

}
