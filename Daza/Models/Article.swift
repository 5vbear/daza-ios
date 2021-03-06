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

//import RealmSwift
import ObjectMapper

class Article: Model {
    
    var user_id: Int!           // 用户Id
    var topic_id: Int!          // 主题Id
    var guid: String!           // 文章唯一标识符
    var type: String!           // 类型
    var link: String!           // 文章链接
    var title: String!          // 标题
    var summary: String!        // 摘要
    var content: String!        // 内容
    var image_url: String!      // 图片网址
    var audio_url: String!      // 音频网址
    var video_url: String!      // 视频网址
    var author: String!         // 作者
    var author_email: String!   // 作者邮箱
    var author_link: String!    // 作者链接
    var source: String!         // 来源
    var source_link: String?    // 来源链接
    var view_count: Int = 0     // 阅读数
    var like_count: Int = 0     // 喜欢数
    var comment_count: Int = 0  // 评论数
    var published_at: NSDate!   // 发表时间
    var user: User!
    var topic: Topic!
    var tags: [ArticleTag]!
    
    override init() {
        super.init()
    }

    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        guid            <- map["guid"]
        user_id         <- map["user_id"]
        topic_id        <- map["topic_id"]
        type            <- map["type"]
        link            <- map["link"]
        title           <- map["title"]
        summary         <- map["summary"]
        content         <- map["content"]
        image_url       <- map["image_url"]
        audio_url       <- map["audio_url"]
        video_url       <- map["video_url"]
        author          <- map["author"]
        author_email    <- map["author_email"]
        author_link     <- map["author_link"]
        source          <- map["source"]
        source_link     <- map["source_link"]
        view_count      <- map["view_count"]
        like_count      <- map["like_count"]
        comment_count   <- map["comment_count"]
        published_at    <- (map["published_at"], self.dateFormatterTransform)
        user            <- map["user"]
        topic           <- map["topic"]
        tags            <- map["tags"]
    }
    
    var sharingContent: [AnyObject] {
        get {
            let contentURL         = NSURL(string: "\(URLs.webURL)/articles/\(self.id)")!   // 要分享的链接
            let contentTitle       = "[daza.io] \(self.title)"                              // 表示链接中的内容的标题
//            let imageURL           = self.image_url                                         // 在帖子中显示的缩略图的网址
//            let contentDescription = self.summary                                           // 内容的描述，通常为 2-4 个句子
            return [contentTitle, contentURL];
        }
    }
    
}