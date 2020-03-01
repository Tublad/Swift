
protocol GlobalGroupsConfiguration {
    func configurator(view: GlobalGroupTableViewController)
}

class GlobalGroupsConfigurationImplementation: GlobalGroupsConfiguration {
    func configurator(view: GlobalGroupTableViewController) {
        return  view.presenter = GlobalGroupsPresenterImplementation(view: view)
    }
}
