/**
 * Copyright (C) 2015 JianyingLi <lijy91@foxmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import Eureka

class HomeMineController: BaseGroupedListController {

    var menuNotifications: UIBarButtonItem?
    var menuSettings: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("home.mine.title")

        self.menuNotifications = UIBarButtonItem(image: UIImage(named: "ic_menu_notifications"), style: .Plain, target: self, action: #selector(notificationsButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = self.menuNotifications

        self.menuSettings = UIBarButtonItem(image: UIImage(named: "ic_menu_settings"), style: .Plain, target: self, action: #selector(settingsButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSettings

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginStatusChanged(_:)), name: "LoginStatusChangedEvent", object: nil)

        form
            +++ Section()
                <<< LabelRow() { row in
                        row.tag = "avatarRow"
                        row.cellStyle = UITableViewCellStyle.Subtitle
                        row.title = "未登录"
                    }.cellUpdate { (cell, row) in
                        cell.height =  { 60 }
                        cell.detailTextLabel?.text = "查看或编辑个人资料"
                        cell.imageView!.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: "placeholder_image"))
                    }
            +++ Section()
                <<< ButtonRow() { row in
                        row.title = "维护的主题"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.title = "维护的主题"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.title = "赞过的文章"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.title = "收藏的文章"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }
    }

    func notificationsButtonPressed(sender: UIBarButtonItem) {
        if (!Auth.check(self)) {
            return
        }
        let controller = NotificationsController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func settingsButtonPressed(sender: UIBarButtonItem) {
        let controller = SettingsController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func nameButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = UserDetailController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func modifyProfileButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = ModifyProfileController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func followingButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = FollowingController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func followersButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = FollowersController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // 我的问题列表发生变化
    @objc func loginStatusChanged(notification: NSNotification) {
    }

}
