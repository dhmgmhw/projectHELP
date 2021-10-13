//
//  CountrySelectViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/12.
//

import UIKit
import Alamofire

class CountrySelectViewController: UIViewController {
    @IBOutlet weak var tableViewCountry: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var listCount: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "CountryCell", bundle: nil)
        tableViewCountry.register(nibName, forCellReuseIdentifier: "CountryCell")
        
        tableViewCountry.delegate = self
        tableViewCountry.dataSource = self
        
//        getTest()
        getList()

    }
        
    func getList() {
        let url = "https://6155639c93e3550017b08978.mockapi.io/countries"
        // AF.request().responseJSON으로 호출하면 JSON형식의 response를 받는다.
        AF.request(url, method: .get).responseJSON { response in
            print("response: \(response)")
            // response의 데이터를 받을 [Country] 타입의 리스트 변수
            var countries: [Country]
            do {
                let decoder = JSONDecoder()
                switch (response.result) {
                // 성공/실패 구분
                case .success:
                    // response의 data를 [Country]로 변환
                    countries = try decoder.decode([Country].self, from: response.data!)
                    self.listCount = countries
                    // 데이터 리로드
                    DispatchQueue.main.async {
                        self.tableViewCountry.reloadData()
                    }
                case .failure(let error):
                    print("에러코드: \(error._code)")
                    print("에러사유: \(error.errorDescription!)")
                }
            } catch let parsingError {
                print("Error:", parsingError)
            }
        }.resume()
    }

    
        
}

extension CountrySelectViewController: UITableViewDelegate {
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
}

extension CountrySelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else { return UITableViewCell() }
        cell.lblCountry.text = "\(listCount[indexPath.row].name)"
        return cell
    }
}
