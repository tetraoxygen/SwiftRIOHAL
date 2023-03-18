import CRIOHAL

enum DriverStationMode {
    case DisabledMode
    case TeleopMode
    case TestMode
    case AutoMode
};

func getDriverStationMode() -> DriverStationMode {
    var word = HAL_ControlWord()
    HAL_GetControlWord(&word);

    if (word.enabled == 0) {
        HAL_ObserveUserProgramDisabled()
        return .DisabledMode
    } else {
        word.autonomous
    }

}
