require "charlock_holmes"

module HTML
  class Pipeline
    class UTF8Filter < TextFilter
      def call
        # The heuristics don't work well on short content. In this case
        # we just have to clean non-UTF8 bytes, replacing them with the
        # "�" character.
        if @text.bytesize < 25
          return CharlockHolmes::Converter.convert(@text, "UTF-8", "UTF-8")
        end

        detection = CharlockHolmes::EncodingDetector.detect(@text)
        encoding  = (detection && detection[:encoding]) || "UTF-8"

        if detection && encoding == "UTF-8"
          @text
        else
          CharlockHolmes::Converter.convert(@text, encoding, "UTF-8")
        end
      end
    end
  end
end
