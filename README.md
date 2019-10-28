#  SwiftUI Transform Sanity Checker

![Transform Viewer](/TransformSanityChecker.gif)

A simple tool written purely in swiftUI for viewing the effects of various transforms. This can either be used to help with learning the matrix operations behind transforms or for combining transforms to get a desired effect. 


## How To Use 

1. Download the project from github
2. Open in Xcode 
3. Click the Build and Run button.
4. The interface and controls are pretty self explanatory after that 

## Requirements

Built in swiftUI and the main scheme is for macOS but can easily be ported over to iOS, watchOS, etc.

* Xcode 11+ 
* macOS 10.15+


## Todo 

* Fix the path tracking so that the path animates with added transforms
* add in a reversed order path and points overlay to see the difference between the order in which transforms are applied 
* Add a Transform generator to for copying and pasting fully created transforms into another project
