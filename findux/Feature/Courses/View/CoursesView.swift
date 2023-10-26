//
//  CoursesView.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import UIKit
import SwiftUI

class CoursesView: BaseView<CoursesCoordinator> {
    
    var coursesData: [CoursesModel] = {
        if let path = Bundle.main.path(forResource: "courses", ofType: "json") {
            do {
                return try JSONManager.decodeFromFile(path)
            } catch {
                print(error)
            }
        }
        return []
    }()
    
    lazy var courses: [CoursesCellModel] = {
        return coursesData.map { CoursesCellModel(courses: $0) { print("ABEL IS GONE")}}
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    func commomInit() {
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        backgroundColor = .white
        tableView.backgroundColor = .white
        addSubview(tableView)
        
        tableView.register(CoursesTableViewCell.self, forCellReuseIdentifier: CoursesTableViewCell.reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        embedConstraints(tableView)
    }
}

extension CoursesView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoursesTableViewCell.reuseIdentifier, for: indexPath) as? CoursesTableViewCell else { return UITableViewCell()}
        let data = courses[indexPath.section]
        cell.setupCell(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }
}

extension CoursesView: FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.title = "Cursos"
    }
}

struct CoursesViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            CoursesView()
        }.edgesIgnoringSafeArea(.all)
    }
}

