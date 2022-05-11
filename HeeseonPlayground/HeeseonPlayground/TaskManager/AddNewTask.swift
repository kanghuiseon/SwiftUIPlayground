//
//  AddNewTask.swift
//  HeeseonPlayground
//
//  Created by 강희선 on 2022/05/12.
//

import SwiftUI

struct AddNewTask: View {
    @EnvironmentObject var vm: TaskManagerViewModel
    @Environment(\.self) var env
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 12) {
                Text("Edit Task")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Button(
                            action: { env.dismiss() },
                            label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        )
                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            
            colorSet
                .padding(.top, 20)
            
            Divider()
                .padding(.vertical, 10)
            
            title
            Spacer()
        }
        .padding(.horizontal, 25)
    }
    
    var colorSet: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Task Color")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack(spacing: 30) {
                ForEach(vm.colors, id: \.self) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 25, height: 25)
                        .background {
                            if vm.taskColor == color {
                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-5)
                            }
                        }
                        .onTapGesture {
                            vm.taskColor = color
                        }
                }
            }
        }
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Task Title")
                .font(.caption)
                .foregroundColor(.gray)
            
            TextField("", text: $vm.taskTitle)
                .frame(maxWidth: .infinity)
        }
        .overlay(alignment: .bottomTrailing) {
            Button(
                action: {
                    if vm.addTask(env.managedObjectContext) {
                        env.dismiss()
                    }
                },
                label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }
            )
        }
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskManagerViewModel())
    }
}
