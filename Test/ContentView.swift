//
//  ContentView.swift
//  Test
//
//  Created by Mia Dai on 4/24/25.
//
//  adding stuff here

import Foundation
import HealthKit
import Observation

enum HealthError:  Error {
    case healthDataNotAvialable
}


@Observable

class HealthStore {
    
    
    var healthStore: HKHealthStore?
    var lastError: Error?
    
    
    init() {
    
    
        if HKHealthStore.isHealthDataAvailable() {
        healthStore = HKHealthStore()
    } else {
        lastError = HealthError.healthDataNotAvialable
    }
}

    func requestAuthorization() async {
        
        guard let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else { return }
        guard let healthStore = self.healthStore else {return}
        
        do {
            
            try await healthStore.requestAuthorization(toShare: [], read: [stepType])
            
        } catch {
            lastError = error
        }
    }
    }




import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
