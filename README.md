# Uber-Assignment

# FlickrSearch for iOS

## Prereqs

- Xcode 10.0
- iOS 11+

## Running

1. Open `FlickrSearch.xcodeproj` from the root directory of the repo in Xcode.
2. Press the "Play" button in the top left or press command-r.

## Overall Architecture 

App is based on **MVVM** architecture. 

1. **Network** : contains group of classes for network access.
2. **ViewModel** : includes classes that are responsible for interacting with the view and network.
3. **Model** : contains all model objects for the app. All of the model classes implements `Codable` protocol available in Swift 4.
4. **Extensions** : Implemented UIImageView Extension for async image download and cache based on URL.

## Unit tests

Unit tests are written for network Request only.
