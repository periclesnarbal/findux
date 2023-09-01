//
//  TriangleShape.swift
//  findux
//
//  Created by Péricles Narbal on 01/09/23.
//

import UIKit

/// Uma subclasse de CAShapeLayer que representa um triângulo definido por seus lados a, b e c.
class TriangleShape: CAShapeLayer {
    /// O comprimento do lado a (lado direito) do triângulo.
    let a: CGFloat
    /// O comprimento do lado b (lado esquerdo) do triângulo.
    let b: CGFloat
    /// O comprimento do lado c (base) do triângulo.
    let c: CGFloat
    
    /// O cosseno do ângulo "a" (alpha) entre os lados b e c, calculado usando a lei dos cossenos.
    private(set) lazy var cosA: CGFloat = (pow(b, 2) + pow(c, 2) - pow(a, 2)) / (2 * b * c)
    /// O ângulo (alpha) oposto ao lado a, em radianos.
    private(set) lazy var aAngle: CGFloat = acos(cosA)
    /// O seno do ângulo "a" (alpha).
    private(set) lazy var sinA: CGFloat = sin(aAngle)
    
    /// A semiperímetro do triângulo.
    private(set) lazy var S = (a + b + c) / 2
    /// A área do triângulo, calculada usando a fórmula de Heron.
    private(set) lazy var Area = sqrt(S * (S-a) * (S-b) * (S-c))
    /// A altura do triângulo em relação ao lado c.
    private(set) lazy var H = (2 * Area) / c

    /** Inicializa um novo triângulo com os lados especificados.
    
     - Parameters:
       - a: O comprimento do lado a (lado direito).
       - b: O comprimento do lado b (lado esquerdo).
       - c: O comprimento do lado c (base).
     */
    init(a: CGFloat, b: CGFloat, c: CGFloat) {
        self.a = a
        self.b = b
        self.c = c
        
        super.init()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configura a aparência visual do triângulo.
    private func setupView() {
        let verticies = calculateVerticies()
        let path = createPath(verticies: verticies)
        self.path = path.cgPath
    }

    /** Calcula as coordenadas dos vértices do triângulo.
    
     - Returns: As coordenadas dos vértices A, B e C do triângulo.
     */
    private func calculateVerticies() -> (A: CGPoint, B: CGPoint, C: CGPoint) {
        let A = CGPoint(x: frame.minX, y: H)
        let B = CGPoint(x: frame.minX + c, y: H)
        let C = CGPoint(x: frame.minX + b * cosA, y: H - b * sinA)
        
        return (A, B, C)
    }
    
    /** Cria um caminho UIBezierPath representando o triângulo.
    
     - Parameter verticies: As coordenadas dos vértices do triângulo.
     - Returns: Um caminho UIBezierPath representando o triângulo.
     */
    private func createPath(verticies: (A: CGPoint, B: CGPoint, C: CGPoint)) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: verticies.A)
        path.addLine(to: verticies.B)
        path.addLine(to: verticies.C)
        path.addLine(to: verticies.A)
        
        return path
    }
}
