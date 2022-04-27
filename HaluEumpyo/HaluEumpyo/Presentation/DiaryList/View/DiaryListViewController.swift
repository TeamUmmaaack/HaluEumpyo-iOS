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
    
    private var contents: [Content] = []
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCurrentDate()
        addObservers()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        guard let year = selectedYear,
              let month = selectedMonth else { return }
        setContentsList()
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
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = UIColor.haluEumpyo_background()
        setupNavigationBar()
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(diaryListCollectionView)
        
        diaryListCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
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
    
    func setContentsList() {
        contents.append(contentsOf: [
            Content(id: 1,
                    day: "WED",
                    date: 2,
                    content: "과제 제출이 어제까지였다 망했다...ㅋㅋㅋㅋㅋㅋ 기분완전 꿀꿀하다",
                    music: "Bring me the horizon -Doomed",
                    emotion: 3
                   ),
            Content(id: 2,
                    day: "SAT",
                    date: 5,
                    content: "새벽 1시에 봤다...ㅎ 엄마랑 같이 자야지 진짜 무섭네",
                    music: "Michael Jackson - Thriller",
                    emotion: 5),
            Content(id: 3,
                    day: "Tue",
                    date: 8,
                    content: "으으으 바퀴벌레 봤다 기분나빠 ",
                    music: "HALSEY - I HATE EVERYTHING",
                    emotion: 4),
            Content(id: 4,
                    day: "THUR",
                    date: 10,
                    content: "그저 그런 하루였다 뭔가 특별한 것도 없었고...",
                    music: "Supertramp - Just A Normal Day",
                    emotion: 6),
            Content(id: 5,
                    day: "FRI",
                    date: 11,
                    content: "포켓몬빵 드디어 샀다 ㅋㅋ 편의점 다섯 군데 돌았는데 재고가 없어서 초딩들이랑 같이 터덜터덜 나왔었다..🥲 근데 맨 마지막 편의점에서 드디어 하나 샀다! 아직 안 뜯어봤는데 고라파덕 나왔으면 좋겠다..",
                    music: "Charlie Puth - See You Again",
                    emotion: 0)
        ])
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
}

extension DiaryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DiaryListCollectionViewCell.self), for: indexPath) as? DiaryListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.containerView.layer.applyShadow(color: UIColor.black, alpha: 0.06, x: 0, y: 4, blur: 10, spread: 0)
        cell.setData(content: contents[indexPath.row])
        
        return cell
    }    
}

extension DiaryListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: DrawerCollectionReusableView.self), for: indexPath)
            return headerView
        default:
            assert(false, "에러")
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        let diaryViewController = DiaryViewController(contentId: contents[item].id, emotion: contents[item].emotion, content: contents[item].content, music: contents[item].music, day: contents[item].day, date: contents[item].date)
        navigationController?.pushViewController(diaryViewController, animated: true)
    }
}

extension DiaryListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
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
        
        diaryListCollectionView.reloadData()
    }
}
