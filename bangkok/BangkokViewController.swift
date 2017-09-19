//
//  BangkokViewController.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit
import AlamofireImage

class BangkokViewController: UIViewController, AlertDisplaying {
    
    let viewModel = BangkokViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pageControl: VerticalPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides the extra cells from showing
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        viewModel.refreshSurvey()
        
        // Reload tableView and Update UI after survey updates
        viewModel.didUpdateSurvey = {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.pageControl.numberOfPages = self.viewModel.surveys.count
        }
        
        viewModel.requestError = { (error) in
            self.showAlert(title: "Network Error", message: error.localizedDescription, viewController: self)
        }
    }
    
    // Get the destination file and set selected title
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        let survey = sender as! Survey
        
        destination.title = survey.title
    }
    
    // Update UI and Reload upon refresh
    @IBAction func didTapRefresh(_ sender: Any) {
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        
        viewModel.refreshSurvey()
    }
    
}

// MARK: - TableViewDelegate and Datasource

extension BangkokViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        cell.cardTitle.text = survey.title
        cell.cardDescription.text = survey.surveyDescription
        
        // Check if survey imgURL is legit and download image
        if let imageUrlString = survey.imageURL {
            if let imageUrl = URL(string: imageUrlString) {
                cell.backgroundImage.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"), filter: nil, progress: nil, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false, completion: nil)
            }
        }
        
        // View survey upon tapping a button
        cell.didTapSurveyButton = {
            self.performSegue(withIdentifier: "viewSurvey", sender: survey)
        }
        
        return cell
    }
    
}

// MARK: - ScrollView Delegate

extension BangkokViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //Update the page control indicator
        let pageNumber = round(scrollView.contentOffset.y / scrollView.frame.size.height)
        pageControl.currentPage = Int(pageNumber)
    }
}
