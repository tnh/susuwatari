require "susuwatari/version"
require 'susuwatari/result'
require 'json'
require 'rest_client'
require 'forwardable'

class Susuwatari
  extend Forwardable

  attr_accessor :options, :response

  def_delegator :@result, :status

  TEST_URL = 'http://www.webpagetest.org/runtest.php'

  def initialize( options = {} )
    options.fetch(:k)
    options.fetch(:url)
    options[:f] = :json
    options[:runs] ||= 1
    options.delete(:r)
    self.options = options
  end

  def run
    @result = Result.new(RestClient.get TEST_URL, :params => options, :accept => :json)
  end
end
