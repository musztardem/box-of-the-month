# frozen_string_literal: true

module DryMatcherSupport
  def stub_with_dry_matcher(klass, call:)
    raise ArgumentError, 'Provided class does not have #call method' unless klass.method_defined? :call

    instance_spy(klass, call: call).tap do |spy|
      spy.singleton_class.include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)
    end
  end
end
