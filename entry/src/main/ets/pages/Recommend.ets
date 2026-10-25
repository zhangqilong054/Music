


interface recommendDailyType {
  img: string
  title: string
  type:string
  top:string
  bottom: string
}
interface recommendListType {
  img: string
  title: string
  count:string
}
@Component
export struct Recommend {
  /**轮播图数据*/
  swiperList: string[] = [
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner1.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner2.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner3.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner4.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner5.png"
  ]
  /**每日推荐数据*/
  dailyRecommend: recommendDailyType[] = [
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      type: '每日推荐',
      top: '#660000',
      bottom: '#382e2f'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend2.png',
      title: '从 [Nothing on Me] 开启无限漫游',
      type: '私人漫游',
      top: '#382e2f',
      bottom: '#a37862'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend3.png',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      type: '华语流行',
      top: '#a37862',
      bottom: '#174847'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend4.png',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      type: '私人雷达',
      top: '#174847',
      bottom: '#174847'
    }
  ]
  /**推荐歌单数据*/
  recommendList: recommendListType[] = [
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list1.jpg',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      count: '270.9万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list2.jpg',
      title: 'Yasuo和更多好听的 | 华语私人雷达 | 回忆8090',
      count: '476.1万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list3.jpg',
      title: 'Trap Remix丨当欧美热单遇上毒性低音',
      count: '186.3万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list4.jpg',
      title: '满级人类进化之路必备BGM | 根本停不下来',
      count: '186.3万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list5.jpg',
      title: '认真去聆听这个世界的每一分每一秒 (强烈推荐)',
      count: '362.8万'
    }
  ]

  /**搜索框*/
  @Builder
  searchBarBuilder() {
    Row() {
      Image($r('app.media.ic_search'))
        .width(20)
        .height(20)
        .fillColor(Color.Gray)
      TextInput({ placeholder:'搜索...' })
        .placeholderColor('#817D83')
        .layoutWeight(1)
      Image($r('app.media.ic_code'))
        .width(20)
        .height(20)
        .fillColor(Color.Gray)
    }
    .width('100%')
    .padding(12)
    .borderRadius('60')
    .backgroundColor('#FF2D2A2A')
    .justifyContent(FlexAlign.SpaceBetween)
  }
  /**轮播图*/
  @Builder
  swiperBuilder(){
    Swiper() {
      ForEach(this.swiperList, (imgUrl:string,index:number) => {
        Row() {
          Image(imgUrl)
            .width('100%')
            .height('100%')
        }
        .borderRadius(20)
        .clip(true)
      })
    }
    .height(200)
    .autoPlay(true)
    .loop(true)
    .margin({
      top:15,
    })
  }
  /**标题*/
  @Builder
  titleBuilder(title:string){
    Row(){
      Text(title)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bolder)
        .fontSize(18)
      Image($r('app.media.ic_more'))
        .width(20)
        .height(20)
        .fillColor(Color.White)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({
      top:15
    })
  }
  /**每日推荐*/
  @Builder
  dailyBuilder() {
    List() {
      ForEach(this.dailyRecommend, (item: recommendDailyType, index: number) => {
        ListItem() {
          Column() {
            Text(item.type)
              .backgroundColor(item.top)
              .width('100%')
              .height(40)
              .padding({ left: 10 })
              .fontColor(Color.White)
            Image(item.img)
              .width('100%')
            Text(item.title)
              .fontColor(Color.White)
              .backgroundColor(item.bottom)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .padding(5)
          }
          .width('40%')
          .borderRadius(4)
          .clip(true)
          .margin({ right: 10 })
        }
      }, (item: recommendDailyType, index: number) => index.toString())  // 加上 key
    }
    .listDirection(Axis.Horizontal)
    .height(230)          // 固定高度很重要
    .scrollBar(BarState.Off)
    .margin({ top: 15 })
  }

  /**推荐歌单*/
  @Builder
  musicBuilder() {
    List() {
      ForEach(this.recommendList, (item: recommendListType, index: number) => {
        ListItem() {
          Column() {
            Stack({ alignContent: Alignment.TopStart }) {
              Image(item.img)
                .width('100%')
                .height(100)
                .borderRadius(8)
              Text(item.count)
                .fontColor(Color.White)
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .margin(5)
            }
            Text(item.title)
              .fontColor(Color.White)
              .fontSize(14)
              .width('100%')
              .padding(5)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .width('30%')
          .margin({ right: 10 })
        }
      }, (item: recommendListType, index: number) => index.toString())
    }
    .listDirection(Axis.Horizontal)
    .height(180)          // 根据实际内容微调
    .scrollBar(BarState.Off)
    .margin({ top: 10 })
  }

  build() {
    Scroll() {
      Column() {
        this.searchBarBuilder()
        this.swiperBuilder()
        this.titleBuilder('每日推荐')
        this.dailyBuilder()
        this.titleBuilder('推荐歌单')
        this.musicBuilder()
      }
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

export default Recommend;