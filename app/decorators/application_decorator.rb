class ApplicationDecorator
  def initialize(record)
    @record = record
  end

  def respond_to_missing?(method, include_private = false)
    record.respond_to?(method, include_private) || super
  end

  def method_missing(method, *, **, &)
    if record.respond_to?(method)
      record.public_send(method, *, **, &)
    else
      super
    end
  end

  private

  attr_accessor :record

  delegate :t, :l, to: :I18n
end
