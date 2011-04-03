module Payday

  # Configuration for Payday. This is a singleton, so to set the company_name you would call
  # Payday::Config.default.company_name = "Awesome Corp".
  class Config
    attr_accessor :invoice_logo, :company_name, :company_details, :date_format, :date_formatter, :currency

    # Sets the page size to use. See the
    # {http://prawn.majesticseacreature.com/docs/0.10.2/Prawn/Document/PageGeometry.html Prawn documentation} for valid
    # page_size values.
    attr_accessor :page_size

    # Returns the default configuration instance
    def self.default
      @@default ||= new
    end

    private
      def initialize
        self.invoice_logo = File.join(File.dirname(__FILE__), "..", "..", "assets", "default_logo.png")
        self.company_name = "Awesome Corp"
        self.company_details = "awesomecorp@commondream.net"
        self.date_format = "%B %e, %Y"
        self.date_formatter = lambda do |value|
          if value.is_a?(Date) or value.is_a?(Time)
            value.strftime(date_format)
          else
            value.to_s
          end
        end
        self.currency = "USD"
        self.page_size = "LETTER"
      end
  end
end
