//
//  ViewController.swift
//  SampleCVCalendar
//
//  Created by 一騎高橋 on 2016/10/07.
//  Copyright © 2016年 IkkiTakahashi. All rights reserved.
//

import UIKit
import CVCalendar

class ViewController: UIViewController {

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var eventTableContainerView: UIView!
    
    struct Color {
        static let selectedText = UIColor.white
        static let text = UIColor.black
        static let textDisabled = UIColor.gray
        static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
        static let sundayText = UIColor.red
        static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
        static let sundaySelectionBackground = sundayText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = getDescriptionOfJa(date: CVDate(date: Date()))
        
        if (self.childViewControllers.count > 0) {
            let vc = self.childViewControllers[0] as! EventViewController
            vc.settingAndReloadContent(count: CVDate(date: Date()).day - 1)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // これをしないと、Todayの上にだけマーカーが表示されてしまいます。
        calendarView.contentController.refreshPresentedMonth()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func getDescriptionOfJa(date: CVDate) -> String {
        return "\(date.year)年  \(date.month)月"
    }
}

extension ViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate
{
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return self.getWeekColor(weekDay: weekday)
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        return [UIColor.red]
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        return true
    }
 
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        if self.navigationItem.title != self.getDescriptionOfJa(date: date) {
            self.navigationItem.title = self.getDescriptionOfJa(date: date)
        }
        
        if (self.childViewControllers.count > 0) {
            let vc = self.childViewControllers[0] as! EventViewController
            vc.settingAndReloadContent(count: date.day - 1)
        }
        
    }
    
    func dayOfWeekTextUppercase() -> Bool {
        return false
    }
    
    // My Definiton
    // 日曜日なら日曜日用の色を返す
    func getWeekColor(weekDay: Weekday) -> UIColor {
        return weekDay == .sunday ? Color.sundayText : Color.text
    }
}

extension ViewController: CVCalendarViewAppearanceDelegate
{
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return true
    }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
            case (_, .selected, _), (_, .highlighted, _): return Color.selectedText
            case (.sunday, .in, _): return Color.sundayText
            case (.sunday, _, _): return Color.sundayTextDisabled
            case (_, .in, _): return Color.text
            default: return Color.textDisabled
        }
    }
    
}
