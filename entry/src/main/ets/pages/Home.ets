import { Find } from './Find'
import { Mine } from './Mine'
import { Moment } from './Moment'
import { Recommend } from './Recommend'

class TabClass {
  text: string = ''
  name: string = ''
  icon: ResourceStr = ''
}

@Entry
@Component
struct Layout {

  @State
  tabsData: TabClass[] = [
    { text: '推荐', icon: $r('app.media.ic_recommend'), name:'recommend' },
    { text: '发现', icon: $r('app.media.ic_find'), name:'find' },
    { text: '动态', icon: $r('app.media.ic_moment'), name:'moment' },
    { text: '我的', icon: $r('app.media.ic_mine'), name:'mine' }
  ]

  @State active:string='recommend'

  @Builder
  tabBuilder(item: TabClass) {
    Column({ space: 5 }) {
      Image(item.icon)
        .width(24)
        .fillColor(this.active == item.name ? '#E85A88' : '#63AAAA')
      Text(item.text)
        .fontSize(14)
        .fontColor(this.active == item.name ? '#E85A88' : '#63AAAA')
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      ForEach(this.tabsData, (item: TabClass, index: number) => {
        TabContent() {
          if (item.name === "recommend") {
            Recommend()
          } else if (item.name === "find") {
            Find()
          } else if (item.name === "moment") {
            Moment() 
          } else if (item.name === "mine") {
            Mine()
          }
        }.tabBar(this.tabBuilder(item))
        .backgroundColor('#131215')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      })
    }
    .onChange((i) => {
      this.active = this.tabsData[i].name
    })
    .scrollable(false)
    .animationDuration(0)
    .barBackgroundColor('#383f42')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

  }
}