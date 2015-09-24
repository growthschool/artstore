require 'byebug/command'
require 'byebug/helpers/parse'

module Byebug
  #
  # Change byebug settings.
  #
  class SetCommand < Command
    include Helpers::ParseHelper

    self.allow_in_control = true

    def regexp
      /^\s* set (?:\s+(?<setting>\w+))? (?:\s+(?<value>\S+))? \s*$/x
    end

    def execute
      key = @match[:setting]
      value = @match[:value]
      return puts(help) if key.nil? && value.nil?

      setting = Setting.find(key)
      return errmsg(pr('set.errors.unknown_setting', key: key)) unless setting

      if !setting.boolean? && value.nil?
        err = pr('set.errors.must_specify_value', key: key)
      elsif setting.boolean?
        value, err = get_onoff(value, key =~ /^no/ ? false : true)
      elsif setting.integer?
        value, err = get_int(value, setting.to_sym, 1)
      end
      return errmsg(err) if value.nil?

      setting.value = value

      puts setting.to_s
    end

    def get_onoff(arg, default)
      return default if arg.nil?

      case arg
      when '1', 'on', 'true'
        true
      when '0', 'off', 'false'
        false
      else
        [nil, pr('set.errors.on_off', arg: arg)]
      end
    end

    def help
      description + Setting.help_all
    end

    def description
      <<-EOD
        set <setting> <value>

        Modifies parts of byebug environment.

        Boolean values take "on", "off", "true", "false", "1" or "0". If you
        don't specify a value, the boolean setting will be enabled. Conversely,
        you can use "set no<setting>" to disable them.

        You can see these environment settings with the "show" command.
      EOD
    end
  end
end
