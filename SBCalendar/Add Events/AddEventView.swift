//
//  AddEventView.swift
//  SBCalendar
//
//  Created by Promobi on 01/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class AddEventView: UIView {

    @IBOutlet weak var agendaTextField: UITextField!
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var participantsTextView: UITextView!
    @IBOutlet weak var participantsTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    @IBOutlet weak var dateAndTimePickerContainer: UIView!
    @IBOutlet weak var dateAndTimePickerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dateAndTimePickerTopConstraint.constant = 0
    }

    @IBAction func didChangeSelectedDateOrTime(_ sender: UIDatePicker) {
        if sender.datePickerMode == .date {
            let date = sender.date
            self.dateTextField.text = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
        } else if sender.datePickerMode == .time {
            let date = sender.date
            self.timeTextField.text = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
        }
    }

    @IBAction func didEndSelectingDateAndTime(_ sender: UIDatePicker) {
        print(sender.date)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dateAndTimePickerTopConstraint.constant = 0
        self.participantsTextView.text = nil
        participantsTextView.textContainerInset = UIEdgeInsets.zero
        participantsTextView.textContainer.lineFragmentPadding = 0
        participantsTextViewHeightConstraint.constant = 0
    }
}

extension AddEventView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            self.dateAndTimePickerTopConstraint.constant = -self.dateAndTimePicker.frame.height
            self.dateAndTimePicker.datePickerMode = .date
            self.dateAndTimePicker.minimumDate = Date()
            return false
        } else if textField.tag == 4 {
            self.dateAndTimePickerTopConstraint.constant = -self.dateAndTimePicker.frame.height
            self.dateAndTimePicker.datePickerMode = .time
            self.dateAndTimePicker.minimumDate = Date()
            return false
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            if let enteredText = textField.text, enteredText.isEmpty == false {
                if enteredText.isValidEmail() {
                    if self.participantsTextView.text.isEmpty == false {
                        self.participantsTextView.text.append(", \(enteredText)")
                    } else {
                        self.participantsTextView.text = enteredText
                    }
                    textField.text = nil
                    participantsTextViewHeightConstraint.constant = participantsTextView.contentSize.height
                } else {
                    return false
                }
            }
        }
        self.endEditing(true)
        return true
    }
}
