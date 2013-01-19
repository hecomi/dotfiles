#--
#
# Author:: Kouhei Sutou
# Copyright::
#   * Copyright (c) 2011 Kouhei Sutou <kou@clear-code.com>
# License:: Ruby license.

require 'rr'
require 'test/unit'

module Test::Unit
  module RR
    VERSION = "1.0.1"

    module Adapter
      include ::RR::Adapters::RRMethods

      class << self
        def included(mod)
          ::RR.trim_backtrace = true
          mod.module_eval do
            setup :before => :prepend
            def setup_rr
              ::RR.reset
            end

            teardown :after => :append
            def teardown_rr
              ::RR.verify
            end
          end
        end
      end

      def assert_received(subject, &block)
        block.call(received(subject)).call
      end
    end
  end

  class TestCase
    include RR::Adapter
  end
end
