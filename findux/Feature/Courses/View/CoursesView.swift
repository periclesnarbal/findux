//
//  CoursesView.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import UIKit

class CoursesView: BaseView<CoursesCoordinator> {
    
    var courses = [CoursesCellModel(title: "Gestão de Finanças Pessoais",
        author: "Autores: Banco Central do Brasil e Escola de Administração Fazendária",
        description: "Descrição: Apresentar conceitos básicos de gestão de finanças pessoais e estimular a reflexão sobre temas do cotidiano das pessoas de forma lúdica por meio de vídeos animados.",
        action: { print("ABEL IS ALIVE") }),
                 CoursesCellModel(title: "Gestão de Finanças Pessoais 2",
        author: "Autores: Banco Central do Brasil e Escola de Administração Fazendária",
        description: "Descrição: Apresentar conceitos básicos de gestão de finanças pessoais e estimular a reflexão sobre temas do cotidiano das pessoas de forma lúdica por meio de vídeos animados.",
        action: { print("ABEL IS ALIVE 2") })]
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoursesTableViewCell.reuseIdentifier, for: indexPath) as? CoursesTableViewCell else { return UITableViewCell()}
        let data = courses[indexPath.row]
        cell.setupCell(data: data)
        return cell
    }
}

