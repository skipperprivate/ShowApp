import UIKit
//import Charts

class StatisticsViewController: UIViewController {
    
    // MARK: - Private properties
    /*
    private let ordersCountPieChartView: PieChartView = {
        let pieChartV = PieChartView(frame: .zero)
        pieChartV.translatesAutoresizingMaskIntoConstraints = false
        return pieChartV
    }()
    
    private let ordersSumPieChartView: PieChartView = {
        let pieChartV = PieChartView(frame: .zero)
        pieChartV.translatesAutoresizingMaskIntoConstraints = false
        return pieChartV
    }()
    
    private let ordersCountBarChartView: BarChartView = {
        let barChartV = BarChartView(frame: .zero)
        barChartV.translatesAutoresizingMaskIntoConstraints = false
        return barChartV
    }()
    
    private let ordersSumBarChartView: BarChartView = {
        let barChartV = BarChartView(frame: .zero)
        barChartV.translatesAutoresizingMaskIntoConstraints = false
        return barChartV
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()
    
    private let contentScrollView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let players = ["Кунцево", "Мозаика"]
    private let goals = [6, 8]
    
    private let players_ = ["Кунцево", "Мозаика"]
    private let goals_ = [25454, 30536]
    
    private let players1 = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    private let goals1 = [6, 8, 3, 5, 1, 10, 7]
    
    private let players2 = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    private let goals2 = [6000, 8000, 10200, 5300, 10000, 2500, 7400]
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        setUpOrdersCountPieChartView(dataPoints: players, values: goals.map{ Double($0) })
        setUpOrdersSumPieChartView(dataPoints: players_, values: goals_.map{ Double($0) })
        
        setUpOrdersCountBarChartView(dataPoints: players1, values: goals1.map{ Double($0) })
        setUpOrdersSumBarChartView(dataPoints: players2, values: goals2.map{ Double($0) })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 3000.0)
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setUpCharts()
    }
    
    private func setUpCharts() {
        contentScrollView.addSubview(ordersCountPieChartView)
        ordersCountPieChartView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        ordersCountPieChartView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        ordersCountPieChartView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 3/4).isActive = true
        ordersCountPieChartView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        contentScrollView.addSubview(ordersCountBarChartView)
        ordersCountBarChartView.topAnchor.constraint(equalTo: ordersCountPieChartView.bottomAnchor).isActive = true;
        ordersCountBarChartView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        ordersCountBarChartView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 3/4).isActive = true
        ordersCountBarChartView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        contentScrollView.addSubview(ordersSumPieChartView)
        ordersSumPieChartView.topAnchor.constraint(equalTo: ordersCountBarChartView.bottomAnchor).isActive = true;
        ordersSumPieChartView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        ordersSumPieChartView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 3/4).isActive = true
        ordersSumPieChartView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        contentScrollView.addSubview(ordersSumBarChartView)
        ordersSumBarChartView.topAnchor.constraint(equalTo: ordersSumPieChartView.bottomAnchor).isActive = true;
        ordersSumBarChartView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        ordersSumBarChartView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 3/4).isActive = true
        ordersSumBarChartView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        ordersSumBarChartView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor).isActive = true
    }
    
    private func setUpOrdersCountPieChartView(dataPoints: [String], values: [Double]) {
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      // 4. Assign it to the chart’s data
      ordersCountPieChartView.data = pieChartData
    }
    
    private func setUpOrdersSumPieChartView(dataPoints: [String], values: [Double]) {
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      // 4. Assign it to the chart’s data
      ordersSumPieChartView.data = pieChartData
    }
    
    private func setUpOrdersCountBarChartView(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        ordersCountBarChartView.data = chartData
    }
    
    private func setUpOrdersSumBarChartView(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        ordersSumBarChartView.data = chartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }*/

}
