import PlaygroundSupport
import Foundation

/*:
 # Insulin Pump Simulator
 ### An insulin pump is responsible for continuously delivering insulin to people with diabetes, as their body cannot produce insulin on its own.
 
 > Use this interactive insulin pump simulator to learn about the purpose of an insulin pump, and to administer insulin by adjusting bolus and basal amounts.
 To learn more about each feature of the insulin pump, press on the "ℹ︎" button at the top right of every screen.
 
 Current insulin pumps are bulky and have many physical hardware buttons with no touchscreen. This Playground is an attempt to modernise the insulin pump by designing one with a touchscreen that's intuitive and serves the primary purpose of an insulin pump - ensuring the person wearing it can administer insulin when they need to.
 */
PlaygroundPage.current.liveView = MainView()
