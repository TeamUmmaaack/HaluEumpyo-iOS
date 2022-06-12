//
//  DiaryListViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import UIKit

final class DiaryListViewController: BaseViewController {
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width-24
        static let cellHeight: CGFloat = 115
    }
    
    private var modalDateView: DatePickerViewController?
    private var currentDate: AppDate?
    private var selectedYear: Int?
    private var selectedMonth: Int?
    private var currentPage = -1
    
    // MARK: - Property
    private lazy var diaryListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        layout.minimumLineSpacing = 29
        layout.headerReferenceSize = .init(width: Size.cellWidth, height: 53)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DiaryListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: DiaryListCollectionViewCell.self))
        collectionView.register(DrawerCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: DrawerCollectionReusableView.self))
        collectionView.backgroundColor = .haluEumpyo_background()
        return collectionView
    }()
    
    var diaries: [Diary] = []
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        return button
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCurrentDate()
        addObservers()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        guard let year = selectedYear,
              let month = selectedMonth else { return }
        self.getDiaries(request: DiaryRequestModel.init(date: "\(year)-\(month)-01"))
    }
    
    private func initCurrentDate() {
        self.currentDate = AppDate()
        self.selectedYear = currentDate?.getYear()
        self.selectedMonth = currentDate?.getMonth()
    }
    
    private func addObservers() {
        print("observer 더함")
        NotificationCenter.default.addObserver(self, selector: #selector(presentPickerView), name: NSNotification.Name("calendarButtonClicked"), object: nil)
    }
    
    // MARK: - config
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = UIColor.haluEumpyo_background()
        setupNavigationBar()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true 
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(diaryListCollectionView)
        
        diaryListCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func updateData(data: [Diary]) {
        self.diaries = data
        self.parseDate()
        diaryListCollectionView.reloadData()
    }
    
    public func parseDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatType.full.description
        _ = diaries.map {
            dateFormatter.date(from: $0.createdAt)?.toEngString(of: .calendar)
        }
    }
    
    private func bind() {
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        title = "모아보기"
        setupBaseNavigationBar(backgroundColor: UIColor.haluEumpyo_background(),
                               titleColor: UIColor.haluEmpyo_black(),
                               isTranslucent: false,
                               tintColor: UIColor.haluEmpyo_black())
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
    }
    
    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }
    
    // MARK: - @objc functions
    
    @objc func presentPickerView(notification: NSNotification) {
        print("presentPickerView 부름")
        guard let year = selectedYear, let month = selectedMonth else { return }
        
        self.modalDateView = DatePickerViewController()
        self.modalDateView?.datePickerDataDelegate = self
        guard let modalDateView = self.modalDateView else { return }
        modalDateView.year = year
        modalDateView.month = month
        modalDateView.modalPresentationStyle = .custom
        modalDateView.transitioningDelegate = self
        
        self.present(modalDateView, animated: true, completion: nil)
    }
}

extension DiaryListViewController: DatePickerViewDelegate {
    func passData(_ year: String, _ month: String) {
        self.selectedYear = Int(year)
        self.selectedMonth = Int(month)
        
        guard let unwrappedYear = selectedYear else { return }
        guard let unwrappedMonth = selectedMonth else { return }
        
        let yearMonthDate = [year, month]
        NotificationCenter.default.post(name: NSNotification.Name("datePickerSelected"), object: yearMonthDate)
        getDiaries(request: DiaryRequestModel.init(date: "\(unwrappedYear)-\(unwrappedMonth)-01"))
        diaryListCollectionView.reloadData()
    }
}

extension DiaryListViewController {
    public func getDiaries(request: DiaryRequestModel) {
        self.currentPage += 1
        DiaryService.shared.getCurrentMonthDiaries(request: request) { [weak self] response in
            switch response {
            case .success(let data):
                print("데이터: ", data)
                guard let data = data as? [Diary] else { return }
                self?.updateData(data: data)
                self?.diaryListCollectionView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                         self?.diaryListCollectionView.performBatchUpdates(nil, completion: nil)
                       }
            case .requestErr(let message):
                print("requesterr \(message)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
