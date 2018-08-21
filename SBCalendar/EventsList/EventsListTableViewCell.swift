//
//  EventsListTableViewCell.swift
//  SBCalendar
//
//  Created by Promobi on 02/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class EventsListTableViewCell: UITableViewCell {

    @IBOutlet weak var agendaLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var participantsEmailLabel: UILabel!

    // cell's content view's bottom equals participantsEmailLabel's top constraint + constant
    @IBOutlet weak var participantsEmailLabelBottomConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDataSource(dataSource: Event) {
        agendaLabel.text = dataSource.agenda
        timeLabel.text = dataSource.time
        var emailsString = ""
        if let participants = dataSource.participants {
            for participant in  participants.allObjects as! [Participant] {
                if emailsString.isEmpty {
                    emailsString.append(participant.email!)
                } else {
                    emailsString.append(", \(participant.email!)")
                }
            }
            participantsEmailLabel.text = emailsString
        }
        participantsEmailLabelBottomConstraint.constant = -participantsEmailLabel.frame.height+16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
