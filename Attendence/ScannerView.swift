//
//  ContentView.swift
//  Attendence
//
//  Created by Hlwan Aung Phyo on 11/12/24.
//

import SwiftUI

final class ScannerViewModel:ObservableObject {
    @Published var nfcData:NFCData? = nil
    var nfcManager:NFCManager
    
    init(){
        nfcManager = NFCManager()
        nfcManager.onCardDataUpdate = {[weak self] nfcData in
            DispatchQueue.main.async {
                self?.nfcData = nfcData
            }
        }
    }
    
    
    func scan(){
        nfcManager.scan()
    }
}
enum customColors{
    static let shadowColor = Color(red: 1/255, green: 26/255, blue: 25/255)
    static let backgroundColor = Color(red: 192 / 255.0, green: 224 / 255.0, blue: 206 / 255.0)
    static let darkGreen = Color(red: 7 / 255.0, green: 112 / 255.0, blue: 63 / 255.0)
    static let lightGray = Color(red: 217 / 255.0, green: 217 / 255.0, blue: 217 / 255.0)
}

struct ScannerView: View {
    @ObservedObject var vm = ScannerViewModel()
    var body: some View {
        ZStack{
            customColors.backgroundColor.ignoresSafeArea()
            VStack {
                
                HStack{
                    VStack(alignment:.leading){
                        Text("日本電子専門学校")
                            .font(.system(size: 24, weight: .semibold))
                        Text("学生情報")
                            .font(.system(size: 13, weight: .thin))
                    }
                    .padding(.leading,36)
                    Spacer()
                    Button {
                        print("logout")
                    } label: {
                        Image(.menu)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding(.trailing)
                    }
                }
                Spacer()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(customColors.lightGray)
                        .frame(width:300,height:450)
                        .shadow(color: customColors.shadowColor,radius: 10,x:10,y:10)

                    VStack{
                        AsyncImage(url: URL(string: "https://www.japanese-specialty-school.com/images/logo.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        .padding(.bottom,40)
                        
                        VStack(alignment:.leading){
                            Text("ラワンアウンピョウ")
                                .font(.system(size: 24, weight: .bold))
                            Text("24CM0138")
                                .font(.system(size: 13, weight: .medium))
                            Text("モバイルアプリケーション開発科")
                                .font(.system(size: 13, weight: .medium))

                        }
                        .padding(.bottom,150)
                    
                        

                    }

                }
                    

                
                Spacer()
                
                Button {
                    vm.scan()
                } label: {
                    HStack{
                        Image(systemName: "wifi")
                            .font(.title)
                            .padding(.leading)
                        Text("Scan")
                            .padding(.trailing)
                    }
                    .foregroundStyle(Color.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue)
                    .cornerRadius(10)
                }

            }
            .padding()
        }
    }
}


//view の定義
extension ScannerView{
    private var backgroundView:some View{
        VStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(customColors.darkGreen)
                .frame(width:407,height: 10)
                .rotationEffect(.degrees(45))
                .offset(x:100)

            RoundedRectangle(cornerRadius: 10)
                .fill(customColors.darkGreen)
                .frame(width:700,height: 58)
                .rotationEffect(.degrees(45))
        }
    }
}

#Preview {
    ScannerView()
}
