//  /*
//
//  Project: OTP Verification
//  File: OTPVerificationView.swift
//  Created by: Elaidzha Shchukin
//  Date: 30.04.2023
//
//  Satatus
//
//  */

import SwiftUI

struct OTPVerificationView: View {
    
    @State var otpText: String = ""
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        
        VStack{
            Text("Код подтверждения")
                .font(.custom("Inter-Medium", size: 28))
                .foregroundColor(
                    Color.gray
                )
                .padding()
            
            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) {index in
                    OTPTextBox(index)
                }
            }
            .background(content: {
                TextField("", text: $otpText.limit(4))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
            })
            .containerShape(Rectangle())
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
            
            TextField("", text: $otpText)
            
            Button {
                //action
            } label: {
                Text("Изменить номер")
                    .font(.custom("Inter-Medium", size: 11))
                    .foregroundColor(
                        Color.red
                    )
            }
            .disabledWithOpacity(otpText.count < 4)
            
        }
    }
    
    @ViewBuilder
   func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            } else {
                Text("")
            }
        }
        .frame(width: 40, height: 40)
        .background (
            Rectangle()
                .frame(height: 1)
            //.stroke(.blue, lineWidth: 1)
        )
        .frame(maxWidth: .infinity)
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
            AutoOTP()
    }
}

extension View {
    func disabledWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.4 : 1)
    }
}

extension Binding where Value == String  {
    func limit(_ lenght: Int) -> Self  {
        if self.wrappedValue.count > lenght {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(lenght))
            }
        }
        return self
    }
}
