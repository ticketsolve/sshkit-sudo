module SSHKit
  module Sudo
    module Backend
      module Abstract
        def capture(*args)
          # To ensure that we clean out the sudo part when the results are returned,
          # otherwise the commands will be corrupt.
          #
          super.gsub(/\[sudo\] password for \S+\:/, '')
        end

        private

        def create_command_and_execute(args, options)
          options[:interaction_handler] ||= SSHKit::Sudo::InteractionHandler.new
          command(args, options).tap { |cmd| execute_command!(cmd) }
        end
      end
    end
  end
end
