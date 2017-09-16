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
          self.send(event.to_sym).where(emailtype: type)
        end
      end
    end
end
