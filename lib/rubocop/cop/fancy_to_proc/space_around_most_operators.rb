# encoding: utf-8
# frozen_string_literal: true
begin
  class RuboCop::Cop::Style::SpaceAroundOperators
    IRREGULAR_METHODS = %i([] ! []= &).freeze
  end
rescue NameError
  nil
end
