interface UserInfo {
  name: string
  location: string
  years: string
  category: string
  followers: string
  fans: string
  likes: string
}

@Component
export struct Mine{
  private userInfo: UserInfo = {
    name: '云音乐',
    location: '北京',
    years: '18年',
    category: '歌铃',
    followers: '1',
    fans: '100万',
    likes: '1.67亿'
  }
  build(){
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        Image($r('app.media.bg_mine'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)

        Image($r('app.media.logo'))
          .width(120)
          .height(120)
          .margin({ bottom: 20 })
      }
      .width('100%')
      .height('70%')
      // 软件名称
      Text(this.userInfo.name)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 15 })
        .fontColor(Color.White)

      // 用户基本信息
      Row() {
        Text(`${this.userInfo.category} 00后 ${this.userInfo.location} ${this.userInfo.years}`)
          .fontSize(14)
          .fontColor('#515152')
      }
      .margin({ bottom: 20 })

      // 账户信息
      Row() {
        Row() {
          Text(this.userInfo.followers)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#515152')
            .margin({ right: 4 })
          Text('关注')
            .fontSize(14)
            .fontColor('#515152')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        Row() {
          Text(this.userInfo.fans)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#515152')
            .margin({ right: 4 })
          Text('粉丝')
            .fontSize(14)
            .fontColor('#515152')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        Row() {
          Text(this.userInfo.likes)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#515152')
            .margin({ right: 4 })
          Text('获赞')
            .fontSize(14)
            .fontColor('#515152')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')

  }
}

export default Mine;