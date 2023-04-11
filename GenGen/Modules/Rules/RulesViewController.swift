//
//  RulesViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit

class RulesViewController: BaseViewController {

    // MARK: - Properties
    var rules: [Rule] = []
    private var viewModel: RuleProvider
    private var router: RulesRouting

    // MARK: - UI
    lazy var headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.rules,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: Texts.rulesNavigationTitle)

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var addButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: AppTheme.Navigation.Image.add,
                                            style: .plain,
                                            target: self,
                                            action: #selector(addTapped))
        barButtonItem.tintColor = AppTheme.Main.Color.buttonBackground
        return barButtonItem
    }()

    // MARK: - LifeCycle
    init(viewModel: RuleProvider = RulesViewModel(), router: RulesRouting = RulesRouter()) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadRules()
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
        navigationItem.rightBarButtonItem = addButton
    }

    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
        tableView.register(RulesTableViewCell.self, forCellReuseIdentifier: Texts.rulesTableViewCell)
        tableView.dataSource = self

        view.addSubview(tableView)
        view.embedToSafeArea(view: tableView)
    }

    // MARK: - Internal Methods
    private func loadRules() {
        self.addButton.isHidden = true
        viewModel.fetchRules { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rules):
                self.rules = rules
                self.tableView.reloadData()
                self.addButton.isHidden = false
            case .failure(let failure):
                print("Error getting rules: \(failure)")
            }
        }
    }

    // MARK: - Actions
    @objc private func addTapped() {
        router.didSelectAdd(in: self)
    }
}

// MARK: - UITableViewDataSource
extension RulesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Texts.rulesTableViewCell, for: indexPath) as? RulesTableViewCell else {
            return UITableViewCell()
        }
        guard let ruleName = self.rules[indexPath.row].name else { return UITableViewCell() }
        cell.configure(ruleName: ruleName, active: self.rules[indexPath.row].active)
        cell.delegate = self
        return cell
    }
}

extension RulesViewController: ActiveSwitchDelegate {
    func didChangeValue(for cell: UITableViewCell, value: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        self.rules[indexPath.row].active = value
        viewModel.updateRule(self.rules[indexPath.row]) { updateResult in
            switch updateResult {
            case .success(let rule):
                print("Rule \(String(describing: rule.name)) is active: \(rule.active)")
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
}
