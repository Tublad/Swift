
protocol GroupConfigurator {
    func configure(view: GroupTableViewController)
}

class GroupConfiguratorImplementation: GroupConfigurator {
    func configure(view: GroupTableViewController) {
        view.presenter = GroupsPresenterImplementation(database: GroupsRepository(), view: view)
    }
}
