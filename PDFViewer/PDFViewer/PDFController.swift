//
//  PDFController.swift
//  PDFViewer
//
//  Created by AmrFawaz on 4/20/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

public class PDFController: UIViewController {

    private var url: URL?
    private var pdfView = PDFView()

    open var closeButtonTintColor: UIColor? = .white
    
    init(pdfUrl: String) {
        self.url = URL(string: pdfUrl)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        addSaveButton()
        addCloseButton()
        navigationController?.navigationBar.isTranslucent = false
        pdfView.frame = view.frame
    }
    
    
    open func openPDF() {
        if let document = PDFDocument(url: self.url!) {
            pdfView.document = document
            view.addSubview(pdfView)
        }
    }
    
    
    
    func addCloseButton() {
        let closeButton = UIBarButtonItem()
        closeButton.style = .done
        closeButton.target = self
        closeButton.action = #selector(dismissView)
        closeButton.tintColor = closeButtonTintColor
        closeButton.image = #imageLiteral(resourceName: "close")
        navigationItem.leftBarButtonItem = closeButton
    }
    
    func addSaveButton() {
        let saveButton = UIBarButtonItem(image: #imageLiteral(resourceName: "download"), style: .done, target: self, action: #selector(saveFile))
        saveButton.tintColor = .white
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveFile() {
        do {
            let fileDate = try Data(contentsOf: self.url!)
            do {
                try fileDate.write(to: self.url!)
                let activityViewController = UIActivityViewController(activityItems: [self.url!], applicationActivities: nil)
                present(activityViewController, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}
