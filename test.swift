import XCTest

class TemperatureControllerTests: XCTestCase {
    
    // Test that the temperature remains unchanged when the current temperature is within the preferred range (occupied state)
    func testAdjustTemperatureOccupiedWithinRange() {
        let controller = TemperatureController(initialTemperature: 22.0, outsideTemperature: 15.0, occupancy: .occupied)
        controller.setTemperaturePreferences(minTemp: 20.0, maxTemp: 24.0)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 22.0, "Temperature should remain unchanged when within range")
    }
    
    // Test that the temperature is adjusted down when it's above the max preferred temperature (occupied state)
    func testAdjustTemperatureOccupiedAboveMax() {
        let controller = TemperatureController(initialTemperature: 25.0, outsideTemperature: 15.0, occupancy: .occupied)
        controller.setTemperaturePreferences(minTemp: 20.0, maxTemp: 24.0)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 24.0, "Temperature should decrease to max preference")
    }
    
    // Test that the temperature is adjusted up when it's below the min preferred temperature (occupied state)
    func testAdjustTemperatureOccupiedBelowMin() {
        let controller = TemperatureController(initialTemperature: 18.0, outsideTemperature: 15.0, occupancy: .occupied)
        controller.setTemperaturePreferences(minTemp: 20.0, maxTemp: 24.0)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 19.0, "Temperature should increase to min preference")
    }
    
    // Test that the temperature is adjusted towards the outside temperature when vacant
    func testAdjustTemperatureVacantAboveOutsideTemp() {
        let controller = TemperatureController(initialTemperature: 22.0, outsideTemperature: 18.0, occupancy: .vacant)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 21.5, "Temperature should decrease towards the outside temperature when vacant")
    }
    
    // Test that the temperature is adjusted towards the outside temperature when vacant and outside is warmer
    func testAdjustTemperatureVacantBelowOutsideTemp() {
        let controller = TemperatureController(initialTemperature: 16.0, outsideTemperature: 18.0, occupancy: .vacant)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 16.5, "Temperature should increase towards the outside temperature when vacant")
    }
    
    // Test the energy consumption after adjusting temperature while occupied
    func testEnergyConsumptionOccupied() {
        let controller = TemperatureController(initialTemperature: 18.0, outsideTemperature: 15.0, occupancy: .occupied)
        controller.setTemperaturePreferences(minTemp: 20.0, maxTemp: 24.0)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getEnergyConsumption(), 0.5, "Energy consumption should increase after temperature adjustment")
    }
    
    // Test the energy consumption when the room is vacant and temperature is adjusted
    func testEnergyConsumptionVacant() {
        let controller = TemperatureController(initialTemperature: 22.0, outsideTemperature: 18.0, occupancy: .vacant)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getEnergyConsumption(), 0.2, "Energy consumption should increase when vacant and temperature adjusts towards outside")
    }
    
    // Test that temperature doesn't adjust if no preferences are set (edge case)
    func testAdjustTemperatureNoPreferences() {
        let controller = TemperatureController(initialTemperature: 22.0, outsideTemperature: 15.0, occupancy: .occupied)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 22.0, "Temperature should not adjust if preferences are not set")
    }
    
    // Test the edge case where initial temperature is exactly at the min or max preference
    func testAdjustTemperatureAtMinMaxBoundary() {
        let controller = TemperatureController(initialTemperature: 20.0, outsideTemperature: 15.0, occupancy: .occupied)
        controller.setTemperaturePreferences(minTemp: 20.0, maxTemp: 24.0)
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 20.0, "Temperature should remain at the min boundary if already set")
        
        controller.adjustTemperature()
        XCTAssertEqual(controller.getCurrentTemperature(), 20.0, "Temperature should remain at the min boundary after adjustment")
    }
}
