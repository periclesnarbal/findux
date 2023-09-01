//
//  TriangleShape.swift
//  findux
//
//  Created by Péricles Narbal on 01/09/23.
//

import UIKit

class TriangleRectangleShape: BaseTriangleComplexShape {
    
    /** Inicializa um novo triângulo  retângulo com os lados especificados.
    
     - Parameters:
       - a: O comprimento do lado a (lado direito).
       - b: O comprimento do lado b (lado esquerdo).
     */
    init(a: CGFloat, b: CGFloat) {
        super.init()
        self.a = a
        self.b = b
        c = findHypotenuse(x: a, y: b)
        
        setupShape()
    }
    
    /** Inicializa um novo triângulo  retângulo com os lados especificados.
    
     - Parameters:
       - b: O comprimento do lado b (lado esquerdo).
       - c: O comprimento do lado c (base).
     */
    init(b: CGFloat, c: CGFloat) {
        super.init()
        self.b = b
        self.c = c
        a = findHypotenuse(x: b, y: c)
        
        setupShape()
    }
    
    /** Inicializa um novo triângulo  retângulo com os lados especificados.
    
     - Parameters:
       - a: O comprimento do lado a (lado direito).
       - c: O comprimento do lado c (base).
     */
    init (a: CGFloat, c: CGFloat) {
        super.init()
        self.a = a
        self.c = c
        b = findHypotenuse(x: a, y: c)
        
        setupShape()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configura a aparência visual do triângulo.
    override func setupShape() {
        let verticies = calculateVerticies()
        let path = createPath(verticies: verticies)
        self.path = path.cgPath
    }
}

class TriangleShape: BaseTriangleShape {
    
    init(verticies: (A: CGPoint, B: CGPoint, C: CGPoint)) {
        super.init()
        self.verticies = (verticies.A, verticies.B, verticies.C)
    
        setupShape()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Uma subclasse de CAShapeLayer que representa um triângulo definido por seus lados a, b e c.
class TriangleCustomShape: BaseTriangleComplexShape {

    /** Inicializa um novo triângulo com os lados especificados.
    
     - Parameters:
       - a: O comprimento do lado a (lado direito).
       - b: O comprimento do lado b (lado esquerdo).
       - c: O comprimento do lado c (base).
     */
    init(a: CGFloat, b: CGFloat, c: CGFloat) {
        super.init()
        self.a = a
        self.b = b
        self.c = c
    
        setupShape()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configura a aparência visual do triângulo.
    override func setupShape() {
        let verticies = calculateVerticies()
        let path = createPath(verticies: verticies)
        self.path = path.cgPath
    }
}
