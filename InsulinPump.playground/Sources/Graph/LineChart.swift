//
//  LineGraph.swift
//  HeartMonitor
//
//  Created by Zachary Simone on 17/11/17.
//  Copyright © 2017 Zachary Simone. All rights reserved.
//

import Foundation
import UIKit

/* The code in this class was adapted from the following blog post */
/* https://medium.com/@tstenerson/lets-make-a-line-chart-in-swift-3-5e819e6c1a00 */

class LineChart: UIView {
    
    let lineLayer = CAShapeLayer()
    let circlesLayer = CAShapeLayer()
    
    var chartTransform: CGAffineTransform?
    
    var chartContext: CGContext?
    
    @IBInspectable var lineColor: UIColor = UIColor.white {
        didSet {
            lineLayer.strokeColor = lineColor.cgColor
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1
    
    @IBInspectable var showPoints: Bool = true { // Show the circles on each data point
        didSet {
            circlesLayer.isHidden = !showPoints
        }
    }
    
    @IBInspectable var circleColor: UIColor = UIColor.white {
        didSet {
            circlesLayer.fillColor = circleColor.cgColor
        }
    }
    
    @IBInspectable var circleSizeMultiplier: CGFloat = 3
    
    @IBInspectable var axisColor: UIColor = UIColor.white
    @IBInspectable var showInnerLines: Bool = true
    @IBInspectable var labelFontSize: CGFloat = 10
    
    var axisLineWidth: CGFloat = 1
    var deltaX: CGFloat = 180 // The change between each tick on the x axis
    var deltaY: CGFloat = 2 // and y axis
    var xMax: CGFloat = 180
    var yMax: CGFloat = 12
    var xMin: CGFloat = 0
    var yMin: CGFloat = 2
    
    var data: [CGPoint]?
    
    var displayLabel = NSString()
    
    // MARK: Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        combinedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        combinedInit()
    }
    
    func combinedInit() {
        layer.addSublayer(lineLayer)
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineColor.cgColor
        
        layer.addSublayer(circlesLayer)
        circlesLayer.fillColor = circleColor.cgColor
        
        layer.borderWidth = 0 // Set to zero because we don't want a border on the graph
        layer.borderColor = axisColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineLayer.frame = bounds
        circlesLayer.frame = bounds
        
        if let d = data {
            setTransform(minX: xMin, maxX: xMax, minY: yMin, maxY: yMax)
            plot(d)
        }
    }
    
    func setAxisRange(forPoints points: [CGPoint]) {
        guard !points.isEmpty else { return }
        
        let xs = points.map() { $0.x }
        let ys = points.map() { $0.y }
        
        xMax = ceil(xs.max()! / deltaX) * deltaX
        yMax = ceil(ys.max()! / deltaY) * deltaY
        xMin = 0
        yMin = 0
        setTransform(minX: xMin, maxX: xMax, minY: yMin, maxY: yMax)
    }
    
    func setAxisRange(xMin: CGFloat, xMax: CGFloat, yMin: CGFloat, yMax: CGFloat) {
        self.xMin = xMin
        self.xMax = xMax
        self.yMin = yMin
        self.yMax = yMax
        
        setTransform(minX: xMin, maxX: xMax, minY: yMin, maxY: yMax)
    }
    
    func setTransform(minX: CGFloat, maxX: CGFloat, minY: CGFloat, maxY: CGFloat) {
        
        let xLabelSize = "\(Int(maxX))".size(withSystemFontSize: labelFontSize)
        
        let yLabelSize = "\(Int(maxY))".size(withSystemFontSize: labelFontSize)
        
        let xOffset = xLabelSize.height + 2
        let yOffset = yLabelSize.width + 14
        
        let xScale = (bounds.width - yOffset - xLabelSize.width/2 - 2)/(maxX - minX) * 0.95
        let yScale = (bounds.height - xOffset - yLabelSize.height/2 - 2)/(maxY - minY) * 0.9
        
        chartTransform = CGAffineTransform(a: xScale, b: 0, c: 0, d: -yScale, tx: yOffset, ty: bounds.height - xOffset)
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), let t = chartTransform else { return }
        chartContext = context
        drawAxes(in: context, usingTransform: t)
    }
    
