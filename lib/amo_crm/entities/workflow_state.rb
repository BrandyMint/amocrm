module AmoCRM::Entities
  class WorkflowState < Base
    include CommonObject
    include AmoCRM::Entities::XmlFix

    element :uuid, String
  end
end
