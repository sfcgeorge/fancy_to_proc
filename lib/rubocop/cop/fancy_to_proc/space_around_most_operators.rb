# encoding: utf-8
# frozen_string_literal: true
begin
  class RuboCop::Cop::Style::SpaceAroundOperators
    def on_send(node)
      if node.loc.operator # aref assignment, attribute assignment
        on_special_asgn(node)
      elsif !node.unary_operation? && !called_with_dot?(node)
        op = node.method_name
        if op != :[] && op != :! && op != :[]= && op != :& && operator?(op)
          _, _, right, = *node
          check_operator(node.loc.selector, right.source_range)
        end
      end
    end
  end
rescue NameError
  nil
end
