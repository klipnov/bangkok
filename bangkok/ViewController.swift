//
//  ViewController.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = ViewModel()
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pageControl: BangkokPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(activityIndicator)
        viewModel.didUpdateSurvey = {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.pageControl.numberOfPages = self.viewModel.surveys.count
        }
    }
    
    @IBAction func didTapRefresh(_ sender: Any) {
        self.activityIndicator.color = UIColor.white
        self.activityIndicator.startAnimating()
        viewModel.refreshSurvey()
    } 
    
}

// MARK: - TableViewDelegate and Datasource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.surveys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardTableViewCell
        
        let survey = viewModel.surveys[indexPath.row]
        
        cell.title.text = survey.title
        cell.descriptionLabel.text = survey.surveyDescription
        
        if let imageUrlString = survey.imageURL {
            if let imageUrl = URL(string: imageUrlString) {
                cell.backgroundImage.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"), filter: nil, progress: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.3), runImageTransitionIfCached: false, completion: nil)
            }
        }
        
        return cell
    }
    
}

// MARK: - ScrollView Delegate

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.y / scrollView.frame.size.height)
        pageControl.currentPage = Int(pageNumber)
    }
}
