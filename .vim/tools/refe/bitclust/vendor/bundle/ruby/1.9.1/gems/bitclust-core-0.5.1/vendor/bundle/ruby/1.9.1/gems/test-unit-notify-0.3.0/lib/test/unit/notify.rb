#--
#
# Author:: Kouhei Sutou
# Copyright::
#   * Copyright (c) 2010 Kouhei Sutou <kou@clear-code.com>
# License:: LGPLv2+

require 'pathname'
require 'erb'
require 'test/unit'

module Test
  module Unit
    AutoRunner.prepare do |auto_runner|
      Notify.enable(auto_runner) if Notify.enable?
    end

    AutoRunner.setup_option do |auto_runner, options|
      options.on("--[no-]notify",
                 "Notify test result at the last.",
                 "(default is auto [#{Notify.enable?}])") do |use_notify|
        Notify.disable(auto_runner)
        Notify.enable(auto_runner) if use_notify
      end
    end

    module Notify
      VERSION = "0.3.0"

      class << self
        def enable(auto_runner)
          auto_runner.listeners << Notifier.new
        end

        def disable(auto_runner)
          auto_runner.listeners.reject! do |listener|
            listener.is_a?(Notify::Notifier)
          end
        end

        @@enable = nil
        def enable=(enable)
          @@enable = enable
        end

        def enable?
          if @@enable.nil?
            @@enable = Notifier.available?
          end
          @@enable
        end
      end

      class NotifyCommand
        def available?
          paths.any? do |path|
            File.exist?(File.join(path, @command))
          end
        end

        private
        def paths
          path_env = ENV["PATH"]
          if path_env.nil?
            default_paths
          else
            path_env.split(File::PATH_SEPARATOR)
          end
        end

        def default_paths
          ["/usr/local/bin", "/usr/bin", "/bin"]
        end
      end

      class NotifySend < NotifyCommand
        include ERB::Util

        def initialize
          @command = "notify-send"
        end

        def run(parameters)
          expire_time = parameters[:expire_time] * 1000
          urgency = parameters[:urgency]
          title = parameters[:title]
          message = h(parameters[:message])
          icon = parameters[:icon]

          command_line = [@command,
                          "--expire-time", expire_time.to_s,
                          "--urgency", urgency]
          command_line.concat(["--icon", icon.to_s]) if icon
          command_line << title
          command_line << message
          system(*command_line)
        end
      end

      class Growlnotify < NotifyCommand
        def initialize
          @command = "growlnotify"
        end

        def run(parameters)
          expire_time = parameters[:expire_time]
          priority = urgency_to_piroity(parameters[:urgency])
          title = parameters[:title]
          message = parameters[:message]
          image = parameters[:icon]

          command_line = [@command,
                          "--priority", priority,
                          "--message", message]
          command_line.concat(["--image", image.to_s]) if image
          command_line << title
          system(*command_line)
        end

        private
        def urgency_to_piroity(urgency)
          case urgency
          when "normal"
            "Normal"
          when "critical"
            "Emergency"
          else
            "Normal"
          end
        end
      end

      class Notifier
        class << self
          def available?
            not command.nil?
          end

          def command
            @@command ||= commands.find {|command| command.available?}
          end

          def commands
            [NotifySend.new, Growlnotify.new]
          end
        end

        base_dir = Pathname(__FILE__).dirname.parent.parent.parent.expand_path
        ICON_DIR = base_dir + "data" + "icons"
        def initialize
          @theme = "kinotan"
        end

        def attach_to_mediator(mediator)
          mediator.add_listener(UI::TestRunnerMediator::STARTED,
                                &method(:started))
          mediator.add_listener(UI::TestRunnerMediator::FINISHED,
                                &method(:finished))
        end

        def started(result)
          @result = result
        end

        def finished(elapsed_time)
          command = self.class.command
          return if command.nil?

          title = "%s [%g%%] (%gs)" % [@result.status,
                                       @result.pass_percentage,
                                       elapsed_time]
          parameters = {
            :expire_time => 5,
            :icon => guess_suitable_icon,
            :urgency => urgency,
            :title => title,
            :message => @result.summary,
          }
          command.run(parameters)
        end

        private
        def guess_suitable_icon
          icon_dir = ICON_DIR + @theme
          status = @result.status
          icon_base_names = [status]
          if @result.passed?
            icon_base_names << "pass"
          else
            case status
            when "failure"
              icon_base_names << "error"
            when "error"
              icon_base_names << "failure"
            end
          end
          icon_base_names << "default"
          icon_base_names.each do |base_name|
            icon = icon_dir + "#{base_name}.png"
            return icon if icon.exist?
          end
          nil
        end

        def urgency
          if @result.passed?
            "normal"
          else
            "critical"
          end
        end
      end
    end
  end
end
