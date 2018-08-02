//
//  AddEventView.swift
//  SBCalendar
//
//  Created by Promobi on 01/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

protocol AddEventViewDelegate: class {
    func saveNewEvent(eventDetails: [String: String])
}

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

    var delegate: AddEventViewDelegate?

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        updateDateAndTimeTextFields(picker: self.dateAndTimePicker)
        self.dateAndTimePickerTopConstraint.constant = 0
    }

    @IBAction func didChangeSelectedDateOrTime(_ sender: UIDatePicker) {
        updateDateAndTimeTextFields(picker: sender)
    }

    @IBAction func didEndSelectingDateAndTime(_ sender: UIDatePicker) {
        print(sender.date)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let agenda = agendaTextField.text, agenda.isEmpty == false else {
            self.showToast(message: "Please, enter agenda.")
            return
        }
        guard let participants = participantsTextView.text, participants.isEmpty == false else {
            self.showToast(message: "Please, enter participants.")
            return
        }
        guard let date = dateTextField.text, date.isEmpty == false else {
            self.showToast(message: "Please, enter event date.")
            return
        }
        guard let time = timeTextField.text, time.isEmpty == false else {
            self.showToast(message: "Please, enter event time.")
            return
        }
        let eventDict = [
            "agenda": agenda,
            "participants": participants,
            "eventDate": date,
            "eventTime": time
        ]
        self.delegate?.saveNewEvent(eventDetails: eventDict)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dateAndTimePickerTopConstraint.constant = 0
        self.participantsTextView.text = nil
        participantsTextView.textContainerInset = UIEdgeInsets.zero
        participantsTextView.textContainer.lineFragmentPadding = 0
        participantsTextViewHeightConstraint.constant = 0
    }

    // MARK: helpers
    private func updateDateAndTimeTextFields(picker: UIDatePicker) {
        if picker.datePickerMode == .date {
            let date = picker.date
            self.dateTextField.text = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
        } else if picker.datePickerMode == .time {
            let date = picker.date
            self.timeTextField.text = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
        }
    }
}

extension AddEventView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            self.endEditing(true)
            self.dateAndTimePickerTopConstraint.constant = -self.dateAndTimePicker.frame.height
            self.dateAndTimePicker.datePickerMode = .date
            self.dateAndTimePicker.minimumDate = Date()
            return false
        } else if textField.tag == 4 {
            self.endEditing(true)
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
