
import UIKit

class NewsViewController: UITableViewController {
    
    
    var customRefreshController = UIRefreshControl()
    
    var name = ["Максим Петров", "Егор Максимов", "Юра Измайлов"]
    
    var content = ["Сделал заглушки, проверяю как это работает)) На самом дело то прекрасно! Единтсвенное это я не сам, а мне помогли","Ячейки хорошо расстягиваются, динамичные довольно таки, фотографии прикольно собираются в ячейки, хотелось бы расширить это, но что то не могу понять (этот layout плохо в голове откладываеться, что и куда, дальше увидим). Возьму методичку почитаю еще раз, видео пересмотрю, может уложиться в голове как нибудь! А пока довольствуюсь тем что есть =D Спасибо Насте помогла в этом вопросе, по её коду более менее сориентировался и понял, что куда и как!!", "Я таки разобрался спустя какое то время, начал копаться, по шагово смотреть, изменять и начал понимать)) И делал через по 4 столбца! Интересно как сделать так чтоб когда 3 фотографии то сверхну 2 большие пополам и одна снизу урезанная в ширину вся..... хмммммм"]
    
    var imagePost = ["PhotoGroup","PhotoProfile","PhotoGroup"]
    
    var time = ["Сегодня в 23:02", "Вчера в 15:10", "Сегодня в 14:03"]
    
    var image = [[
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        ], [ UIImage(named: "image1")!,
             UIImage(named: "image2")!,
             UIImage(named: "image3")!,
             UIImage(named: "image4")!,
             UIImage(named: "image1")!],
           [UIImage(named: "image1")!,
            UIImage(named: "image2")!]]
    
    
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "simpleNewsCell")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        settingHeader()
        addRefreshController()
    }
    
    func addRefreshController() {
        customRefreshController.tintColor = .white
        customRefreshController.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(customRefreshController)
    }
    
    @objc func refreshTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.customRefreshController.endRefreshing()
        }
    }
    
    private func settingHeader() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10.0))
        header.backgroundColor = UIColor.black
        tableView.tableHeaderView = header
    }
    
}

// MARK: dataSource

extension NewsViewController {
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.name.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "simpleNewsCell", for: indexPath) as? NewsCell  else {
            return UITableViewCell()
        }
        
        cell.aboutOfNews.text = content[indexPath.section]
        cell.nameGroup.text = name[indexPath.section]
        cell.groupImage.image = UIImage(named: imagePost[indexPath.section])
        cell.time.text = time[indexPath.section]
        
        //MARK: передаю массив фотографий на дальнейшее действие и визуализации коллекции
        
        cell.photoPost = image[indexPath.section]
        
        return cell
    }
}
