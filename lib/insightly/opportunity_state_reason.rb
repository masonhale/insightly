module Insightly
  class OpportunityStateReason < ReadOnly
    self.url_base = "OpportunityStateReasons"
    STATES = ["Abandoned", "Lost", "Open", "Suspended", "Won"]
    api_field "STATE_REASON_ID",
              "FOR_OPPORTUNITY_STATE",
              "STATE_REASON"


    def self.find_by_state(state)
      list = []
      OpportunityStateReason.all.each.each do |x|
        if x.for_opportunity_state && x.for_opportunity_state.match(state)
          list << x
        end
      end
      list
    end

    def self.find_by_state_reason(state,reason)
      OpportunityStateReason.all.each.each do |x|
              return x if x.for_opportunity_state && x.for_opportunity_state.match(state) && x.state_reason == reason
      end
      nil
    end
    STATES.each do |state|

      (
      class << self;
        self;
      end).instance_eval do
        define_method state.downcase.to_sym do |*args|
          reason = args.first
          if reason
            OpportunityStateReason.find_by_state_reason(state,reason)
          else
            OpportunityStateReason.find_by_state(state)
          end

        end
      end

    end

  end
end