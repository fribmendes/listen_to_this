require_relative "boot"

if $PROGRAM_NAME == __FILE__
  Listener.new.play_all
end
