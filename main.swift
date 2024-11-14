import Foundation

// Enum to represent whether the room is occupied or vacant
enum OccupancyState {
    case occupied
    case vacant
}

// Struct to hold user-defined temperature preferences
struct TemperaturePreferences {
    let minTemp: Double
    let maxTemp: Double
}

// TemperatureController class that manages the room temperature
class TemperatureController {
    private var currentTemperature: Double
    private var outsideTemperature: Double
    private var occupancy: OccupancyState
    private var energyConsumption: Double = 0.0
    private var preferences: TemperaturePreferences?
    
    // Initializer to set the initial state of the controller
    init(initialTemperature: Double, outsideTemperature: Double, occupancy: OccupancyState) {
        self.currentTemperature = initialTemperature
        self.outsideTemperature = outsideTemperature
        self.occupancy = occupancy
    }
    
    // Method to set the user’s temperature preferences
    func setTemperaturePreferences(minTemp: Double, maxTemp: Double) {
        preferences = TemperaturePreferences(minTemp: minTemp, maxTemp: maxTemp)
    }
    
    // Method to adjust the temperature based on occupancy and preferences
    func adjustTemperature() {
        // Ensure that preferences are set before making adjustments
        guard let preferences = preferences else { return }
        
        switch occupancy {
        case .occupied:
            // Increase temperature if it's too low
            if currentTemperature < preferences.minTemp {
                currentTemperature += 1.0
                energyConsumption += 0.5
            } 
            // Decrease temperature if it's too high
            else if currentTemperature > preferences.maxTemp {
                currentTemperature -= 1.0
                energyConsumption += 0.5
            }
        case .vacant:
            // Adjust temperature based on outside temperature when vacant
            if currentTemperature > outsideTemperature {
                currentTemperature -= 0.5
                energyConsumption += 0.2
            } else if currentTemperature < outsideTemperature {
                currentTemperature += 0.5
                energyConsumption += 0.2
            }
        }
    }
    
    // Method to get the current temperature of the room
    func getCurrentTemperature() -> Double {
        return currentTemperature
    }
    
    // Method to get the total energy consumption
    func getEnergyConsumption() -> Double {
        return energyConsumption
    }
}
