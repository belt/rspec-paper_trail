if defined? World
  module RspecPaperTrailCucumberSupport
    # :call-seq:
    # with_versioning
    #
    # enable versioning for specific blocks

    def with_versioning
      was_enabled = ::PaperTrail.enabled?
      ::PaperTrail.enabled = true
      begin
        yield
      ensure
        ::PaperTrail.enabled = was_enabled
      end
    end
  end
  World(RspecPaperTrailCucumberSupport
end