    func drawAxes(in context: CGContext, usingTransform t: CGAffineTransform) {
        
        context.saveGState()
        
        let thickerLines = CGMutablePath()
        let thinnerLines = CGMutablePath()
        
        let xAxisPoints = [CGPoint(x: xMin, y:0), CGPoint(x: xMax, y:0)]
        let yAxisPoints = [CGPoint(x: 0, y: yMin), CGPoint(x: 0, y: yMax)]
        
        thickerLines.addLines(between: xAxisPoints, transform: t)
        thickerLines.addLines(between: yAxisPoints, transform: t)
        
        for x in stride(from: xMin, through: xMax, by: deltaX) {
            
            if x != xMin && x != xMax {
                // Divide Int(x) by 60 to get time elapsed in minutes
                let label = "\(Int(x/60))" as NSString // Int to get rid of the decimal, NSString to draw
                let labelSize = "\(Int(x/60))".size(withSystemFontSize: labelFontSize)
                let labelDrawPoint = CGPoint(x: x, y: 0).applying(t)
                    .adding(x: -labelSize.width/2)
                    .adding(y: 1)
                
                label.draw(at: labelDrawPoint,
                           withAttributes:
                    [NSAttributedStringKey.font: UIFont.systemFont(ofSize: labelFontSize),
                     NSAttributedStringKey.foregroundColor: axisColor])
            }
        }
        
        for y in stride(from: yMin, through: yMax, by: deltaY) {
            
            let tickPoints = showInnerLines ?
                [CGPoint(x: xMin, y: y).applying(t), CGPoint(x: xMax, y: y).applying(t)] :
                [CGPoint(x: 0, y: y).applying(t), CGPoint(x: 0, y: y).applying(t).adding(x: 5)]
            
            
            thinnerLines.addLines(between: tickPoints)
            
            if y != yMin {
                let label = "\(Int(y))" as NSString
                let labelSize = "\(Int(y))".size(withSystemFontSize: labelFontSize)
                let labelDrawPoint = CGPoint(x: 0, y: y).applying(t)
                    .adding(x: -labelSize.width - 1)
                    .adding(y: -labelSize.height/2)
                
                label.draw(at: labelDrawPoint,
                           withAttributes:
                    [NSAttributedStringKey.font: UIFont.systemFont(ofSize: labelFontSize),
                     NSAttributedStringKey.foregroundColor: axisColor])
            }
            
            // Just above the yMax, have the y-axis read, "mmol/L"
            if y == yMax {
                let label = "mmol/L" as NSString
                let labelSize = "mmol/L".size(withSystemFontSize: labelFontSize)
                
                let labelDrawPoint = CGPoint(x: 4, y: y + 12).applying(t)
                    .adding(x: -labelSize.width)
                    .adding(y: -labelSize.height/2)
                
                label.draw(at: labelDrawPoint,
                           withAttributes:
                    [NSAttributedStringKey.font: UIFont.systemFont(ofSize: labelFontSize),
                     NSAttributedStringKey.foregroundColor: axisColor])
            }
        }
        
        context.setStrokeColor(axisColor.cgColor)
        context.setLineWidth(axisLineWidth)
        context.addPath(thickerLines)
        context.strokePath()
        
        context.setStrokeColor(axisColor.withAlphaComponent(0.5).cgColor)
        context.setLineWidth(axisLineWidth/2)
        context.addPath(thinnerLines)
        context.strokePath()
        
        context.restoreGState()
    }
    
    func plot(_ points: [CGPoint]) {
        lineLayer.path = nil
        circlesLayer.path = nil
        data = nil
        
        guard !points.isEmpty else { return }
        
        self.data = points
        
        if self.chartTransform == nil {
            setAxisRange(forPoints: points)
        }
        
        let linePath = CGMutablePath()

        linePath.addLines(between: points, transform: chartTransform!) // Show lines between the data points
        
        lineLayer.path = linePath
        
        if showPoints {
            circlesLayer.path = circles(atPoints: points, withTransform: chartTransform!)
        }
    }
    
    func circles(atPoints points: [CGPoint], withTransform t: CGAffineTransform) -> CGPath {
        
        let path = CGMutablePath()
        let radius = lineLayer.lineWidth * circleSizeMultiplier/2
        for i in points {
            let p = i.applying(t)
            let rect = CGRect(x: p.x - radius, y: p.y - radius, width: radius * 2, height: radius * 2)
            path.addEllipse(in: rect)
        }
        
        return path
    }
}
