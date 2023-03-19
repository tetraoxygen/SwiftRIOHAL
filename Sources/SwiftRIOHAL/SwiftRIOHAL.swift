import CRIOHAL

enum DriverStationMode {
    case disabled
    case teleop
    case test
    case auto
};

func getDriverStationMode() -> DriverStationMode {
    var word = HAL_ControlWord()
    HAL_GetControlWord(&word);

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
