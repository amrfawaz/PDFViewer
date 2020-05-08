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

    private var pdfView = PDFView()

    open var closeButtonTintColor: UIColor? = .black
    
    public init() {
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
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        pdfView.displayDirection = .vertical

    }
    
    
    open func openPDF(path: String) {
        self.title = path
        if let url = Bundle.main.url(forResource: path, withExtension: "pdf") {
            DispatchQueue.main.async {
                if let document = PDFDocument(url: url) {
                    self.setPdfViewDocument(document: document)
                }
            }
        }
    }
    
    
    open func downloadPDF(url: String) {
        let url = URL(string: url)!
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            if let localURL = localURL {
                DispatchQueue.main.async {
                    self.title = localURL.lastPathComponent
                }
                if let document = PDFDocument(url: localURL) {
                    self.setPdfViewDocument(document: document)
                }
            }
        }
        task.resume()
    }
    
    private func setPdfViewDocument(document: PDFDocument) {
        DispatchQueue.main.async {
            self.pdfView.document = document
            self.view.addSubview(self.pdfView)
        }
    }
    
    func addCloseButton() {
        let closeButton = UIBarButtonItem()
        closeButton.style = .done
        closeButton.target = self
        closeButton.action = #selector(dismissView)
        closeButton.tintColor = closeButtonTintColor
        closeButton.image = UIImage(named: "close.pdf")
        navigationItem.leftBarButtonItem = closeButton
    }
    
    func addSaveButton() {
        let saveButton = UIBarButtonItem(image: UIImage(named: "save.pdf"), style: .done, target: self, action: #selector(saveFile))
        saveButton.tintColor = .black
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveFile(url: String) {
        do {
            if let path = Bundle.main.url(forResource: url, withExtension: "pdf") {
                let fileDate = try Data(contentsOf: path)
                do {
                    try fileDate.write(to: path)
                    let activityViewController = UIActivityViewController(activityItems: [path], applicationActivities: nil)
                    present(activityViewController, animated: true, completion: nil)
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
