//
//  AddView.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 08/04/22.
//

import SwiftUI


struct AddView: View {
    @Binding var showAddView: Bool
    
    @EnvironmentObject var viewModel: GoalsViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
            VStack {
                
                //goals
                VStack(alignment: .leading) {
                    Text("Your Goal")
                        .font(.headline)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $viewModel.textGoals)
                            .lineSpacing(10)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        if viewModel.textGoals.isEmpty {
                            Text("Set Your Goals Here..")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                    }
                    .font(.caption)
                    .frame(width: UIScreen.screenWidth-30, height: 100, alignment: .center)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.systemGray3), lineWidth: 1))
                }
                .padding()
                
                //count option
                VStack(alignment: .leading) {
                    Text("How many options do you have in consideration?")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.placeholderText))
                }
                HStack {
                    Text("Options")
                        .font(.headline)
                    Spacer()
                    HStack {
                        Button(action: {
                            if viewModel.countOption > 2 {
                                viewModel.countOption -= 1
                            }
                        }, label: {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color(UIColor.systemIndigo))
                        })
                        
                        Text("\(viewModel.countOption)")
                            .padding()
                        
                        Button(action: {
                            viewModel.countOption += 1
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color(UIColor.systemIndigo))
                        })
                            
                    }
                }
                .padding()
                .frame(width: UIScreen.screenWidth-30, height: 50, alignment: .center)
                .clipShape(CustomShape(corner: .allCorners, radii: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.systemGray3), lineWidth: 1))
                
                Spacer()
            }
            .navigationTitle(Text("Setup Goal"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: HStack {
                    Button(action: {
                        self.showAddView.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color(UIColor.systemIndigo))
                    })
            }, trailing: HStack {
                    Button(action: {
                        self.viewModel.addGoal(context: context)
                        self.showAddView.toggle()
                    }, label: {
                        Text("Next")
                            .bold()
                            .foregroundColor(Color(UIColor.systemIndigo))
                    })
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    @State static var showAddView = false
    @State static var editorTitle: String = ""
    
    static var previews: some View {
        AddView(showAddView: $showAddView).environmentObject(GoalsViewModel())
    }
}
