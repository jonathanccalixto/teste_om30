# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def adorne(record)
    @adornes ||= {}
    @adornes[record] ||= begin
      "#{record.class}Decorator".constantize.new record
    rescue StandardError
      ApplicationDecorator.new record
    end
  end
  helper_method :adorne
end
