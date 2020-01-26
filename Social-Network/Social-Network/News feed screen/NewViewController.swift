
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "simpleNewsCell", for: indexPath) as? NewsCell  else {
            return UITableViewCell()
        }
        cell.aboutOfNews.text = content[indexPath.row]
        cell.nameGroup.text = name[indexPath.row]
        cell.groupImage.image = UIImage(named: imagePost[indexPath.row])
        cell.time.text = time[indexPath.row]
        
        // передаю массив фотографий на дальнейшее дейсвие и визуализации коллекции
        
        cell.photoPost = image[indexPath.row]
        
        return cell
    }
    
}
