//
//  ContentView.swift
//  Onboarding
//
//  Created by Raphael Cerqueira on 22/03/21.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {}, label: {
                    Text("Skip")
                        .foregroundColor(selectedIndex != content.count - 1 ? Color(#colorLiteral(red: 0.1951392889, green: 0.1309193373, blue: 0.4449608624, alpha: 1)) : Color.clear)
                })
                .disabled(selectedIndex == content.count - 1)
            }
            .padding(.horizontal)
            
            TabView(selection: $selectedIndex) {
                ForEach(0..<content.count) { index in
                    PageContentView(item: content[index])
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: selectedIndex, perform: { value in
                updateProgress()
            })
            .frame(height: 380)
            .padding(.top)
            .clipped()
            
            Spacer(minLength: 15)
            
            HStack(spacing: 12) {
                ForEach(0..<content.count) { index in
                    Capsule()
                        .foregroundColor(selectedIndex == index ? Color(#colorLiteral(red: 0.1951392889, green: 0.1309193373, blue: 0.4449608624, alpha: 1)) : Color.gray)
                        .frame(width: selectedIndex == index ? 16 : 8, height: 8)
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                if selectedIndex < content.count - 1 {
                    withAnimation {
                        selectedIndex += 1
                    }
                }
            }, label: {
                CircularProgress(progress: $progress)
            })
        }
        .onAppear() {
            updateProgress()
        }
    }
    
    func updateProgress() {
        withAnimation {
            progress = CGFloat(selectedIndex + 1) / CGFloat(content.count)
        }
    }
}

struct PageContentView: View {
    var item: PageContent
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(item.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 0.1951392889, green: 0.1309193373, blue: 0.4449608624, alpha: 1)))
                .padding(.top)
            
            Text(item.description)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
        }
    }
}

struct CircularProgress: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        Image(systemName: "arrow.right")
            .font(.system(size: 35))
            .foregroundColor(Color.white)
            .frame(width: 90, height: 90)
            .background(Color(#colorLiteral(red: 0.9566304088, green: 0.1984194815, blue: 0.5552698374, alpha: 1)))
            .clipShape(Circle())
            .padding()
            .background(Circle().strokeBorder(Color.gray.opacity(0.3), lineWidth: 2))
            .background(Circle().trim(from: 0, to: self.progress).stroke(Color(#colorLiteral(red: 0.9566304088, green: 0.1984194815, blue: 0.5552698374, alpha: 1)), lineWidth: 5).rotationEffect(.degrees(-90)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
