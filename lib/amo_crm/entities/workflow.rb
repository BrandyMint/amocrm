module AmoCRM::Entities
  class Workflow < Base
    include CommonObject
    include AmoCRM::Entities::XmlFix

    element :code, String
    element :uuid, String

    has_many :states, AmoCRM::Entities::WorkflowState, tag: :state
  end
end
