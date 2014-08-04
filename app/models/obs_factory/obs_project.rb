module ObsFactory
  class ObsProject

    attr_accessor :project, :nickname

    def initialize(name, nick)
      self.project = Project.find_by_name(name)
      self.nickname = nick
    end

    def name
      project.name
    end

  end
end
