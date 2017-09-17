class Address < ActiveRecord::Base
    scope :sent, -> { where(event: 'send') }
    scope :opened, -> { where(event: 'open') }
    scope :clicked, -> { where(event: 'click') }

    def self.uniq_email_types
      all.map(&:emailtype).uniq
    end

    %w(opened clicked).each do |event|
      uniq_email_types.each do |type|
        self.class.send(:define_method, "#{event}_#{type}".to_sym) do
          addresses_by_emailtype = self.send(event.to_sym).where(emailtype: type)
          addresses_by_event = self.send(event.to_sym)
          event_rate_by_emailtype =
            (Float(addresses_by_event.size) / Float(addresses_by_emailtype.uniq.size)).round(3)
          percents = 100
          Float(percents/event_rate_by_emailtype).round(3)
        end
      end
    end
end
