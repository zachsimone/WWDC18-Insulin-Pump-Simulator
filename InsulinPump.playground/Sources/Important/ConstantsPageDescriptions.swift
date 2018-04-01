import Foundation

extension Constants {
    enum GraphPageDescription {
        static let description = "The graph provides a general overview of blood glucose levels for the day, by syncing data from a device that measures blood glucose levels. This view also provides other relevant data to someone with diabetes going about their day - their most recent blood glucose level and their average for the day. Managing blood sugar is essential, as good control will prevent long-term issues that can arise."
    }
    
    enum BolusPageDescription {
        static let description = "Bolus insulin is delivered at irregular intervals and requires manual intervention from the wearer of an insulin pump. Bolus insulin is typically given in large quantities, usually before a meal containing carbohydrates, or when blood glucose is too high and needs to be brought down. The bolus wizard calculates required insulin based on current blood glucose, and the quantity of carbohydrate to be consumed."
    }
    
    enum BasalPageDescription {
        static let description = "An insulin pump continuously delivers insulin in small doses throughout the day - known as a 'basal' rate. This basal rate is required to keep blood glucose in check, and the dosage varies throughout the day. Sometimes it is adjusted manually; this is known as setting a temporary basal. Temporary basals are useful for shorter periods of time - such as while exercising, where one might cut their basal rate to 10%."
    }
    
    enum InfoPageDescription {
        static let description = "This page provides the most important information at a glance, and updates in real-time as someone changes their basal rate, enters a new BGL, or gives more bolus insulin.\nInsulin lasts in someone's system for approximately three hours, and the 'active insulin' figure can be useful when deciding if it's necessary to deliver more insulin when blood glucose is higher than expected."
    }
}
