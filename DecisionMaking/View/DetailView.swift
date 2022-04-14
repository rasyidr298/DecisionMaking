//
//  DetailView.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 08/04/22.
//

import SwiftUI


struct DetailView: View {
    
    @EnvironmentObject var goal: Goals
    @EnvironmentObject var viewModel: GoalsViewModel
    
    @State private var isExtendOption = false
    @State private var isExtendOptionList = false
    
    var isEditModeOption = false
    var isEditModeOptionlist = false
    
    @State private var isEditModeGoal = false
    @State private var goaltext = ""
    
    @State private var optionText = ""
    @State private var optionListText = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                
                //goals
                VStack {
                    HStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            self.isEditModeGoal.toggle()
                        }, label: {
                            Image(systemName: isEditModeGoal ? "checkmark.circle.fill" : "pencil.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color(UIColor.systemOrange))
                        })
                    }
                    .padding([.top, .leading, .trailing], 10)
                    
                    if isEditModeGoal {
                        TextField("",text: $goaltext)
                            .font(.headline)
                            .lineSpacing(10)
                            .autocapitalization(.words)
                            .multilineTextAlignment(.center)
                            .onAppear {
                                self.goaltext = goal.textGoals!
                            }
                    }else {
                        Text(goaltext.isEmpty ? goal.textGoals! : goaltext)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.white)
                    }
                    .padding([.leading, .bottom, .trailing], 10)
                }
                .font(.headline)
                .background(Color(UIColor.systemIndigo))
                .clipShape(CustomShape(corner: .allCorners, radii: 15))
                .frame(width: UIScreen.screenWidth-30)
                .onAppear {
                    Logger.log(.error, "\(goal)")
                }
                
                //Option
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0..<Int(goal.countOption)) {i in
                        Section {
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    ZStack {
                                        Text("Option \(i+1)")
                                            .font(.headline)
                                    }
                                    
                                    Spacer()
                                    
                                    if !isExtendOption {
                                        Text(isEditModeOption ? "Done" : "Edit")
                                            .font(.caption2)
                                            .foregroundColor(Color(UIColor.systemIndigo))
                                    }
                                    
                                    Button(action: {
                                        withAnimation{
                                            self.isExtendOption.toggle()
                                        }
                                    }, label: {
                                        Image(systemName: self.isExtendOption ? "chevron.down.circle.fill" : "chevron.right.circle.fill")
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: .center)
                                            .foregroundColor(Color(UIColor.systemGray4))
                                    })
                                }
                                .padding(.horizontal, 5)
                                
                                Divider()
                                    .background(Color.primary)
                                
                                //list option
                                if isExtendOption {
                                    HStack {
                                        Image(systemName: "smallcircle.filled.circle.fill")
                                            .resizable()
                                            .frame(width: 5, height: 5, alignment: .center)
                                        
                                        Text("Lorem Ipsum is simply dummy text of the printing")
                                            .font(.caption)
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Spacer()
                                            HStack {
                                                if !isExtendOptionList {
                                                    Text(self.isEditModeOptionlist ? "Done" : "Edit")
                                                        .font(.caption2)
                                                        .foregroundColor(Color(UIColor.systemIndigo))
                                                }
                                                
                                                Button(action: {
                                                    withAnimation{
                                                        self.isExtendOptionList.toggle()
                                                    }
                                                }, label: {
                                                    Image(systemName: self.isExtendOptionList ? "chevron.down.circle.fill" : "chevron.right.circle.fill")
                                                        .resizable()
                                                        .frame(width: 15, height: 15, alignment: .center)
                                                })
                                            }
                                        }
                                    }
                                    .padding(5)
                                    .background(Color(UIColor.systemGray5))
                                    .clipShape(CustomShape(corner: .allCorners, radii: 10))
                                    
                                    Button(action: {
                                        //add ways list
                                    }, label: {
                                        HStack {
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .frame(width: 15, height: 15, alignment: .center)
                                            Text("Add Options List")
                                                .font(.footnote)
                                                .bold()
                                        }
                                        .padding(.top, 10.0)
                                    })
                                }
                            }
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .clipShape(CustomShape(corner: .allCorners, radii: 15))
                            .frame(width: UIScreen.screenWidth-30)
                        }
                        .padding(.top, 10.0)
                    }
                    .padding(.top, 10)
                    
                }
                
                Spacer()
            }
            .padding(.bottom, 70.0)
            .navigationTitle(Text("Detail"))
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            ZStack {
                CustomShape(corner: .allCorners, radii: 0)
                    .background(Color(UIColor.systemGray6))
                    .foregroundColor(Color(UIColor.systemGray6))
                    .frame(width: UIScreen.screenWidth,height: 70, alignment: .center)
                HStack {
                    
                    Spacer()
                    Button(action: {
                        DecisionMaking.shareSheet(content: [goal.textGoals!, String(goal.countOption)])
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                    
                    Spacer()
                    Button(action: {
                        //add option
                    }, label: {
                        Image(systemName: "rectangle.stack.badge.plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(Goals())
            .preferredColorScheme(.dark)
    }
}
