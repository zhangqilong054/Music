@Entry
@Component
struct Splash {

  @State n:number=3
  private timerId:number=-1

  aboutToAppear(): void {
    console.log("aboutToAppear")
  }
  onPageShow():void{
    console.log("onPageShow")
    if (this.timerId !== -1) {
      return
    }
    this.timerId=setInterval(()=>{
      this.n--;
      console.log("this.n :"+this.n);
      if(this.n<=0){
        this.clearTimer()
        this.jumpToHome();
      }
    },1000)
  }
  aboutToDisappear():void{
    this.clearTimer()
  }
  clearTimer():void{
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }
  jumpToHome(){
    this.clearTimer()
    this.getUIContext().getRouter().replaceUrl({url:"pages/Home"})
  }
  build() {
    Stack({alignContent:Alignment.TopEnd}) {
      Image($r("app.media.ad"))
        .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])
      Text("跳过("+this.n+")")
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .borderRadius('50%')
        .padding({
          top:8,
          bottom:8,
          left:16,
          right:16
        })
        .margin({
          top:15,
          right:25
        })
        .onClick(()=>{
          this.jumpToHome();
        })
    }
  }
}