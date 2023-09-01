//
//  BaseTriangleShape.swift
//  findux
//
//  Created by Péricles Narbal on 01/09/23.
//

import UIKit

class BaseTriangleShape: CAShapeLayer {
    var verticies: (A: CGPoint, B: CGPoint, C: CGPoint) = (.zero, .zero, .zero)
    
    /// Configura a aparência visual do triângulo.
    func setupShape() {
        let path = createPath(verticies: verticies)
        self.path = path.cgPath
    }
    
    /** Cria um caminho UIBezierPath representando o triângulo.
    
     - Parameter verticies: As coordenadas dos vértices do triângulo.
     - Returns: Um caminho UIBezierPath representando o triângulo.
     */
    func createPath(verticies: (A: CGPoint, B: CGPoint, C: CGPoint)) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: verticies.A)
        path.addLine(to: verticies.B)
        path.addLine(to: verticies.C)
        path.addLine(to: verticies.A)
        
        return path
    }
}

class BaseTriangleComplexShape: BaseTriangleShape {
    /// O comprimento do lado a (lado direito) do triângulo.
    var a: CGFloat = 0
    /// O comprimento do lado b (lado esquerdo) do triângulo.
    var b: CGFloat = 0
    /// O comprimento do lado c (base) do triângulo.
    var c: CGFloat = 0
    
    var cosA: CGFloat { (pow(b, 2) + pow(c, 2) - pow(a, 2)) / (2 * b * c) }
    /// O ângulo (alpha) oposto ao lado a, em radianos.
    var aAngle: CGFloat { acos(cosA) }
    /// O seno do ângulo "a" (alpha).
    var sinA: CGFloat { sin(aAngle) }
    
    /// A semiperímetro do triângulo.
    var S: CGFloat { (a + b + c) / 2 }
    /// A área do triângulo, calculada usando a fórmula de Heron.
    var Area: CGFloat { sqrt(S * (S-a) * (S-b) * (S-c)) }
    /// A altura do triângulo em relação ao lado c.
    var H: CGFloat { (2 * Area) / c }
    
    /** Calcula as coordenadas dos vértices do triângulo.
    
     - Returns: As coordenadas dos vértices A, B e C do triângulo.
     */
    func calculateVerticies() -> (A: CGPoint, B: CGPoint, C: CGPoint) {
        let H = self.H
        
        let A = CGPoint(x: frame.minX, y: H)
        let B = CGPoint(x: frame.minX + c, y: H)
        let C = CGPoint(x: frame.minX + b * cosA, y: H - b * sinA)
        
        return (A, B, C)
    }
    
    func findHypotenuse(x: CGFloat, y: CGFloat) -> CGFloat {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
}
