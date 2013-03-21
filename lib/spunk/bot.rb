require 'socket'
require 'openssl'

module Spunk
  class Bot
    attr_accessor :nickname, :server, :joined_rooms, :ssl, :server, :rooms, :token
    attr_reader :processors, :request_processors, :response_processors, :hostname

    def initialize(options = {})
      options.each do |option, value|
        instance_variable_set("@#{option}", value)
      end
      @token = options[:token] || nil
      @ssl = options[:ssl] || false
      @processors =  []
      @request_processors = []
      @response_processors = []
      @joined_rooms = []
      @hostname = Socket.gethostname
      @server ||= { :hostname => options[:hostname] || "localhost", :port => options[:port] || 6667 }
      add_request_processor(Spunk::Processor::Ping.new)
      add_request_processor(Spunk::Processor::Base.new)
      @rooms = options[:rooms] ||= []
    end

    def start
      loop do
        @buffer ||= ""
        if @ssl
          @buffer += @socket.gets
        else
          @buffer += @socket.recv(1024)
        end
        messages = @buffer.split(/\r|\n/).collect { |s| s != "" && !s.nil? ? s : nil }.compact
        if messages.any?
          last_character = @buffer[-1..-1]
          @buffer = if ["\n", "\r"].include?(last_character)
            ""
          else
            messages.pop.to_s
          end

          messages.each do |message|
            message.strip!
            process_request(*parse_message(message))
          end
        end
        sleep 0.25
      end
    end
    
    def setup_connection
      connect
      authenticate
      @rooms.each { |room| join_room room }
    end
    
    def run
      setup_connection
      start
    end

    def parse_message(message)
      prefix, message = if message =~ /^\:([^\ ]*) (.*)/
        message.scan(/^\:([^\ ]*) (.*)/)[0]
      else
        [ nil, message ]
      end

      command, parameters = message.split(/\:/, 2)
      [ prefix, command, parameters ].map! { |s| s && s.strip }
    end

    def process_request(prefix, command, parameters)
      origin = if !prefix.nil? && prefix != ""
        Origin.new(prefix)
      end

      (@request_processors + @processors).each do |processor|
        begin
          processor.call(self, origin, command, parameters)
        rescue => e
          puts e.class.name + ": " + e.message
          puts e.backtrace.join("\n")
        end
      end
    end

    def process_response(origin, command, parameters)
      (@response_processors + @processors).each do |processor|
        begin
          processor.call(self, origin, command, parameters)
        rescue => e
          puts e.class.name + ": " + e.message
          puts e.backtrace.join("\n")
        end
      end
      @socket.print("#{command} :#{parameters}\r\n")
    end

    def origin
      @origin ||= Origin.new("#{@nickname}!#{@username}@#{@hostname}")
    end

    def add_request_processor(processor = nil, &block)
      @request_processors << (processor || block)
    end

    def add_response_processor(processor = nil, &block)
      @response_processors << (processor || block)
    end

    def add_processor(processor = nil, &block)
      @processors << (processor || block)
    end

    def connect
      @socket = TCPSocket.new(@server[:hostname], @server[:port])
      if @ssl == true
        @ssl_context = OpenSSL::SSL::SSLContext.new()
        @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
        @socket = OpenSSL::SSL::SSLSocket.new(@socket, @ssl_context)
        @socket.sync_close = true
        @socket.connect
      end
      trap("INT") do
        @socket.close
      end
      trap("KILL") do
        @socket.close
      end
    end

    def authenticate
      unless @token.nil?
        send_message "PASS #{@token}"
      end
      send_message "NICK #{@nickname}"
      send_message "USER #{@username} #{@hostname} bla :#{@fullname}"
    end

    def join_room(room, password = nil)
      @joined_rooms << room
      @joined_rooms.uniq!
      send_message("JOIN #{room}" + (password ? " #{password}" : ""))
    end

    def say(to, message)
      send_message "PRIVMSG #{to} :#{message}"
    end

    def send_message(message)
      command, parameters = message.strip.split(/\:/, 2)
      process_response(origin, command.to_s.strip, parameters)
    end
  end
end