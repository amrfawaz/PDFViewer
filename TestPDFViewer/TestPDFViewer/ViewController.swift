//
//  ViewController.swift
//  TestPDFViewer
//
//  Created by AmrFawaz on 4/20/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func openPDF(_ sender: Any) {
        let pdfViewer = PDFController()
        pdfViewer.openPDF(path: "sample")
        let navigation = UINavigationController(rootViewController: pdfViewer)
        self.present(navigation, animated: true, completion: nil)
    }
    
    
    @IBAction func downloadPDF(_ sender: Any) {
        let pdfViewer = PDFController()
        pdfViewer.downloadPDF(url: "http://www.africau.edu/images/default/sample.pdf")
        
        let navigation = UINavigationController(rootViewController: pdfViewer)
        self.present(navigation, animated: true, completion: nil)
        
    }
    
    
}

