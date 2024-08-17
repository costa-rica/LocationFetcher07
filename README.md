# LocationFetcher07

![LocationFetcherIcon](https://nick-rodriguez.info/media/LocationFetcher_07_no_alpha_small.png)

## Overview
This application demonstrates how to manage the `CLLocationManager` for collecting location data in different states, including background and terminated states.


## Features
- Tracks locations using three distinct methods of `CLLocationManager`.
- Visualizes different collected locations in a table.
- Monitors app state changes to correlate with location data.

## Methods for Location Management

### Method: `startUpdatingLocation()`
- Provides continuous location updates.
- Stops when the app is terminated.
- Can work in the background.
- High battery consumption.
- **Continuous**: Starts updating location and continuously sends updates via the delegate.
- **Synchronous**: Continuously runs until stopped.

### Method: `startMonitoringSignificantLocationChanges()`
- Tracks significant location changes.
- Works even when the app is terminated.
- Moderate battery usage.
- **Continuous**: Monitors significant location changes and sends updates via the delegate.
- **Asynchronous**: Acts as an event trigger for significant changes.

### Method: `requestLocation()`
- Fetches the location once and then stops.
- Does not work when the app is terminated.
- Minimal battery usage.
- **Asynchronous**: Requests the location once and calls the delegate method upon completion.
- Suitable for one-time location requests.

## Additional Features
- **AppStateMonitor**: Tracks app states to create a table in `DashboardVC` displaying the collected locations with different colors. 
    - Helps verify if the app is collecting location data as expected.
    - Time stamps verify if the data matches the expected app state.

## Project Setup
- All setup and UI are handled programmatically.
- No usage of `Main.storyboard`.
- Scene configuration managed in `SceneDelegate.swift`.

## Files and Structure
- **LocationFetcher.swift**: Main logic for handling location data collection.
- **MiscUtils.swift**: Utility functions used across the application.
- **DemoSwitchView.swift**: UI for toggling location management methods.
- **DashboardVC.swift**: Displays collected location data with visual indicators.
- **HomeVC.swift**: Main interface for starting/stopping location data collection.
- **AppDelegate.swift**: Standard app delegate configurations.
- **SceneDelegate.swift**: Modified to handle scene connections programmatically.

## How to Use
1. Clone the repository.
2. Open in Xcode.
3. Run the application on an iOS simulator or device.
4. Use the UI to start/stop location data collection via different methods.

## Future Enhancements
- Add more granular control over location updates.
- Improve UI/UX for better user feedback.
- Store location data more securely.


