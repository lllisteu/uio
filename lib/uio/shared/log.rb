module UIO
  module Shared
    module Log

      def debug(message='')
      end

      alias info  debug
      alias warn  debug
      alias error debug
      alias fatal debug

    end
  end
end
