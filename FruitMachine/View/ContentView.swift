//
//  ContentView.swift
//  FruitMachine
//
//  Created by 刘铭 on 2023/1/15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animatingSymbol = false
    @State private var showingInfoView: Bool = false
    @State private var animationModel = false
    @State private var showingModel = false
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var coinsAmount: Int = 10
    @State private var isActive10 = true
    let symbols = ["草莓","柠檬","牛油果","百香果","葡萄"]
    @State private var reels: Array = [0,1,2]
    
    func spinReels(){
        reels = reels.map{
            _ in Int.random(in: 0...symbols.count - 1)
        }
    }
    
    func checkWinning(){
        if reels[0] == reels[1] && reels[1] == reels[2]{
            playerWin()
            if coins > highScore{
                newHightScore()
            }
        }else{
            playerLoses()
        }
    }
    
    func playerWin(){
        coins += coinsAmount * 10
    }
    
    func newHightScore(){
        highScore = coins
        UserDefaults.standard.set(highScore,forKey: "HighScore")
    }
    func playerLoses(){
        coins -= coinsAmount
    }
    func activate10(){
        coinsAmount = 10
        isActive10 = true
    }
    
    func activate20(){
        coinsAmount = 20
        isActive10 = false
    }
    
    func isGameOver(){
        if coins <= 0{
            showingModel = true
        }
    }
    func resetGame(){
        UserDefaults.standard.set(0,forKey: "HighScore")
        highScore = 0
        coins = 100
        activate10()
    }
    
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"),Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center,spacing: 5, content: {
                // MARK: - Header
                LogoView()
                Spacer()
                // MARK: - Score
                HStack{
                    HStack{
                        Text("你的\n分数")
                            .scoreLableStyle()
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    
                    HStack{
                        Text("最高\n分数")
                            .scoreLableStyle()
                            .multilineTextAlignment(.leading)
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                Spacer()
                // MARK: - FrutiMachine
                VStack(alignment: .center,spacing: 0, content: {
                    ZStack{
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1: 0)
                            .offset(y: animatingSymbol ? 0: -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear(){
                                self.animatingSymbol.toggle()
                            }
                    }
                    HStack(alignment: .center,spacing: 0, content: {
                        ZStack{
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1: 0)
                                .offset(y: animatingSymbol ? 0: -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(){
                                    self.animatingSymbol.toggle()
                                }
                        }
                        Spacer()
                        ZStack{
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1: 0)
                                .offset(y: animatingSymbol ? 0: -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                .onAppear(){
                                    self.animatingSymbol.toggle()
                                }
                        }
                    })
                    .frame(maxWidth: 500)
                    Button(action: {
                        withAnimation(){
                            self.animatingSymbol = false
                        }
                        self.spinReels()
                        withAnimation(){
                            self.animatingSymbol = true
                        }
                        self.checkWinning()
                        self.isGameOver()
                    }, label: {
                        Image("拉杆")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    })
                })
                .layoutPriority(2)
                // MARK: - Footer
                Spacer()
                HStack{
                    HStack(alignment: .center,spacing: 10, content: {
                        Button(action: {
                            activate20()
                        }, label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActive10 == false ? Color("ColorYellow") : .white)
                                .modifier(CoinNumberModifier())
                        })
                        .modifier(CoinCapsuleModifier())
                        Image("钱币")
                            .resizable()
                            .opacity(isActive10 == false ? 1: 0)
                            .offset(x: isActive10 == false ? 0: 20)
                            .opacity(1)
                            .modifier(CoinImageModifier())
                        
                    })
                    Spacer()
                    HStack(alignment: .center,spacing: 10, content: {
                        Image("钱币")
                            .resizable()
                            .opacity(isActive10 == true ? 1: 0)
                            .offset(x: isActive10 == true ? 0: -20)
                            .opacity(1)
                            .modifier(CoinImageModifier())
                        Button(action: {
                            activate10()
                        }, label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActive10 == true ? Color("ColorYellow") : .white)
                                .foregroundColor(.yellow)
                                .modifier(CoinNumberModifier())
                        })
                        .modifier(CoinCapsuleModifier())
                        
                        
                    })
                }
            })
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModel.wrappedValue ? 5: 0,opaque: false)
            .overlay(
                Button(action: {
                    resetGame()
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier()),alignment: .topLeading)
            .overlay(
                Button(action: {
//                    print("相关信息")
                    self.showingInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier()),alignment: .topTrailing)
            if $showingModel.wrappedValue{
                ZStack{
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0, content: {
                        Text("游戏结束")
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        Spacer()
                        VStack(alignment: .center,spacing: 16, content: {
                            Image("槽位-草莓")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("很不幸！你失去了所有的分数。\n让我们再来一次吧！")
                                .font(.body)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                        })
                        Spacer()
                        
                        Button(action: {
                            self.showingModel = false
                            self.animationModel = false
                            self.activate10()
                            self.coins = 100
                        }, label: {
                            Text("新游戏")
                                .font(.body)
                                .fontWeight(.semibold)
                                .accentColor(Color("ColorPink"))
                                .padding(.horizontal,12)
                                .padding(.vertical,8)
                                .frame(minWidth: 128)
                                .background(Capsule()
                                    .strokeBorder(lineWidth: 1.75).foregroundColor(Color("ColorPink")))
                        })
                        Spacer()
                    })
                    .frame(minWidth: 280,idealWidth: 280,maxWidth: 320,minHeight: 260,idealHeight: 280,maxHeight: 320,alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6,x: 0,y: 8)
                    .opacity(animationModel ? 1: 0)
                    .offset(y: animationModel ? 0: -100)
                    .animation(Animation.spring(response: 0.6,dampingFraction: 1.0,blendDuration: 1.0))
                    .onAppear(){
                        self.animationModel = true
                    }
                }
            }
            
        }
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
